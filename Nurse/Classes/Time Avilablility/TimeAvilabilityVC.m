//
//  TimeAvilabilityVC.m
//  Nurse
//
//  Created by one click IT consultany on 9/14/16.
//  Copyright © 2016 com.Oneclick.apps. All rights reserved.
//

#import "TimeAvilabilityVC.h"
#import "TimeAvilablilityCell.h"
#import "SpecialDateVC.h"
@interface TimeAvilabilityVC ()

@end

@implementation TimeAvilabilityVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    serviceCount = 0;
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor=[UIColor grayColor];
    self.navigationItem.title = @"Time Availability";
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
    
    
    NSArray *items = [[NSArray alloc] initWithObjects:NSLocalizedString(@"Days", @"App"),NSLocalizedString( @"Special Date", @"App"),nil];
    
    tempDaysArr = [[NSMutableArray alloc] init];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setValue:@"Monday" forKey:@"day"];
    [dict setValue:@"0" forKey:@"hours"];
    [dict setValue:@"No" forKey:@"available"];
    
    NSMutableDictionary * dict1 = [[NSMutableDictionary alloc] init];
    [dict1 setValue:@"Tuesday" forKey:@"day"];
    [dict1 setValue:@"0" forKey:@"hours"];
    [dict1 setValue:@"No" forKey:@"available"];
    
    NSMutableDictionary * dict2 = [[NSMutableDictionary alloc] init];
    [dict2 setValue:@"Wednesday" forKey:@"day"];
    [dict2 setValue:@"0" forKey:@"hours"];
    [dict2 setValue:@"No" forKey:@"available"];
    
    NSMutableDictionary * dict3 = [[NSMutableDictionary alloc] init];
    [dict3 setValue:@"Thursday" forKey:@"day"];
    [dict3 setValue:@"0" forKey:@"hours"];
    [dict3 setValue:@"No" forKey:@"available"];
    
    NSMutableDictionary * dict4 = [[NSMutableDictionary alloc] init];
    [dict4 setValue:@"Friday" forKey:@"day"];
    [dict4 setValue:@"0" forKey:@"hours"];
    [dict4 setValue:@"No" forKey:@"available"];
    
    NSMutableDictionary * dict5 = [[NSMutableDictionary alloc] init];
    [dict5 setValue:@"Saturday" forKey:@"day"];
    [dict5 setValue:@"0" forKey:@"hours"];
    [dict5 setValue:@"No" forKey:@"available"];
    
    NSMutableDictionary * dict6 = [[NSMutableDictionary alloc] init];
    [dict6 setValue:@"Sunday" forKey:@"day"];
    [dict6 setValue:@"0" forKey:@"hours"];
    [dict6 setValue:@"No" forKey:@"available"];
    
    [tempDaysArr addObject:dict];
    [tempDaysArr addObject:dict1];
    [tempDaysArr addObject:dict2];
    [tempDaysArr addObject:dict3];
    [tempDaysArr addObject:dict4];
    [tempDaysArr addObject:dict5];
    [tempDaysArr addObject:dict6];
    
    specialDateArr = [[NSMutableArray alloc] init];
       
    segMentBtn = [[UISegmentedControl alloc] initWithItems:items];
    [segMentBtn addTarget:self action:@selector(segmenClicked:) forControlEvents:UIControlEventValueChanged];
    [segMentBtn setSelectedSegmentIndex:0];
    segMentBtn.frame = CGRectMake(20, 10, self.view.frame.size.width-40, 30);
    segMentBtn.layer.masksToBounds = YES;
    segMentBtn.layer.cornerRadius = 3.5f;
    [segMentBtn setTintColor:globelColor];
    segMentBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:segMentBtn];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"AvenirNextLTPro-Demi" size:13.0f]} forState:UIControlStateSelected];
    
    noticeLbl = [[UILabel alloc] init];
    noticeLbl.frame = CGRectMake(0,50, self.view.frame.size.width, viewHeight-64-49-50);
    noticeLbl.textColor = [UIColor blackColor];
    noticeLbl.textAlignment = NSTextAlignmentCenter;
    noticeLbl.backgroundColor =[UIColor clearColor];
    noticeLbl.hidden = YES;
    [self.view addSubview:noticeLbl];
    
    
    daysAndSpicialTbl=[[UITableView alloc]initWithFrame:CGRectMake(0,50, self.view.frame.size.width, viewHeight-64-49-50)];
    daysAndSpicialTbl.backgroundColor=[UIColor clearColor];
    daysAndSpicialTbl.separatorStyle=NO;
    daysAndSpicialTbl.delegate=self;
    daysAndSpicialTbl.dataSource=self;
    daysAndSpicialTbl.separatorStyle=UITableViewCellSeparatorStyleNone;
    daysAndSpicialTbl.separatorColor=[UIColor clearColor];
    [self.view addSubview:daysAndSpicialTbl];
    
    isFromDays = YES;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    daysArr =[[NSMutableArray alloc] init];
    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [addBtn setImage:[UIImage imageNamed:@"back icon"] forState:UIControlStateNormal];
    addBtn.frame = CGRectMake(self.view.frame.size.width-80, addHight, 50+30, 44);
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setTitle:@"Add" forState:UIControlStateNormal];
    addBtn.backgroundColor=[UIColor clearColor];
    [addBtn setTitleColor:globelColor forState:UIControlStateNormal];
    addBtn.tintColor = globelColor;
    AppDelegate * appw = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appw.window addSubview:addBtn];
    
    serviceCount = 0;
    if (segMentBtn.selectedSegmentIndex == 0)
    {
        isFromDays = YES;
        addBtn.hidden = YES;
        [self getAllDays];
    }
    else if (segMentBtn.selectedSegmentIndex == 1)
    {
        isFromDays = NO;
        addBtn.hidden = NO;
        [self getSpecialDateList];
        
    }
    [daysAndSpicialTbl reloadData];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [addBtn removeFromSuperview];
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
            
            addBtn.frame = CGRectMake(self.view.frame.size.width-80, 40, 50+30, 44);
            daysAndSpicialTbl.frame=CGRectMake(0,50, self.view.frame.size.width, viewHeight-64-49-50);
            
        }];
        
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            addBtn.frame = CGRectMake(self.view.frame.size.width-80, 20, 50+30, 44);
            daysAndSpicialTbl.frame=CGRectMake(0,50, self.view.frame.size.width, viewHeight-64-49-50);
            
        }];
        
    }
    // NSLog(@"status bar height  %d", statusBarHeight);
}

