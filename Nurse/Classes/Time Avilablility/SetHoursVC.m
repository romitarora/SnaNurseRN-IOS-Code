//
//  SetHoursVC.m
//  Nurse
//
//  Created by one click IT consultany on 9/14/16.
//  Copyright © 2016 com.Oneclick.apps. All rights reserved.
//

#import "SetHoursVC.h"
#import "JSON1.h"
@interface SetHoursVC ()

@end

@implementation SetHoursVC
@synthesize strTitle;
- (void)viewDidLoad
{
    [super viewDidLoad];
    serviceCount = 0;
   //  [self hideTabBar:self.tabBarController];
    [self.navigationItem setHidesBackButton:YES];
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor=[UIColor grayColor];
    self.navigationItem.title = strTitle;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:globelColor}];
    
    UIImageView *bg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, viewHeight)];
    bg.image=[UIImage imageNamed:@"bg"];
    [self.view addSubview:bg];
    
    if (IS_IPHONE_4)
    {
        bg.image=[UIImage imageNamed:@"bg-ip-4.png"];
    }
    else if (IS_IPHONE_5)
    {
        bg.image=[UIImage imageNamed:@"bg-ip-5.png"];
    }
    else if (IS_IPHONE_6)
    {
        bg.image=[UIImage imageNamed:@"bg-ip-6.png"];
    }
    else
    {
        bg.image=[UIImage imageNamed:@"bg-ip-6plus.png"];
    }
    
    UIView * backView = [[UIView alloc] init];
     backView.frame = CGRectMake(0, 0, self.view.frame.size.width, viewHeight);
    backView.backgroundColor = [UIColor whiteColor];
    backView.alpha = 0.5;
    [self.view addSubview:backView];
    
    UIBarButtonItem * backbarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back icon"]
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(BackBtnClick)];
    self.navigationItem.leftBarButtonItem=backbarBtn;
    self.navigationItem.leftBarButtonItem.tintColor=globelColor;
    
    UIBarButtonItem * doneBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveBtnClick)];
    doneBtn.tintColor=globelColor;
    self.navigationItem.rightBarButtonItem = doneBtn;
    
    hoursArr = [[NSMutableArray alloc] init];
    
    hoursTbl=[[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, viewHeight-64)];
    hoursTbl.backgroundColor=[UIColor clearColor];
    hoursTbl.separatorStyle=NO;
    hoursTbl.delegate=self;
    hoursTbl.dataSource=self;
    hoursTbl.separatorStyle=UITableViewCellSeparatorStyleNone;
    hoursTbl.separatorColor=[UIColor clearColor];
    [self.view addSubview:hoursTbl];
    
     customerId = [[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
    
    strBarPrice = @"0";
    for (int j = 0; j<24; j++)
    {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        
        NSString * strHrs =[NSString stringWithFormat:@"%d",j];
         [dict setValue:strTitle forKey:@"day"];
         [dict setValue:customerId forKey:@"hotel_id"];
         [dict setValue:@"1" forKey:@"hour"];
         [dict setValue:@"0" forKey:@"hour_discount"];
         [dict setValue:@"Yes" forKey:@"hour_flag"];
         [dict setValue:@"0" forKey:@"hour_price"];
         [dict setValue:strHrs forKey:@"individual_hour"];
         [dict setValue:@"1" forKey:@"room_id"];
        
        [hoursArr addObject:dict];
    }
    
    [self getDaysWiseTimes];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarFrameWillChange:)name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
    
    
}
- (void)statusBarFrameWillChange:(NSNotification*)notification
{
    // respond to changes
    NSLog(@"STATUS BAR UPDATED");
    NSDictionary *statusBarDetail = [notification userInfo];
    NSValue *animationCurve = statusBarDetail[UIApplicationStatusBarFrameUserInfoKey];
    CGRect statusBarFrameBeginRect = [animationCurve CGRectValue];
    int statusBarHeight = (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication]statusBarOrientation])) ? statusBarFrameBeginRect.size.height : statusBarFrameBeginRect.size.width;
    
    if (statusBarHeight == 40)
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            hoursTbl.frame=CGRectMake(0,0, self.view.frame.size.width, viewHeight-64);
            
        }];
        
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            hoursTbl.frame=CGRectMake(0,0, self.view.frame.size.width, viewHeight-64);
            
        }];
        
    }
    // NSLog(@"status bar height  %d", statusBarHeight);
}

-(void) viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationBackgroundRefreshStatusDidChangeNotification object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
   // [self hideTabBar:self.tabBarController];
}
#pragma mark - Web Services
-(void)getDaysWiseTimes
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"isLogin"]isEqualToString:@"YES"])
    {
       
        customerId = [[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
        if ([customerId isEqualToString:@""]||customerId==nil)
        {
            
        }
        else
        {
            
            serviceCount = serviceCount +1;
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:customerId forKey:@"nurse_id"];
            [dict setValue:strTitle forKey:@"day"];
            
            NSLog(@"%@",dict);
            
            URLManager *manager = [[URLManager alloc] init];
            manager.commandName = @"getDaysWiseTimes";
            manager.delegate = self;//
            [manager urlCall:@"http://snapnurse.com/nurse/getDaysWiseTimes"withParameters:dict];
        }
    }
}
#pragma mark - ButtonAction
-(void)BackBtnClick
{
   // [self showTabBar:self.tabBarController];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)saveBtnClick
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"isLogin"]isEqualToString:@"YES"])
    {
        
        customerId = [[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
        if ([customerId isEqualToString:@""]||customerId==nil)
        {
            
        }
        else
        {
            serviceCount = serviceCount+1;
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
            
            NSString *StrHours = [hoursArr JSONRepresentation];
            StrHours = [StrHours stringByReplacingOccurrencesOfString:@"\n"
                                                               withString:@""];
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:customerId forKey:@"nurse_id"];
            [dict setValue:strTitle forKey:@"day"];
            [dict setValue:StrHours forKey:@"hour_data"];
            [dict setValue:strBarPrice forKey:@"bar_price"];
            
            NSLog(@"%@",dict);
            
            URLManager *manager = [[URLManager alloc] init];
            manager.commandName = @"saveDaysAvailable";
            manager.delegate = self;//
            [manager urlCall:@"http://snapnurse.com/nurse/saveDaysAvailable"withParameters:dict];
        }
    }
}

