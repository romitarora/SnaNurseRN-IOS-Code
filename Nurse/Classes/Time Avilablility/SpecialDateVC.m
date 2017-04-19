//
//  SpecialDateVC.m
//  Nurse
//
//  Created by one click IT consultany on 9/14/16.
//  Copyright © 2016 com.Oneclick.apps. All rights reserved.
//

#import "SpecialDateVC.h"
#import "Constant.h"
#import "JSON1.h"
@interface SpecialDateVC ()
{
    int y;
}
@end

@implementation SpecialDateVC
@synthesize strIsFrom,strTitle,strDetail,strEditDate;
- (void)viewDidLoad
{
    [super viewDidLoad];
    serviceCount = 0;
    //[self hideTabBar:self.tabBarController];
    [self.navigationItem setHidesBackButton:YES];
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor=[UIColor grayColor];
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
    
     y = 50;
   
    UIImageView *imgDate =[[UIImageView alloc]initWithFrame:CGRectMake(10, y-11-3-11, self.view.frame.size.width-20, 39)];
    imgDate.image=[UIImage imageNamed:@"text-field.png"];
    imgDate.userInteractionEnabled=YES;
    
    [self.view addSubview:imgDate];
    
    UIImageView *Dateicon=[[UIImageView alloc]initWithFrame:CGRectMake(6, 7.5,22, 24)];
    Dateicon.image=[UIImage imageNamed:@"date"];
    [imgDate addSubview:Dateicon];
    
    UIImageView *downarreow=[[UIImageView alloc]initWithFrame:CGRectMake((imgDate.frame.size.width)-20,15.5, 14,8)];
    
    downarreow.image=[UIImage imageNamed:@"arrow.png"];
    [imgDate addSubview:downarreow];
    
    BtnarrivalDate=[UIButton buttonWithType:UIButtonTypeCustom];
    BtnarrivalDate.frame=CGRectMake(30, 0, imgDate.frame.size.width-20, 39);
    [BtnarrivalDate addTarget:self action:@selector(dateclick:) forControlEvents:UIControlEventTouchUpInside];
    BtnarrivalDate.tag = 1;
    
    DateTitle=[[UILabel alloc ]initWithFrame:CGRectMake(4, 0, BtnarrivalDate.frame.size.width,39)];
    
    DateTitle.text=@"Select From Date";
    DateTitle.textAlignment=NSTextAlignmentLeft;
    DateTitle.textColor=[UIColor blackColor];
    DateTitle.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13];
    [BtnarrivalDate addSubview:DateTitle];
    [imgDate addSubview:BtnarrivalDate];
    
     y = y + 50;
    
    imgToDate =[[UIImageView alloc]initWithFrame:CGRectMake(10, y-11-3-11, self.view.frame.size.width-20, 39)];
    imgToDate.image=[UIImage imageNamed:@"text-field.png"];
    imgToDate.userInteractionEnabled=YES;
    
    [self.view addSubview:imgToDate];
    
    UIImageView *ToDateicon=[[UIImageView alloc]initWithFrame:CGRectMake(6, 7.5,22, 24)];
    ToDateicon.image=[UIImage imageNamed:@"date"];
    [imgToDate addSubview:ToDateicon];
    
    UIImageView *arreow=[[UIImageView alloc]initWithFrame:CGRectMake((imgToDate.frame.size.width)-20,15.5, 14,8)];
    
    arreow.image=[UIImage imageNamed:@"arrow.png"];
    [imgToDate addSubview:arreow];
    
    toDateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    toDateBtn.frame=CGRectMake(30, 0, imgToDate.frame.size.width-20, 39);
    [toDateBtn addTarget:self action:@selector(dateclick:) forControlEvents:UIControlEventTouchUpInside];
    toDateBtn.tag = 2;
    toDateLbl=[[UILabel alloc ]initWithFrame:CGRectMake(4, 0, toDateBtn.frame.size.width,39)];
    
    toDateLbl.text=@"Select To Date";
    toDateLbl.textAlignment=NSTextAlignmentLeft;
    toDateLbl.textColor=[UIColor blackColor];
    toDateLbl.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13];
    [toDateBtn addSubview:toDateLbl];
    [imgToDate addSubview:toDateBtn];
    
    if ([strIsFrom isEqualToString:@"Add"])
    {
        imgDate.hidden = NO;
        imgToDate.hidden = YES;
        y = y + 30;
    }
    else
    {
        imgDate.hidden = YES;
        imgToDate.hidden = YES;
        y = 20;
    }
    
    
    txtNote = [[UITextView alloc] init];
    txtNote.frame = CGRectMake(0, y, self.view.frame.size.width, 100);
    txtNote.delegate = self;
    txtNote.textColor = [UIColor blackColor];
    txtNote.backgroundColor = [UIColor whiteColor];