-(void) viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationBackgroundRefreshStatusDidChangeNotification object:nil];
}
-(void)segmenClicked:(id)sender
{
    UISegmentedControl * segment = (UISegmentedControl*)sender;
    
    serviceCount = 0;
    if (segment.selectedSegmentIndex == 0)
    {
        isFromDays = YES;
         addBtn.hidden = YES;
        [self getAllDays];
    }
    else if (segment.selectedSegmentIndex == 1)
    {
        isFromDays = NO;
         addBtn.hidden = NO;
        [self getSpecialDateList];
    }
    [daysAndSpicialTbl reloadData];
}
#pragma mark - Web Service
-(void)getAllDays
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"isLogin"]isEqualToString:@"YES"])
    {
        noticeLbl.text = @"";
        noticeLbl.hidden = YES;
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
         
            NSLog(@"%@",dict);
            
            URLManager *manager = [[URLManager alloc] init];
            manager.commandName = @"getDaysAvailability";
            manager.delegate = self;//
            [manager urlCall:@"http://snapnurse.com/nurse/getDaysAvailability"withParameters:dict];
        }
    }
    else
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Login !" message:@"Please login first." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        alert.tag=0;
        [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
         {
             [alertView hideWithCompletionBlock:
              ^{
                  
                  self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
                  [self.tabBarController setSelectedIndex:2];
                  self.tabBarController.selectedIndex=2;
                  [self.navigationController popToRootViewControllerAnimated:YES];
              }];
         }];
        [alert showWithAnimation:URBalertAnimationType];;
    }
}
-(void)makeDayOffWebService
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"isLogin"]isEqualToString:@"YES"])
    {
        noticeLbl.text = @"";
        noticeLbl.hidden = YES;
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
            [dict setValue:dayName forKey:@"day"];
            
            NSLog(@"%@",dict);
            
            URLManager *manager = [[URLManager alloc] init];
            manager.commandName = @"makeDayOff";
            manager.delegate = self;//
            [manager urlCall:@"http://snapnurse.com/nurse/makeDayOff"withParameters:dict];
        }
    }
    else
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Login !" message:@"Please login first." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        alert.tag=0;
        [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
         {
             [alertView hideWithCompletionBlock:
              ^{
                  
                  self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
                  [self.tabBarController setSelectedIndex:2];
                  self.tabBarController.selectedIndex=2;
                  [self.navigationController popToRootViewControllerAnimated:YES];
              }];
         }];
        [alert showWithAnimation:URBalertAnimationType];;
    }
}
-(void)getSpecialDateList
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"isLogin"]isEqualToString:@"YES"])
    {
        noticeLbl.text = @"";
        noticeLbl.hidden = YES;
        
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
            
            NSLog(@"%@",dict);
            
            URLManager *manager = [[URLManager alloc] init];
            manager.commandName = @"getSpecialDate";
            manager.delegate = self;//
            [manager urlCall:@"http://snapnurse.com/nurse/getSpecialDate"withParameters:dict];
        }
    }
    else
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Login !" message:@"Please login first." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        alert.tag=0;
        [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
         {
             [alertView hideWithCompletionBlock:
              ^{
                  
                  self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
                  [self.tabBarController setSelectedIndex:2];
                  self.tabBarController.selectedIndex=2;
                  [self.navigationController popToRootViewControllerAnimated:YES];
              }];
         }];
        [alert showWithAnimation:URBalertAnimationType];;
    }
}
-(void)deleteSpecialDate:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"isLogin"]isEqualToString:@"YES"])
    {
        
        selectedIndex = [sender tag];
        
        NSString * str = [NSString stringWithFormat:@"Are you sure you want to delete this special date ?"];
        
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Message" message:str cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        alert.tag=0;
        [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
         {
             [alertView hideWithCompletionBlock:^{
                 
                 if(buttonIndex==0)
                 {
                     noticeLbl.text = @"";
                     noticeLbl.hidden = YES;
                     customerId = [[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
                     if ([customerId isEqualToString:@""]||customerId==nil)
                     {
                         
                     }
                     else
                     {
                         CGPoint button1 = [sender convertPoint:CGPointZero toView:daysAndSpicialTbl];
                         NSIndexPath *indexPath = [daysAndSpicialTbl indexPathForRowAtPoint:button1];
                         
                         NSArray * temp =[[yearsKeysDict valueForKey:[specialYearArr objectAtIndex:indexPath.section]] allValues];
                         
                         NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"day" ascending:YES];
                         NSArray *descriptors=[NSArray arrayWithObject: descriptor];
                         NSArray *reverseOrder=[temp sortedArrayUsingDescriptors:descriptors];
                         
                         NSMutableDictionary * detailDict =[[NSMutableDictionary alloc] init];
                         detailDict = [reverseOrder objectAtIndex:indexPath.row];
                         
                         
                         [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
                         
                         deleteDict=[[NSMutableDictionary alloc]init];
                         [deleteDict setValue:customerId forKey:@"nurse_id"];
                         [deleteDict setValue:[detailDict valueForKey:@"day"] forKey:@"date"];
                          serviceCount = serviceCount+1;
                         NSLog(@"%@",deleteDict);
                         
                         URLManager *manager = [[URLManager alloc] init];
                         manager.commandName = @"deleteSpecialDate";
                         manager.delegate = self;//
                         [manager urlCall:@"http://snapnurse.com/nurse/deleteSpecialDate"withParameters:deleteDict];
                     }
                 }
                 else
                 {
                 }
             }];
         }];
        [alert showWithAnimation:URBalertAnimationType];;
        
        
    }
    else
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Login !" message:@"Please login first." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        alert.tag=0;
        [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
         {
             [alertView hideWithCompletionBlock:
              ^{
                  
                  self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
                  [self.tabBarController setSelectedIndex:2];
                  self.tabBarController.selectedIndex=2;
                  [self.navigationController popToRootViewControllerAnimated:YES];
              }];
         }];
        [alert showWithAnimation:URBalertAnimationType];;
    }
}
#pragma mark - Button Action
-(void)addBtnClick
{
    SpecialDateVC * view =[[SpecialDateVC alloc] init];
    view.strIsFrom = @"Add";
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
}
#pragma mark - URL Manager Delegates