#pragma mark - URL Manager Delegates
-(void)onResult:(NSDictionary *)result
{
    serviceCount = 0;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    
    NSLog(@"The result is...%@", result);
    
    if([[result valueForKey:@"commandName"] isEqualToString:@"getDaysWiseTimes"])
    {
        if([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
        {
            if ([[[result objectForKey:@"result"] objectForKey:@"data"] count]>0)
            {
                hoursArr = [[NSMutableArray alloc] init];
                hoursArr =[[[result objectForKey:@"result"] objectForKey:@"data"]mutableCopy];
                NSLog(@"HoursArr %@",hoursArr);
                strBarPrice =[[result objectForKey:@"result"] objectForKey:@"bar_price"];
                [hoursTbl reloadData];
            }
            else
            {
                [hoursTbl reloadData];
            }
        }
        else
        {
           [hoursTbl reloadData];
        }
    }
    else if ([[result valueForKey:@"commandName"] isEqualToString:@"saveDaysAvailable"])
    {
        if([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
        {
            //[self showTabBar:self.tabBarController];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            
        }
    }
    
    
}
- (void)onError:(NSError *)error
{
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    
    //    [app hudEndProcessMethod];
    NSInteger ancode = [error code];
    
    if (ancode == -1009)
    {
        
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Error" message:@"There is no network connectivity. This application requires a network connection." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        
        [alert showWithAnimation:URBalertAnimationType];;
        
    }
    else if(ancode == -1001)
    {
        if (isError == NO)
        {
            isError = YES;
            URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Error" message:@"The request time out." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
            [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                [alertView hideWithCompletionBlock:^{
                    isError = NO;
                }];
            }];
            
            [alert showWithAnimation:URBalertAnimationType];;
            
        }
        else
        {
            
        }
        
    }
    else
    {
        //        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Booking" message:[error localizedDescription] cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        //        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        //         [alert showWithAnimation:URBalertAnimationType];;
    }
}

- (void)onNetworkError:(NSError *)error didFailWithCommandName:(NSString *)commandName
{
    NSLog(@"OnNetworkErrorCall");
    if (error.code == -1005)
    {
        if ([commandName isEqualToString:@"getDaysWiseTimes"])
        {
            if (serviceCount >=3)
            {
                serviceCount = 0;
                URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"" message:@"Something went wrong please try again later." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
                
                [alert showWithAnimation:URBalertAnimationType];;
            }
            else
            {
                [self getDaysWiseTimes];
            }
        }
        else if ([commandName isEqualToString:@"saveDaysAvailable"])
        {
            if (serviceCount >=3)
            {
                serviceCount = 0;
                URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"" message:@"Something went wrong please try again later." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
                
                [alert showWithAnimation:URBalertAnimationType];;
            }
            else
            {
                [self saveBtnClick];
            }
        }

    }
    
}
#pragma mark - UITableview Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [hoursArr count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* cellIdentifier = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    TimeAvilablilityCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[TimeAvilablilityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
    }
    cell.dayOnOffSwitch.frame = CGRectMake(tableView.frame.size.width-70, 10, 60, 30);
    [cell.dayOnOffSwitch addTarget:self action:@selector(btnSwitchClick:) forControlEvents:UIControlEventValueChanged];
    cell.dayOnOffSwitch.tag=indexPath.row;
    cell.seperaterLine.frame =CGRectMake(0, 49, tableView.frame.size.width, 1);
    id name = [[hoursArr objectAtIndex:indexPath.row] valueForKey:@"individual_hour"];
    NSString *nameStr = @"";
    if (name != [NSNull null])
    {
        nameStr = (NSString *)name;
    }
    else
    {
        nameStr=@"NA";
    }
    
    if ([nameStr isEqualToString:@""] || [nameStr isEqualToString:@"NA"])
    {
    }
    else
    {
        int time = [nameStr intValue];
        cell.titleLbl.text = [NSString stringWithFormat:@"%02d:00",time];
        
    }

    id hour = [[hoursArr objectAtIndex:indexPath.row] valueForKey:@"hour_flag"];
    NSString *hourStr = @"";
    if (hour != [NSNull null])
    {
        hourStr = (NSString *)hour;
    }
    else
    {
        hourStr=@"No";
    }
    
    if ([hourStr isEqualToString:@"Yes"])
    {
        [cell.dayOnOffSwitch setOn:YES];
    }
    else
    {
        [cell.dayOnOffSwitch setOn:NO];
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor=[UIColor whiteColor];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Switch Method
-(void)btnSwitchClick:(id)sender
{
    if ([[[hoursArr objectAtIndex:[sender tag]] valueForKey:@"hour_flag"] isEqualToString:@"Yes"])
    {
        
         [[hoursArr objectAtIndex:[sender tag]] setValue:@"No" forKey:@"hour_flag"];
    }
    else
    {
        [[hoursArr objectAtIndex:[sender tag]] setValue:@"Yes" forKey:@"hour_flag"];
    }
    [hoursTbl reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