//    txtNote.layer.cornerRadius = 5;
//    txtNote.layer.borderColor = globelColor.CGColor;
//    txtNote.layer.borderWidth = 1;
    [self.view addSubview:txtNote];
    
    if ([strIsFrom isEqualToString:@"Add"])
    {
        self.navigationItem.title = @"Add Special Date";
        txtNote.text = @"Please enter note here..";
    }
    else
    {
        self.navigationItem.title = strTitle;
        if (strDetail.length == 0)
        {
            txtNote.text = @"Please enter note here..";
        }
        else
        {
            txtNote.text = strDetail;
        }
        
        
        
    }
    
    y = y + 120;
    
    
    hoursTbl=[[UITableView alloc]initWithFrame:CGRectMake(0,y, self.view.frame.size.width, viewHeight-64-y-05)];
    hoursTbl.backgroundColor=[UIColor clearColor];
    hoursTbl.separatorStyle=NO;
    hoursTbl.delegate=self;
    hoursTbl.dataSource=self;
//    hoursTbl.layer.cornerRadius = 5;
//    hoursTbl.layer.borderColor = globelColor.CGColor;
//    hoursTbl.layer.borderWidth = 1;
    hoursTbl.separatorStyle=UITableViewCellSeparatorStyleNone;
    hoursTbl.separatorColor=[UIColor clearColor];
    [self.view addSubview:hoursTbl];

    if ([strIsFrom isEqualToString:@"Add"])
    {
        txtNote.hidden = YES;
        hoursTbl.hidden = YES;
    }
    else
    {
        txtNote.hidden = NO;
        hoursTbl.hidden = NO;
    }
    
    customerId = [[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
    
    hoursArr = [[NSMutableArray alloc] init];
    
    for (int j = 0; j<24; j++)
    {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        
        NSString * strHrs =[NSString stringWithFormat:@"%d",j];
        [dict setValue:customerId forKey:@"hotel_id"];
        [dict setValue:@"1" forKey:@"hour"];
        [dict setValue:@"0" forKey:@"hour_discount"];
        [dict setValue:@"No" forKey:@"hour_flag"];
        [dict setValue:@"0" forKey:@"hour_price"];
        [dict setValue:strHrs forKey:@"individual_hour"];
        [dict setValue:@"1" forKey:@"room_id"];
        
        [hoursArr addObject:dict];
    }
    if ([strIsFrom isEqualToString:@"Add"])
    {
        
    }
    else
    {
        [self getDaysWiseTimes];
    }
    
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
            
            hoursTbl.frame=CGRectMake(0,y, self.view.frame.size.width, viewHeight-64-y-05);
            
        }];
        
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            hoursTbl.frame=CGRectMake(0,y, self.view.frame.size.width, viewHeight-64-y-05);
            
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
    //[self hideTabBar:self.tabBarController];
}
#pragma mark - Web Service
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
            serviceCount = serviceCount+1;
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:customerId forKey:@"nurse_id"];
            [dict setValue:strEditDate forKey:@"date"];
            
            NSLog(@"%@",dict);
            
            URLManager *manager = [[URLManager alloc] init];
            manager.commandName = @"getTimeBasedOnSpecialDate";
            manager.delegate = self;//
            [manager urlCall:@"http://snapnurse.com/nurse/getTimeBasedOnSpecialDate"withParameters:dict];
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
    if ([strIsFrom isEqualToString:@"Add"])
    {
        if ([toDateLbl.text isEqualToString:@"Select To Date"])
        {
            ToSelectedDate = FromSelectedDate;
        }
        else
        {
            
        }

        
        if ([FromSelectedDate length]==0)
        {
            ToSelectedDate = FromSelectedDate;
            
            URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Error" message:@"Please select From Date" cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
            [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                [alertView hideWithCompletionBlock:^{
                    
                }];
            }];
            
            [alert showWithAnimation:URBalertAnimationType];

        }
        else
        {
            NSDateFormatter * dFrmt =[[NSDateFormatter alloc] init];
            [dFrmt setDateFormat:@"yyyy-MM-dd"];
            
            NSArray * tempArr = [[NSArray alloc]init];
            tempArr = [ToSelectedDate componentsSeparatedByString:@" "];
            NSString *endDate = [tempArr objectAtIndex:0];
            NSString * str1 =FromSelectedDate;
            NSString * str2 =endDate;
            //  NSString * todayDateStr =[dFrmt stringFromDate:[NSDate date]];
            
            NSDate * startD =[dFrmt dateFromString:str1];
            NSDate * endD =[dFrmt dateFromString:str2];
            // NSDate * todayDate =[dFrmt dateFromString:todayDateStr];
            
            
            if ([startD compare:endD] == NSOrderedDescending)
            {
                
                URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Error" message:@"TO date shoud be bigger then FROM date" cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
                [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                    [alertView hideWithCompletionBlock:^{
                        
                    }];
                }];
                
                [alert showWithAnimation:URBalertAnimationType];
            }
            else
            {
                [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
                
                NSString *StrHours = [hoursArr JSONRepresentation];
                StrHours = [StrHours stringByReplacingOccurrencesOfString:@"\n"
                                                               withString:@""];
                
                NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                [dict setValue:customerId forKey:@"nurse_id"];
                [dict setValue:FromSelectedDate forKey:@"from_date"];
                [dict setValue:ToSelectedDate forKey:@"to_date"];
                [dict setValue:StrHours forKey:@"hour_data"];
                
                serviceCount = serviceCount+1;
                if([txtNote.text isEqualToString:@"Please enter note here.."])
                {
                    [dict setValue:@"" forKey:@"reason"];
                }
                else
                {
                    [dict setValue:txtNote.text forKey:@"reason"];
                }
                
                URLManager *manager = [[URLManager alloc] init];
                manager.commandName = @"addSpecialDate";
                manager.delegate = self;//
                [manager urlCall:@"http://snapnurse.com/nurse/addSpecialDate"withParameters:dict];
            }
        }
       
    }
    else
    {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
        
        NSString *StrHours = [hoursArr JSONRepresentation];
        StrHours = [StrHours stringByReplacingOccurrencesOfString:@"\n"
                                                       withString:@""];
        
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setValue:customerId forKey:@"nurse_id"];
        [dict setValue:strEditDate forKey:@"from_date"];
        [dict setValue:strEditDate forKey:@"to_date"];
        [dict setValue:StrHours forKey:@"hour_data"];
        if([txtNote.text isEqualToString:@"Please enter note here.."])
        {
            [dict setValue:@"" forKey:@"reason"];
        }
        else
        {
            [dict setValue:txtNote.text forKey:@"reason"];
        }
        
        serviceCount = serviceCount+1;
        NSLog(@"%@",dict);
        
        URLManager *manager = [[URLManager alloc] init];
        manager.commandName = @"UpdateSpecialDate";
        manager.delegate = self;//
        [manager urlCall:@"http://snapnurse.com/nurse/updateSpecialDate"withParameters:dict];
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
#pragma mark - URL Manager Delegates
-(void)onResult:(NSDictionary *)result
{
    serviceCount = 0;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    
    NSLog(@"The result is...%@", result);
    
    if([[result valueForKey:@"commandName"] isEqualToString:@"getTimeBasedOnSpecialDate"])
    {
        if([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
        {
            if ([[[result objectForKey:@"result"] objectForKey:@"data"] count]>0)
            {
                hoursArr = [[NSMutableArray alloc] init];
                hoursArr =[[[result objectForKey:@"result"] objectForKey:@"data"]mutableCopy];
                NSLog(@"HoursArr %@",hoursArr);
                
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
   else if([[result valueForKey:@"commandName"] isEqualToString:@"addSpecialDate"])
    {
        if([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
        {
            //[self showTabBar:self.tabBarController];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            if ([[result valueForKey:@"result"]valueForKey:@"msg"] == nil){
                
                URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Error" message:@"something went wrong please try again later." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
                [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                    [alertView hideWithCompletionBlock:^{
                        
                    }];
                }];
                
                [alert showWithAnimation:URBalertAnimationType];;
            }
            else
            {
                NSString * str = [NSString stringWithFormat:@"%@",[[result valueForKey:@"result"]valueForKey:@"msg"]];
                if ([str isEqualToString:@"from date or to date is already added by you.please select different date"])
                {
                    URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Error" message:str cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
                    [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                        [alertView hideWithCompletionBlock:^{
                            
                        }];
                    }];
                    
                    [alert showWithAnimation:URBalertAnimationType];;
                }
                else
                {
                    URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Error" message:@"something went wrong please try again later." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
                    [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                        [alertView hideWithCompletionBlock:^{
                            
                        }];
                    }];
                    
                    [alert showWithAnimation:URBalertAnimationType];;
                }
            }
           
        }
    }
   else if([[result valueForKey:@"commandName"] isEqualToString:@"UpdateSpecialDate"])
   {
       if([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
       {
          // [self showTabBar:self.tabBarController];
           [self.navigationController popViewControllerAnimated:YES];
       }
       else
       {
          
           
                   URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Error" message:@"something went wrong please try again later." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                   [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
                   [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                       [alertView hideWithCompletionBlock:^{
                           
                       }];
                   }];
                   
                   [alert showWithAnimation:URBalertAnimationType];;
           
           
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
        if ([commandName isEqualToString:@"getTimeBasedOnSpecialDate"])
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
        else if ([commandName isEqualToString:@"addSpecialDate"])
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
        else if ([commandName isEqualToString:@"UpdateSpecialDate"])
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
#pragma mark - Show Arrival Date Picker
-(void)dateclick:(id)sender
{
    if ([sender tag] == 1)
    {
        isFromDateClick = YES;
    }
    else
    {
        isFromDateClick = NO;
    }
    if (isdateClick)
    {
        
    }
    else
    {
       
        [txtNote resignFirstResponder];
        [self ArrivalDateClick];
        
        [UIView animateWithDuration:0.25 animations:^{
            bgView.frame=CGRectMake(0,0, self.view.frame.size.width, viewHeight);
        }];
        isdateClick =YES;
    }
    
}
-(void)ArrivalDateClick
{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, viewHeight, self.view.frame.size.width, viewHeight)];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.alpha=1;
    [self.view addSubview:bgView];
    
    calVC = [[OCCalendarViewController alloc] initAtPoint:CGPointMake(0, 20) inView:self.view arrowPosition:OCArrowPositionNone];
    calVC.delegate = self;
    calVC.selectionMode = OCSelectionSingleDate;
    [bgView addSubview:calVC.view];
}
#pragma mark OCCalendarDelegate Methods

- (void)completedWithStartDate:(NSDate *)startDate2 endDate:(NSDate *)endDate
{
    
    isdateClick=NO;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterNoStyle];
    [df setTimeZone:[NSTimeZone systemTimeZone]];
    [df setDateFormat:@"MM-dd-yyyy"];
    searchDate=startDate2;
    NSLog(@"startDate:%@", [df stringFromDate:startDate2]);
    NSString *DateStr=[NSString stringWithFormat:@"%@",[df stringFromDate:startDate2]];
    
    if (isFromDateClick)
    {
        NSDateFormatter *dateFormate=[[NSDateFormatter alloc]init];
        [dateFormate setDateFormat:@"YYYY-MM-dd"];
        NSString * dateString = [dateFormate stringFromDate:startDate2];
        
        NSArray * temp = [dateString componentsSeparatedByString:@" "];
        
        FromSelectedDate = [NSString stringWithFormat:@"%@",[temp objectAtIndex:0]];
         NSLog(@"FromSelectedDate %@",FromSelectedDate);
        DateTitle.text=DateStr;
        
        if ([toDateLbl.text isEqualToString:@"Select To Date"])
        {
            toDateLbl.text=DateStr;
            ToSelectedDate = [NSString stringWithFormat:@"%@",[temp objectAtIndex:0]];
        }
        imgToDate.hidden = NO;
    }
    else
    {
        NSDateFormatter *dateFormate=[[NSDateFormatter alloc]init];
        [dateFormate setDateFormat:@"YYYY-MM-dd"];
        NSString * dateString = [dateFormate stringFromDate:startDate2];
        
        NSArray * temp = [dateString componentsSeparatedByString:@" "];
        
       ToSelectedDate = [NSString stringWithFormat:@"%@",[temp objectAtIndex:0]];
        
         NSLog(@"ToSelectedDate %@",ToSelectedDate);
        toDateLbl.text=DateStr;
        imgToDate.hidden = NO;
    }
    
    
   
    [calVC.view removeFromSuperview];
    calVC.delegate = nil;
    calVC = nil;
    [bgView removeFromSuperview];
    bgView =nil;
    txtNote.hidden = NO;
    hoursTbl.hidden = NO;
   
    
}
-(void) completedWithNoSelection
{
    isdateClick=NO;
    NSDateFormatter *formatter;
    NSString*dateString;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-YYYY"];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSString *currentTime = [dateFormatter1 stringFromDate:[NSDate date]];
    
    NSDate *mydate = [dateFormatter1 dateFromString:currentTime];
    NSTimeInterval secondsInEightHours = 1 * 60 * 60;
    
    NSDate *dateEightHoursAhead = [mydate dateByAddingTimeInterval:secondsInEightHours];
    
    currentTime = [dateFormatter1 stringFromDate:dateEightHoursAhead];
    
    searchDate =dateEightHoursAhead;
    
    NSDate * finalDate =[dateFormatter1 dateFromString:currentTime];
    
    dateString = [formatter stringFromDate:finalDate];
    
    if (isFromDateClick)
    {
         DateTitle.text=dateString;
        if ([toDateLbl.text isEqualToString:@"Select To Date"])
        {
            toDateLbl.text=dateString;
        }

        NSDateFormatter *dateFormate=[[NSDateFormatter alloc]init];
        [dateFormate setDateFormat:@"YYYY-MM-dd"];
        NSString * dateString = [dateFormate stringFromDate:mydate];
        
        NSArray * temp = [dateString componentsSeparatedByString:@" "];
        
        FromSelectedDate = [NSString stringWithFormat:@"%@",[temp objectAtIndex:0]];
        NSLog(@"FromSelectedDate %@",FromSelectedDate);
        
        if ([toDateLbl.text isEqualToString:@"Select To Date"])
        {
            ToSelectedDate = [NSString stringWithFormat:@"%@",[temp objectAtIndex:0]];
        }
        
        
        imgToDate.hidden = NO;
    }
    else
    {
        toDateLbl.text=dateString;
        NSDateFormatter *dateFormate=[[NSDateFormatter alloc]init];
        [dateFormate setDateFormat:@"YYYY-MM-dd"];
        NSString * dateString = [dateFormate stringFromDate:mydate];
        
        NSArray * temp = [dateString componentsSeparatedByString:@" "];
        
        ToSelectedDate = [NSString stringWithFormat:@"%@",[temp objectAtIndex:0]];
         NSLog(@"ToSelectedDate %@",ToSelectedDate);
        
        
        imgToDate.hidden = NO;
    }
    [calVC.view removeFromSuperview];
    calVC.delegate = nil;
    calVC = nil;
    [bgView removeFromSuperview];
    bgView =nil;
    
    txtNote.hidden = NO;
    hoursTbl.hidden = NO;
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Please enter note here.."])
    {
        txtNote.text=@"";
    }
   
}
- (void)textViewDidEndEditing:(UITextView *)theTextView
{
   
    if (theTextView==txtNote)
    {
        NSLog(@"textViewComments");
    }
    else if(theTextView==txtNote)
    {
        NSLog(@"CommentTextView");
    }
    if ([theTextView.text isEqualToString:@""])
    {
        txtNote.text=@"Please enter note here..";
    }
    else
    {
        
    }
}
- (void) textViewDidChange:(UITextView *)textView
{
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
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