-(void)onResult:(NSDictionary *)result
{
     serviceCount = 0;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    
    NSLog(@"The result is...%@", result);
    
    if([[result valueForKey:@"commandName"] isEqualToString:@"getDaysAvailability"])
    {
        if([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
        {
            NSArray * tempAddArr =[[NSArray alloc] init];
            
            if ([[[result objectForKey:@"result"] objectForKey:@"data"] count]>0)
            {
                tempAddArr=[[[result objectForKey:@"result"] objectForKey:@"data"] allValues];
                daysArr = [[NSMutableArray alloc] init];
                daysArr = [tempDaysArr mutableCopy];
                
                for (int j = 0; j<[tempAddArr count]; j++)
                {
                    for (int k = 0; k<[daysArr count]; k++)
                    {
                        if ([[[daysArr objectAtIndex:k] valueForKey:@"day"] isEqualToString:[[tempAddArr objectAtIndex:j] valueForKey:@"day"]])
                        {
                            [daysArr replaceObjectAtIndex:k withObject:[tempAddArr objectAtIndex:j]];
                            break;
                        }
                    }
                }
               
                NSLog(@"daysArr %@ ",daysArr);
                [daysAndSpicialTbl reloadData];
                noticeLbl.hidden = YES;
            }
            else
            {
                daysArr = [[NSMutableArray alloc] init];
                 [daysAndSpicialTbl reloadData];
                noticeLbl.hidden = NO;
                noticeLbl.text = @"No data found";
            }
        }
        else
        {
            daysArr = [[NSMutableArray alloc] init];
            [daysAndSpicialTbl reloadData];
            noticeLbl.hidden = NO;
            noticeLbl.text = @"No data found";
        }
    }
    else if (([[result valueForKey:@"commandName"] isEqualToString:@"makeDayOff"]))
    {
        if([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
        {
             [[daysArr objectAtIndex:selectedIndex] setValue:@"No" forKey:@"available"];
             [[daysArr objectAtIndex:selectedIndex] setValue:@"0" forKey:@"hours"];
             [daysAndSpicialTbl reloadData];
        }
        else
        {
            [daysAndSpicialTbl reloadData];
        }
    }
    else if (([[result valueForKey:@"commandName"] isEqualToString:@"getSpecialDate"]))
    {
        if([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
        {
            NSArray * tempAddArr =[[NSArray alloc] init];
            specialYearArr = [[NSMutableArray alloc] init];
            specialMonthArr = [[NSMutableArray alloc] init];
            if ([[[
                   result objectForKey:@"result"] objectForKey:@"data"] count]>0)
            {
                tempAddArr=[[[result objectForKey:@"result"] objectForKey:@"data"] allKeys];
                
                
                NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
                NSArray *descriptors=[NSArray arrayWithObject: descriptor];
                NSArray *reverseOrder=[tempAddArr sortedArrayUsingDescriptors:descriptors];
                
                [specialYearArr addObjectsFromArray:reverseOrder];
                
                
                yearsKeysDict = [[NSMutableDictionary alloc] init];
                yearsKeysDict =[[result valueForKey:@"result"] valueForKey:@"data"];
                [daysAndSpicialTbl reloadData];
                noticeLbl.hidden = YES;
            }
            else
            {
                noticeLbl.hidden = NO;
                noticeLbl.text = @"No data found";
                specialYearArr = [[NSMutableArray alloc] init];
                yearsKeysDict = [[NSMutableDictionary alloc] init];
                [daysAndSpicialTbl reloadData];
            }
            
        }
        else
        {
            noticeLbl.hidden = NO;
            noticeLbl.text = @"No data found";
            specialYearArr = [[NSMutableArray alloc] init];
            yearsKeysDict = [[NSMutableDictionary alloc] init];
            [daysAndSpicialTbl reloadData];
        }
    }
    else if (([[result valueForKey:@"commandName"] isEqualToString:@"deleteSpecialDate"]))
    {
        if([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
        {
            [self getSpecialDateList];
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
        noticeLbl.hidden = NO;
        noticeLbl.text = @"No data found";
        
        [alert showWithAnimation:URBalertAnimationType];;
        
    }
    else if(ancode == -1001)
    {
        if (isError == NO)
        {
            noticeLbl.hidden = NO;
            noticeLbl.text = @"No data found";
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
        if ([commandName isEqualToString:@"getDaysAvailability"])
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
                [self getAllDays];
            }
        }
        else if ([commandName isEqualToString:@"makeDayOff"])
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
                [self makeDayOffWebService];
            }
        }
        else if ([commandName isEqualToString:@"getSpecialDate"])
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
                [self getSpecialDateList];
            }
        }
        else if ([commandName isEqualToString:@"deleteSpecialDate"])
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
                [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
                serviceCount = serviceCount+1;
                
                NSLog(@"%@",deleteDict);
                
                URLManager *manager = [[URLManager alloc] init];
                manager.commandName = @"deleteSpecialDate";
                manager.delegate = self;//
                [manager urlCall:@"http://snapnurse.com/nurse/deleteSpecialDate"withParameters:deleteDict];
            }
        }
    }
}
#pragma mark - UITableview Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (isFromDays == YES)
    {
        return 1;
    }
    else
    {
         return [specialYearArr count];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isFromDays == YES)
    {
        return [daysArr count];
    }
    else
    {
        NSArray * temp =[[yearsKeysDict valueForKey:[specialYearArr objectAtIndex:section]] allValues];
        
        NSArray * temp1 = [NSArray new];
        NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"day" ascending:YES];
        NSArray *descriptors=[NSArray arrayWithObject: descriptor];
        NSArray *reverseOrder=[temp sortedArrayUsingDescriptors:descriptors];
        temp1 = reverseOrder;
        
      
        return [temp1 count];
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isFromDays == YES)
    {
        return 50;
    }
    else
    {
        return 80;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    UIView *  sectionHeader = [[UIView alloc]init];
    sectionHeader.frame = CGRectMake(10, 0, kScreenWidth-20, 30);
    sectionHeader.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:32.0f/255.0f blue:218.0f/255.0f alpha:0.8];
    
    if (isFromDays == YES)
    {
        sectionHeader.backgroundColor = [UIColor clearColor];
         return  sectionHeader;
    }
    else
    {
        
        UILabel * titleNameLbl = [[UILabel alloc]init];
        titleNameLbl.frame = CGRectMake(0, 0, sectionHeader.frame.size.width, 30);
        titleNameLbl.textColor = [UIColor whiteColor];
        titleNameLbl.textAlignment = NSTextAlignmentCenter;
        titleNameLbl.backgroundColor = [UIColor clearColor];
        titleNameLbl.font = [UIFont fontWithName:@"AvenirNextLTPro-Demi" size:12.5];
        [sectionHeader addSubview:titleNameLbl];
        
        NSString *strdate;
        
        id date ;
        
        date = [specialYearArr objectAtIndex:section];
        if (date != [NSNull null])
        {
            strdate = (NSString *)date;
            
            NSArray * temp = [strdate componentsSeparatedByString:@"-"];
           
            NSString * strMonth = [temp objectAtIndex:0];
            if ([strMonth isEqualToString:@"01"])
            {
                titleNameLbl.text=[NSString stringWithFormat:@"January %@",[temp objectAtIndex:1]];
            }
            else if ([strMonth isEqualToString:@"02"])
            {
                 titleNameLbl.text=[NSString stringWithFormat:@"February %@",[temp objectAtIndex:1]];
            }
            else if ([strMonth isEqualToString:@"03"])
            {
                 titleNameLbl.text=[NSString stringWithFormat:@"March %@",[temp objectAtIndex:1]];
            }
            else if ([strMonth isEqualToString:@"04"])
            {
                 titleNameLbl.text=[NSString stringWithFormat:@"April %@",[temp objectAtIndex:1]];
            }
            else if ([strMonth isEqualToString:@"05"])
            {
                 titleNameLbl.text=[NSString stringWithFormat:@"May %@",[temp objectAtIndex:1]];
            }
            else if ([strMonth isEqualToString:@"06"])
            {
                 titleNameLbl.text=[NSString stringWithFormat:@"June %@",[temp objectAtIndex:1]];
            }
            else if ([strMonth isEqualToString:@"07"])
            {
                 titleNameLbl.text=[NSString stringWithFormat:@"July %@",[temp objectAtIndex:1]];
            }
            else if ([strdate isEqualToString:@"08"])
            {
                 titleNameLbl.text=[NSString stringWithFormat:@"August %@",[temp objectAtIndex:1]];
            }
            else if ([strMonth isEqualToString:@"09"])
            {
                 titleNameLbl.text=[NSString stringWithFormat:@"September %@",[temp objectAtIndex:1]];
            }
            else if ([strMonth isEqualToString:@"10"])
            {
                 titleNameLbl.text=[NSString stringWithFormat:@"October %@",[temp objectAtIndex:1]];
            }
            else if ([strMonth isEqualToString:@"11"])
            {
                 titleNameLbl.text=[NSString stringWithFormat:@"November %@",[temp objectAtIndex:1]];
            }
            else if ([strMonth isEqualToString:@"12"])
            {
                titleNameLbl.text=[NSString stringWithFormat:@"December %@",[temp objectAtIndex:1]];
            }
           
        }
        else
        {
            strdate=@"NA";
            titleNameLbl.text=strdate;
        }
        
         return  sectionHeader;
    }
    
   
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
    
    cell.lblHrs.hidden = YES;
    if (isFromDays)
    {
        cell.seperaterLine.frame = CGRectMake(0, 49, tableView.frame.size.width, 1);
        cell.availableStatusLbl.hidden = YES;
        cell.detailLbl.hidden = YES;
        cell.dayOnOffSwitch.hidden = NO;
        cell.deleteImg.hidden = YES;
        cell.deleteDateBtn.hidden = YES;
        cell.titleLbl.text =[[daysArr objectAtIndex:indexPath.row] valueForKey:@"day"];
        cell.titleLbl.frame = CGRectMake(15, 10, 100, 30);
        cell.dayOnOffSwitch.frame = CGRectMake(tableView.frame.size.width-70, 10, 60, 30);
        
        if ([[[daysArr objectAtIndex:indexPath.row] valueForKey:@"available"] isEqualToString:@"Yes"])
        {
            [cell.dayOnOffSwitch setOn:YES];
        }
        else
        {
            [cell.dayOnOffSwitch setOn:NO];
        }
        
        id hour = [[daysArr objectAtIndex:indexPath.row]valueForKey:@"hours"];
        NSString *hourStr = @"";
        if (hour != [NSNull null])
        {
            hourStr = (NSString *)hour;
        }
        else
        {
            hourStr=@"NA";
        }
        
        if ([hourStr isEqualToString:@""]||[hourStr isEqualToString:@"NA"]||[hourStr isEqualToString:@"0"])
        {
            cell.lblHrs.hidden = NO;
            cell.lblHrs.frame = CGRectMake(120, 05, 80, 40);
            cell.lblHrs.text = @"Not Available";
        }
        else
        {
            cell.lblHrs.hidden = NO;
            cell.lblHrs.frame = CGRectMake(120, 05, 80, 40);
            cell.lblHrs.text = [NSString stringWithFormat:@"%@ HRS Available",hourStr];
        }
    }
    else
    {
        cell.availableStatusLbl.hidden = NO;
        cell.availableStatusLbl.textColor = [UIColor darkGrayColor];
        cell.availableStatusLbl.font =[UIFont boldSystemFontOfSize:12];
        cell.titleLbl.font =[UIFont boldSystemFontOfSize:14];
        cell.detailLbl.hidden = NO;
        cell.dayOnOffSwitch.hidden = YES;
        cell.deleteImg.hidden = NO;
        cell.deleteDateBtn.hidden = NO;
        cell.seperaterLine.frame = CGRectMake(0, 79, tableView.frame.size.width, 1);
        
        cell.titleLbl.frame = CGRectMake(15, 2.5, 100, 25);
        cell.availableStatusLbl.frame = CGRectMake(15, 25+2.5, 150, 25);
        cell.detailLbl.frame = CGRectMake(15, 50+2.5, tableView.frame.size.width-90, 25);
        
        
        cell.availableStatusLbl.text = @"Available for 2 Hrs";
        cell.deleteImg.frame =CGRectMake(tableView.frame.size.width-40, 28, 20, 24);
        cell.deleteDateBtn.frame =CGRectMake(tableView.frame.size.width-60, 0, 60, 80);
        [cell.deleteDateBtn addTarget:self action:@selector(deleteSpecialDate:) forControlEvents:UIControlEventTouchUpInside];
        cell.deleteDateBtn.tag = indexPath.row;
      
        
        NSArray * temp =[[yearsKeysDict valueForKey:[specialYearArr objectAtIndex:indexPath.section]] allValues];
        
        NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"day" ascending:YES];
        NSArray *descriptors=[NSArray arrayWithObject: descriptor];
        NSArray *reverseOrder=[temp sortedArrayUsingDescriptors:descriptors];
        
        dateKeysDict =[[NSMutableDictionary alloc] init];
        dateKeysDict = [reverseOrder objectAtIndex:indexPath.row];
       
        NSString *strdate;
        
        id date = [dateKeysDict valueForKey:@"day"];
        
        if (date != [NSNull null])
        {
            strdate = (NSString *)date;
            NSArray * startArr = [strdate componentsSeparatedByString:@" "];
            
            NSString *stryear;
            stryear=[startArr objectAtIndex:0];
            NSDateFormatter * dFrmt =[[NSDateFormatter alloc] init];
            [dFrmt setDateFormat:@"YYYY-MM-dd"];
            NSString * str1 =stryear;
            NSDate * startD =[dFrmt dateFromString:str1];
            [dFrmt setDateFormat:@"MM-dd-yyyy"];
            NSString *strdate1=[NSString stringWithFormat:@"%@",[dFrmt stringFromDate:startD]];
            cell.titleLbl.text=strdate1;
        }
        else
        {
            strdate=@"NA";
            cell.titleLbl.text=strdate;
        }
        
        id reason = [dateKeysDict valueForKey:@"reason"];
        NSString * strReason = @"";
        if (reason != [NSNull null])
        {
            strReason = (NSString *)reason;
            if ([strReason isEqualToString:@""]||[strReason isEqualToString:@"Please enter note here.."])
            {
                cell.detailLbl.text=@"";
            }
            else
            {
                cell.detailLbl.text=strReason;
            }
            
        }
        else
        {
            strReason=@"NA";
            cell.detailLbl.text=strReason;
        }
        
        
        id hours = [dateKeysDict valueForKey:@"hours"];
        NSString * strhours = @"";
        if (hours != [NSNull null])
        {
            strhours = (NSString *)hours;
            if ([strhours isEqualToString:@""]||[strhours isEqualToString:@"0"])
            {
                cell.availableStatusLbl.text=@"Not Available";
            }
            else
            {
                if ([strhours isEqualToString:@"1"])
                {
                    cell.availableStatusLbl.text=[NSString stringWithFormat:@"Available for %@ Hr",strhours];
                }
                else
                {
                    cell.availableStatusLbl.text=[NSString stringWithFormat:@"Available for %@ Hrs",strhours];
                }
            }
            
        }
        else
        {
            strhours=@"NA";
            cell.availableStatusLbl.text=strhours;
        }
        
      

    }
    
    [cell.dayOnOffSwitch addTarget:self action:@selector(btnSwitchClick:) forControlEvents:UIControlEventValueChanged];
    cell.dayOnOffSwitch.tag=indexPath.row;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor=[UIColor whiteColor];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isFromDays)
    {
        if ([[[daysArr objectAtIndex:indexPath.row] valueForKey:@"available"] isEqualToString:@"Yes"])
        {
            SetHoursVC * view =[[SetHoursVC alloc] init];
            view.strTitle = [[daysArr objectAtIndex:indexPath.row] valueForKey:@"day"];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
        else
        {
            NSString * str = [NSString stringWithFormat:@"Turn ON '%@' for set availability time. ",[[daysArr objectAtIndex:indexPath.row] valueForKey:@"day"]];
            
            URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Available " message:str cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
            [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
             {
                 [alertView hideWithCompletionBlock:^{
                     
                 }];
             }];
            [alert showWithAnimation:URBalertAnimationType];;
        }

    }
    else
    {
        NSArray * temp =[[yearsKeysDict valueForKey:[specialYearArr objectAtIndex:indexPath.section]] allValues];
        
        NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"day" ascending:YES];
        NSArray *descriptors=[NSArray arrayWithObject: descriptor];
        NSArray *reverseOrder=[temp sortedArrayUsingDescriptors:descriptors];
        
        dateKeysDict =[[NSMutableDictionary alloc] init];
        dateKeysDict = [reverseOrder objectAtIndex:indexPath.row];
        
        SpecialDateVC * view =[[SpecialDateVC alloc] init];
        view.strIsFrom = @"Edit";
        
        NSString *strdate;
        
        id date = [dateKeysDict valueForKey:@"day"];
        
        if (date != [NSNull null])
        {
            strdate = (NSString *)date;
            NSArray * startArr = [strdate componentsSeparatedByString:@" "];
            
            NSString *stryear;
            stryear=[startArr objectAtIndex:0];
            NSDateFormatter * dFrmt =[[NSDateFormatter alloc] init];
            [dFrmt setDateFormat:@"YYYY-MM-dd"];
            NSString * str1 =stryear;
            NSDate * startD =[dFrmt dateFromString:str1];
            [dFrmt setDateFormat:@"MM-dd-yyyy"];
            NSString *strdate1=[NSString stringWithFormat:@"%@",[dFrmt stringFromDate:startD]];
            view.strTitle = strdate1;
        }
        else
        {
            strdate=@"NA";
            view.strTitle = strdate;
        }
        view.strEditDate =[dateKeysDict valueForKey:@"day"];
        view.strDetail = [dateKeysDict valueForKey:@"reason"];
        view.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:view animated:YES];
    }
}

#pragma mark - Switch Method
-(void)btnSwitchClick:(id)sender
{
   // UISwitch *Switch =(UISwitch *)sender;
    
    if (isFromDays)
    {
        if ([[[daysArr objectAtIndex:[sender tag]] valueForKey:@"available"] isEqualToString:@"Yes"])
        {
           
            selectedIndex = [sender tag];
           
            NSString * str = [NSString stringWithFormat:@"Are you sure you want to make availability off for %@ ?",[[daysArr objectAtIndex:[sender tag]] valueForKey:@"day"]];
            
            URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Message" message:str cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];

            alert.tag=0;
            [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
             {
                 [alertView hideWithCompletionBlock:^{
                     
                     if(buttonIndex==0)
                     {
                          dayName =[[daysArr objectAtIndex:[sender tag]] valueForKey:@"day"];
                         [self makeDayOffWebService];
                     }
                     else
                     {
                     }
                 }];
             }];
            [alert showWithAnimation:URBalertAnimationType];;

            
           //
        }
        else
        {
            [[daysArr objectAtIndex:[sender tag]] setValue:@"Yes" forKey:@"available"];
            
             NSString * str = [NSString stringWithFormat:@"Set your availability time for '%@'.",[[daysArr objectAtIndex:[sender tag]] valueForKey:@"day"]];
            
            URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Available " message:str cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
            [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
            [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
             {
                 [alertView hideWithCompletionBlock:^{
                     if(buttonIndex==0)
                     {
                         SetHoursVC * view =[[SetHoursVC alloc] init];
                         view.strTitle = [[daysArr objectAtIndex:[sender tag]] valueForKey:@"day"];
                         view.hidesBottomBarWhenPushed = YES;
                         [self.navigationController pushViewController:view animated:YES];
                     }
                     else
                     {
                     }
                    
                 }];
             }];
            [alert showWithAnimation:URBalertAnimationType];;
        }
    }
    else
    {
        
    }
    
    
    [daysAndSpicialTbl reloadData];
    
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
