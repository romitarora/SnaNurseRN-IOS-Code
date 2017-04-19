//
//  BookDetail.m
//  Snuzo App
//
//  Created by Oneclick IT on 11/3/15.
//  Copyright © 2015 Oneclick IT. All rights reserved.
//

#import "BookDetail.h"
#import "AppDelegate.h"
#import "AHTagTableViewCell.h"
#import "NurseDetailCell.h"
#import "hoteldetailcell.h"
@interface BookDetail ()
{
    
}
@end

@implementation BookDetail
@synthesize HotelDetailArray,searchdetailarray,imageurl,pricearray,hotelname,strContact,strBOOKID,strLat,strlon,isfrombokking,cartDetails,strStaus,isFromPast,specializationArr,isFromAcceptReject,acceptRejectDict;

-(void)viewWillAppear:(BOOL)animated
{
//    if([strisfromAnimity isEqualToString:@"YES"])
//    {
//        [self.navigationController setNavigationBarHidden:NO animated:NO];
//        strisfromAnimity=@"NO";
//    }
//    else
//    {
//        [self.navigationController setNavigationBarHidden:NO animated:NO];
//    }
    
   // [self hideTabBar:self.tabBarController];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.title=@"Booking info";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:globelColor}];
}

-(void)viewWillDisappear:(BOOL)animated
{
    {
//        if ([strisfromAnimity isEqualToString:@"YES"])
//        {
//        }
//        else
//        {
//        }
        [self.navigationItem setHidesBackButton:YES];
       // [self showTabBar:self.tabBarController];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    serviceCount = 0;
    self.navigationItem.title=@"Booking info";
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:globelColor}];
    
    UIImageView *bg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, viewHeight)];
    bg.image=[UIImage imageNamed:@"bg"];
    //[self.view addSubview:bg];
    
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
    backView.frame = self.view.frame;
    backView.backgroundColor = [UIColor whiteColor];
    backView.alpha = 0.5;
  //  [self.view addSubview:backView];
    
    UIBarButtonItem * backbarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back icon"]
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(BackBtnClick)];
    self.navigationItem.leftBarButtonItem=backbarBtn;
    self.navigationItem.leftBarButtonItem.tintColor=globelColor;
    
    HotelDetailArray =[[NSMutableArray alloc]init];
    HotelDetailArray= [[cartDetails valueForKey:@"hotels"]mutableCopy];
   customerId = [[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
  /*  int yy;
    yy = 10;
    
    UILabel *lblBookId=[[UILabel alloc]initWithFrame:CGRectMake(30, yy, self.view.frame.size.width-60, 30)];
    lblBookId.textColor=[UIColor blackColor];
    lblBookId.textAlignment=NSTextAlignmentCenter;
    lblBookId.font=[UIFont systemFontOfSize:24.0];
    lblBookId.text=[NSString stringWithFormat:@"Booking id #%@",strBOOKID];
    [self.view addSubview:lblBookId];
    
   
    yy = yy + 30;
    
    UILabel *lblStatus=[[UILabel alloc]initWithFrame:CGRectMake(30, yy, self.view.frame.size.width-60, 30)];
    lblStatus.textColor=[UIColor blackColor];
    lblStatus.textAlignment=NSTextAlignmentCenter;
    lblStatus.font=[UIFont systemFontOfSize:14.0];
    lblStatus.text=[NSString stringWithFormat:@"Status:- %@",strStaus];
    [self.view addSubview:lblStatus];
    
    yy = yy + 35;
    
    lbltitle=[[UILabel alloc]initWithFrame:CGRectMake(0,yy, self.view.frame.size.width,21)];
    lbltitle.font=[UIFont boldSystemFontOfSize:18.0];
    lbltitle.textColor=[UIColor blackColor];
    lbltitle.textAlignment=NSTextAlignmentCenter;
    lbltitle.text=hotelname;
    lbltitle.font=[UIFont fontWithName:@"AvenirNextLTPro-Bold" size:18];
    [self.view addSubview:lbltitle];
    
    yy = yy + 31;*/
    
    imghotel =[[AsyncImageView alloc] init];
    imghotel.frame = CGRectMake(0, 0, self.view.frame.size.width, 210);
    imghotel.imageURL = [NSURL URLWithString:imageurl];
    if (![imageurl isEqual:[NSNull null]])
    {
        if ([imageurl isEqualToString:@"NA"])
        {
            
        }
        else
        {
            imghotel.imageURL = [NSURL URLWithString:imageurl];
        }
    }
    imghotel.backgroundColor =[UIColor clearColor];
    imghotel.contentMode = UIViewContentModeScaleAspectFit;
    
    [tblcontent removeFromSuperview];
    tblcontent=nil;
     tblcontent=[[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, viewHeight-64)];
    tblcontent.backgroundColor=[UIColor clearColor];
    tblcontent.separatorStyle=normal;
    tblcontent.delegate=self;
    tblcontent.dataSource=self;
    tblcontent.showsHorizontalScrollIndicator=NO;
    tblcontent.showsVerticalScrollIndicator=NO;
    [self.view addSubview:tblcontent];
    
    [tblcontent setTableHeaderView:imghotel];
    
    UINib *nib = [UINib nibWithNibName:@"AHTagTableViewCell" bundle:nil];
    [tblcontent registerNib:nib forCellReuseIdentifier:@"cell"];
    
    if (isFromAcceptReject)
    {
        tblcontent.frame=CGRectMake(0,0, self.view.frame.size.width, viewHeight-85-40);
        acceptBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        acceptBtn.frame=CGRectMake(0,viewHeight-64-40, self.view.frame.size.width/2, 40);
        [acceptBtn setTitle:@"Accept" forState:UIControlStateNormal];
        [acceptBtn setBackgroundColor:[UIColor colorWithRed:88.0f/255.0f green:155.0f/255.0f blue:18.0f/255.0f alpha:1]];
        [self.view addSubview:acceptBtn];
        [acceptBtn addTarget:self action:@selector(acceptBtnClick) forControlEvents:UIControlEventTouchUpInside];
        acceptBtn.titleLabel.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:18];
        
        rejectBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        rejectBtn.frame=CGRectMake(self.view.frame.size.width/2,viewHeight-64-40, self.view.frame.size.width/2, 40);
        [rejectBtn setTitle:@"Reject" forState:UIControlStateNormal];
        [rejectBtn setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:rejectBtn];
        [rejectBtn addTarget:self action:@selector(rejectBtnClick) forControlEvents:UIControlEventTouchUpInside];
        rejectBtn.titleLabel.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:18];

    }
    else
    {
        
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
            
            if (isFromAcceptReject)
            {
                tblcontent.frame=CGRectMake(0,0, self.view.frame.size.width, viewHeight-85-40);
                acceptBtn.frame=CGRectMake(0,viewHeight-64-40, self.view.frame.size.width/2, 40);
                rejectBtn.frame=CGRectMake(self.view.frame.size.width/2,viewHeight-64-40, self.view.frame.size.width/2, 40);
            }
            else
            {
                tblcontent.frame=CGRectMake(0,0, self.view.frame.size.width, viewHeight-85);
            }
        }];
        
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            if (isFromAcceptReject)
            {
                tblcontent.frame=CGRectMake(0,0, self.view.frame.size.width, viewHeight-85-40);
                acceptBtn.frame=CGRectMake(0,viewHeight-64-40, self.view.frame.size.width/2, 40);
                rejectBtn.frame=CGRectMake(self.view.frame.size.width/2,viewHeight-64-40, self.view.frame.size.width/2, 40);
            }
            else
            {
                tblcontent.frame=CGRectMake(0,0, self.view.frame.size.width, viewHeight-85);
            }
        }];
        
    }
    // NSLog(@"status bar height  %d", statusBarHeight);
}

-(void) viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationBackgroundRefreshStatusDidChangeNotification object:nil];
}
-(void)acceptBtnClick
{
    URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Message" message:@"Are you sure you want to accept this request?" cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
    alert.tag=0;
    [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
     {
         [alertView hideWithCompletionBlock:^{
             
             if(buttonIndex==0)
             {
                 [self acceptWebServiceCall];
                 
             }
             else
             {
                
             }
         }];
     }];
    [alert showWithAnimation:URBalertAnimationType];;
}
-(void)acceptWebServiceCall
{
    serviceCount = serviceCount +1;
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:[[acceptRejectDict valueForKey:@"booking_infos"]valueForKey:@"price"] forKey:@"amount"];
    [dict setValue:[[acceptRejectDict valueForKey:@"booking_infos"]valueForKey:@"hotel_id"] forKey:@"hotel_id"];
    [dict setValue:[[acceptRejectDict valueForKey:@"booking_infos"]valueForKey:@"customer_id"] forKey:@"customer_id"];
    [dict setValue:[[acceptRejectDict valueForKey:@"booking_infos"]valueForKey:@"stripe_customer_id"] forKey:@"stripe_customer_id"];
    [dict setValue:[[acceptRejectDict valueForKey:@"booking_infos"]valueForKey:@"booking_id"] forKey:@"booking_id"];
    [dict setValue:[[acceptRejectDict valueForKey:@"booking_infos"]valueForKey:@"check_in_date_time"] forKey:@"check_in_time"];
    [dict setValue:[[acceptRejectDict valueForKey:@"booking_infos"]valueForKey:@"check_out_date_time"] forKey:@"check_out_time"];
    [dict setValue:[[acceptRejectDict valueForKey:@"package_hours"]valueForKey:@"actual_hours"] forKey:@"duration"];
    
    NSLog(@"%@",dict);
    
    URLManager *manager = [[URLManager alloc] init];
    manager.commandName = @"acceptBooking";
    manager.delegate = self;//
    [manager urlCall:@"http://snapnurse.com/nurse/acceptBooking"withParameters:dict];
}
-(void)rejectBtnClick
{
    URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Message" message:@"Are you sure you want to reject this request?" cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
    alert.tag=0;
    [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
     {
         [alertView hideWithCompletionBlock:^{
             
             if(buttonIndex==0)
             {
                 [self rejectWebService];
             }
             else
             {
                 
             }
         }];
     }];
    [alert showWithAnimation:URBalertAnimationType];;
}
-(void)rejectWebService
{
    serviceCount = serviceCount +1;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:[[acceptRejectDict valueForKey:@"booking_infos"]valueForKey:@"booking_id"] forKey:@"booking_id"];
    [dict setValue:[[acceptRejectDict valueForKey:@"booking_infos"]valueForKey:@"hotel_id"] forKey:@"nurse_id"];
    
    NSLog(@"%@",dict);
    
    URLManager *manager = [[URLManager alloc] init];
    manager.commandName = @"rejectBooking";
    manager.delegate = self;//
    [manager urlCall:@"http://snapnurse.com/nurse/rejectBooking"withParameters:dict];

}
-(void)CancelClicked
{
    if ([customerId isEqualToString:@""]||customerId==nil)
    {
        
    }
    else
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"sign up" message:@"Are you sure to cancel booking " cancelButtonTitle:@"ok" otherButtonTitles:@"cancel", nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        alert.tag=0;
        [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
         {
             [alertView hideWithCompletionBlock:^{
                 if (buttonIndex==0)
                 {
                     serviceCount = serviceCount + 1;
                    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
                     NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                     [dict setObject:customerId forKey:@"login_user_id"];
                     [dict setObject:[[cartDetails valueForKey:@"booking_infos"]valueForKey:@"booking_id"] forKey:@"booking_id"];
                     URLManager *manager = [[URLManager alloc] init];
                     manager.commandName = @"CancleBooking";
                     manager.delegate = self;//
                     [manager urlCall:@"http://snapnurse.com/nurse/webservice/cancelBooking"withParameters:dict];
                 }
                 else
                 {
                     
                 }
             }];
         }];
         [alert showWithAnimation:URBalertAnimationType];;
        
        
    }
}
-(void)RateClicked
{
    /*strisfromAnimity=@"YES";
    RateVc *Rate=[[RateVc alloc]init];
    Rate.strHotelImage=[[cartDetails valueForKey:@"0"]valueForKey:@"hotel_image"];
    Rate.strId=[[cartDetails valueForKey:@"booking_infos"]valueForKey:@"hotel_id"];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:Rate];
    [self presentViewController:nav animated:YES completion:nil];*/
    
}
#pragma mark Address button clicked
-(void)AddressClicked:(id)sender
{
   /* strisfromAnimity=@"YES";
    MapClass *map=[[MapClass alloc]init];
    map.strlat=[[cartDetails valueForKey:@"hotels"]valueForKey:@"lat"];
    map.strlon=[[cartDetails valueForKey:@"hotels"]valueForKey:@"lon"];
    map.strname= [[cartDetails valueForKey:@"hotels"]valueForKey:@"hotel_name"];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:map];
    [self presentViewController:nav animated:YES completion:nil];*/
}


-(void)contactclick
{
     NSLog(@"Click");
    
    NSString *phNo = [HotelDetailArray valueForKey:@"telephone"];
    
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}


#pragma mark  --- Back btnClicked

-(void)BackBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark  --- WEBSERVICE URL

-(void)onResult:(NSDictionary *)result
{
    serviceCount = 0;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
     NSLog(@"The result is...%@", result);
     if([[result valueForKey:@"commandName"] isEqualToString:@"CancleBooking"])
    {
        
        if ([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            
        }
    }
     else if ([[result valueForKey:@"commandName"] isEqualToString:@"rejectBooking"])
     {
         if([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
         {
             URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Message" message:@"Booking rejected successfully" cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
             alert.tag=0;
             [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
              {
                  [alertView hideWithCompletionBlock:^{
                      
                      if(buttonIndex==0)
                      {
                          [self.navigationController popViewControllerAnimated:YES];
                      }
                      else
                      {
                      }
                  }];
              }];
             [alert showWithAnimation:URBalertAnimationType];;
             
             //[notificationTbl reloadData];
         }
         else
         {
         }
     }
     else if ([[result valueForKey:@"commandName"] isEqualToString:@"acceptBooking"])
     {
         if([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
         {
             URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Message" message:@"Booking accepted successfully" cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
             alert.tag=0;
             [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
              {
                  [alertView hideWithCompletionBlock:^{
                      
                      if(buttonIndex==0)
                      {
                          [self.navigationController popViewControllerAnimated:YES];
                      }
                      else
                      {
                      }
                  }];
              }];
             [alert showWithAnimation:URBalertAnimationType];;
             // [notificationTbl reloadData];
         }
         else
         {
         }
     }
}
- (void)onError:(NSError *)error
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
        
    NSInteger ancode = [error code];
        
    if (ancode == -1009)
    {
            
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Booking" message:@"There is no network connectivity. This application requires a network connection." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
         [alert showWithAnimation:URBalertAnimationType];;
            
    }
    else if(ancode == -1001)
    {
        if (isError == NO)
        {
            isError = YES;
            URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Booking" message:@"The request time out." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
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
//            URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Booking" message:[error localizedDescription] cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//            [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
//            
//             [alert showWithAnimation:URBalertAnimationType];;
    }
        
        
}
    
- (void)onNetworkError:(NSError *)error didFailWithCommandName:(NSString *)commandName
{
    NSLog(@"OnNetworkErrorCall");
    if (error.code == -1005)
    {
        if ([commandName isEqualToString:@"CancleBooking"])
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
                serviceCount = serviceCount + 1;
                [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
                NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                [dict setObject:customerId forKey:@"login_user_id"];
                [dict setObject:[[cartDetails valueForKey:@"booking_infos"]valueForKey:@"booking_id"] forKey:@"booking_id"];
                URLManager *manager = [[URLManager alloc] init];
                manager.commandName = @"CancleBooking";
                manager.delegate = self;//
                [manager urlCall:@"http://snapnurse.com/nurse/webservice/cancelBooking"withParameters:dict];
            }
        }
        else if ([commandName isEqualToString:@"rejectBooking"])
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
                 [self rejectWebService];
            }
            
        }
        else if ([commandName isEqualToString:@"acceptBooking"])
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
                [self acceptWebServiceCall];
            }
            
        }
    }
}
#pragma mark  TAbleView Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return  30;
    }
    else if(indexPath.row==1)
    {
        return 30;
    }
    else if(indexPath.row==2)
    {
        return 30;
    }
    else if(indexPath.row==3)
    {
        return 30;
    }
    else if(indexPath.row==4)
    {
        return 30;
    }
    else if(indexPath.row==5)
    {
        return 30;
    }
    else if(indexPath.row==6)
    {
        return 30;
    }
    else if(indexPath.row==7)
    {
        return 150;
    }
    else
    {
        return 30;
    }
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 7)
    {
        return 150-20;
    }
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* cellIdentifier = nil;//[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    hoteldetailcell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[hoteldetailcell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle=normal;
        
    }
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"Hospital Details";
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
        
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = self.strHospitalName;
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = globelColor;
        cell.textLabel.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15];
        
    }
    else if (indexPath.row == 2)
    {
        cell.textLabel.text = @"Booking Info";
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    else if (indexPath.row == 3)
    {
        cell.lblNurseTitle.frame = CGRectMake(15, 0, 100, 30);
        cell.lblNurseTitle.backgroundColor = [UIColor clearColor];
        cell.lblNurseTitle.text = @"Name :";
        cell.lblNurseTitle.textColor = globelColor;
        cell.lblNurseTitle.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15];
        
        cell.lblNurseName.frame = CGRectMake(120, 0, tblcontent.frame.size.width-130, 30);
        cell.lblNurseName.backgroundColor = [UIColor clearColor];
        cell.lblNurseName.text = hotelname;
        cell.lblNurseName.textColor = [UIColor blackColor];
        cell.lblNurseName.textAlignment = NSTextAlignmentRight;
        cell.lblNurseName.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15];
        
    }
    else if (indexPath.row == 4)
    {
        cell.lblStatusTitle.frame = CGRectMake(15, 0, 100, 30);
        cell.lblStatusTitle.backgroundColor = [UIColor clearColor];
        cell.lblStatusTitle.text = @"Status :";
        cell.lblStatusTitle.textColor = globelColor;
        cell.lblStatusTitle.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15];
        
        cell.lblStatus.frame = CGRectMake(120, 0, tblcontent.frame.size.width-130, 30);
        cell.lblStatus.backgroundColor = [UIColor clearColor];
        cell.lblStatus.text = strStaus;
        cell.lblStatus.textColor = [UIColor blackColor];
        cell.lblStatus.textAlignment = NSTextAlignmentRight;
        cell.lblStatus.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15];
    }
    else if (indexPath.row == 5)
    {
        cell.lblbookingTitle.frame = CGRectMake(15, 0, 100, 30);
        cell.lblbookingTitle.backgroundColor = [UIColor clearColor];
        cell.lblbookingTitle.text = @"Booking ID :";
        cell.lblbookingTitle.textColor = globelColor;
        cell.lblbookingTitle.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15];
        
        cell.lblbookingDetail.frame = CGRectMake(120, 0, tblcontent.frame.size.width-130, 30);
        cell.lblbookingDetail.backgroundColor = [UIColor clearColor];
        cell.lblbookingDetail.text = [NSString stringWithFormat:@"%@",strBOOKID];;
        cell.lblbookingDetail.textColor = [UIColor blackColor];
        cell.lblbookingDetail.textAlignment = NSTextAlignmentRight;
        cell.lblbookingDetail.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15];
        
    }
    else if (indexPath.row == 6)
    {
        cell.textLabel.text = @"Booking Details";
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
        
    }
    else if (indexPath.row==7)
    {
        cell.Imgbad.hidden=YES;
        cell.lblpriceperhours.hidden=YES;
        int y=15;
        for (int k=1; k<=4; k++)
        {
            if (k==1)
            {
                cell.lblCheckinTime.frame=CGRectMake(40, y-1, tableView.frame.size.width-35, 20);
                cell.lblCheckinTime.textColor=globelColor;
                cell.lblCheckinTime.textAlignment=NSTextAlignmentLeft;
                cell.lblCheckinTime.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15];
                
                cell.imgcheckinimg.frame=CGRectMake(12,y, 16, 16);
                cell.imgcheckinimg.image=[UIImage imageNamed:@"date_white"];
                cell.lblCheckinTime.text=@"Start Date";
                
                cell.lblcheckinTimeDure.frame=CGRectMake(tableView.frame.size.width-80, y-1, 80, 20);
                cell.lblcheckinTimeDure.textColor=[UIColor blackColor];
                cell.lblcheckinTimeDure.font=[UIFont systemFontOfSize:15];
                cell.lblcheckinTimeDure.textAlignment=NSTextAlignmentLeft;
                cell.lblcheckinTimeDure.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:12];
                
                NSString *strdate;
                
                id date = [[cartDetails valueForKey:@"booking_infos"]valueForKey:@"check_in_date_time"];
               
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
                    cell.lblcheckinTimeDure.text=strdate1;
                }
                else
                {
                    strdate=@"NA";
                    cell.lblcheckinTimeDure.text=strdate;
                }
                
               
                
            }
            else if (k==2)
            {
                cell.lblcheckindateDure.frame=CGRectMake(40, y-1, tableView.frame.size.width-35, 20);
                cell.lblcheckindateDure.textColor=globelColor;
                cell.lblcheckindateDure.textAlignment=NSTextAlignmentLeft;
                cell.lblcheckindateDure.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15];
                cell.lblcheckindateDure.text=@"Start Time";
                
                cell.imgcheckindateimg.frame=CGRectMake(12,y, 16, 16);
                cell.imgcheckindateimg.image=[UIImage imageNamed:@"checkin-time.png"];
                
                cell.lblCheckindate.frame=CGRectMake(tableView.frame.size.width-80, y-1, 80, 20);
                cell.lblCheckindate.textColor=[UIColor blackColor];
                cell.lblCheckindate.font=[UIFont systemFontOfSize:15];
                cell.lblCheckindate.textAlignment=NSTextAlignmentLeft;
                cell.lblCheckindate.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:12];
               
                NSString *strdate;
                id date = [[cartDetails valueForKey:@"booking_infos"]valueForKey:@"check_in_date_time"];
                
                if (date != [NSNull null])
                {
                    strdate = (NSString *)date;
                    NSArray * startArr = [strdate componentsSeparatedByString:@" "];
                    
                    NSString *stryear;
                    stryear=[startArr objectAtIndex:0];
                    
                    
                    NSString *strTime=[startArr objectAtIndex:1];
                    NSString *dats1 = strTime;
                    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init] ;
                    [dateFormatter3 setDateStyle:NSDateFormatterMediumStyle];
                    [dateFormatter3 setDateFormat:@"HH:mm:ss"];
                    NSDate *date1 = [dateFormatter3 dateFromString:dats1];
                    
                    NSDateFormatter *formatter4 = [[NSDateFormatter alloc] init];
                    [formatter4 setDateFormat:@"hh:mm a"];
                    
                    strmianTime=[formatter4 stringFromDate:date1];
                    
                    NSString *strtime=strmianTime;
                    cell.lblCheckindate.text=strtime;
                }
                else
                {
                    strdate=@"NA";
                    cell.lblCheckindate.text=strdate;
                }
                
               
            }
            else if (k==3)
            {
                cell.lblcheckout.frame=CGRectMake(40, y-1, tableView.frame.size.width-35, 20);
                cell.lblcheckout.textColor=globelColor;
                cell.lblcheckout.textAlignment=NSTextAlignmentLeft;
                cell.lblcheckout.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15];
                cell.lblcheckout.text=@"End Time";
                cell.imgcheckout.frame=CGRectMake(12,y, 16, 16);
                cell.imgcheckout.image=[UIImage imageNamed:@"checkin-time.png"];
                cell.lblcheckouttime.frame=CGRectMake(tableView.frame.size.width-80, y-1, 80, 20);
                cell.lblcheckouttime.textColor=[UIColor blackColor];
                cell.lblcheckouttime.font=[UIFont systemFontOfSize:15];
                cell.lblcheckouttime.textAlignment=NSTextAlignmentLeft;
                cell.lblcheckouttime.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:12];
                
                NSString *strdate;
                id date = [[cartDetails valueForKey:@"booking_infos"]valueForKey:@"check_out_date_time"];
                
                if (date != [NSNull null])
                {
                    strdate = (NSString *)date;
                    
                    NSArray * startArr = [strdate componentsSeparatedByString:@" "];
                    
                    NSString *stryear;
                    stryear=[startArr objectAtIndex:0];
                    
                    
                    NSString *strTime=[startArr objectAtIndex:1];
                    NSString *dats1 = strTime;
                    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init] ;
                    [dateFormatter3 setDateStyle:NSDateFormatterMediumStyle];
                    [dateFormatter3 setDateFormat:@"HH:mm:ss"];
                    NSDate *date1 = [dateFormatter3 dateFromString:dats1];
                    
                    NSDateFormatter *formatter4 = [[NSDateFormatter alloc] init];
                    [formatter4 setDateFormat:@"hh:mm a"];
                    
                    strmianTime=[formatter4 stringFromDate:date1];
                    
                    NSString *strtime=strmianTime;
                    cell.lblcheckouttime.text=strtime;
                }
                else
                {
                    strdate=@"NA";
                    cell.lblcheckouttime.text=strdate;
                }
                
            }
            else if (k==4)
            {
                
                cell.lblDuration.frame=CGRectMake(40, y-1, tableView.frame.size.width-35, 20);
                cell.lblDuration.textColor=globelColor;
                cell.lblDuration.textAlignment=NSTextAlignmentLeft;
                cell.lblDuration.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15];
                cell.lblDuration.text=@"Duration";
                cell.imgduration.frame=CGRectMake(12,y, 16, 16);
                cell.imgduration.image=[UIImage imageNamed:@"duration.png"];
                cell.lbldurationTime.frame=CGRectMake(tableView.frame.size.width-80, y-1, 80, 20);
                cell.lbldurationTime.textColor=[UIColor blackColor];
                cell.lbldurationTime.font=[UIFont systemFontOfSize:15];
                cell.lbldurationTime.textAlignment=NSTextAlignmentLeft;
                cell.lbldurationTime.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:12];
                NSString *strdur = @"5 HRS";
                
                id time = [[cartDetails valueForKey:@"package_hours"]valueForKey:@"actual_hours"];
                
                if (time != [NSNull null])
                {
                    strdur = (NSString *)time;
                    if ([[cartDetails valueForKey:@"package_hours"]valueForKey:@"actual_hours"]==nil)
                    {
                        strdur =@"5 HRS";
                    }
                    else
                    {
                        strdur=[NSString stringWithFormat:@"%@ HRS",[[cartDetails valueForKey:@"package_hours"]valueForKey:@"actual_hours"]];
                    }
                    cell.lbldurationTime.text=strdur;
                }
                else
                {
                    strdur=@"NA";
                    cell.lbldurationTime.text=strdur;
                }
                
               
            }
            /*else if (k==5)
            {
                
                cell.lblprice.frame=CGRectMake(40, y-5, tableView.frame.size.width-35, 20);
                cell.lblprice.textColor=globelColor;
                cell.lblprice.font=[UIFont systemFontOfSize:12];
                cell.lblprice.text=@"0202 450 6788";
                cell.lblprice.textAlignment=NSTextAlignmentLeft;
                cell.lblprice.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15];
                cell.lblprice.text=@"Price";
                
                cell.ImgPrice.frame=CGRectMake(12,y, 16, 16);
                cell.ImgPrice.image=[UIImage imageNamed:@"price"];
                
                
                cell.lblpricevalue.frame=CGRectMake(tableView.frame.size.width-80, y-5, 80, 20);
                cell.lblpricevalue.textColor=[UIColor blackColor];
                cell.lblpricevalue.font=[UIFont systemFontOfSize:12];
                cell.lblpricevalue.textAlignment=NSTextAlignmentLeft;
                cell.lblpricevalue.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15];
                
                NSString *strprice;
                id card = [[cartDetails valueForKey:@"booking_infos"]valueForKey:@"price"];
                
                if (card != [NSNull null])
                {
                    strprice = (NSString *)card;
                    strprice =[NSString stringWithFormat:@"$%@",[[cartDetails valueForKey:@"booking_infos"]valueForKey:@"price"]];
                    price=[[[cartDetails valueForKey:@"booking_infos"]valueForKey:@"price"]integerValue];
                    
                    cell.lblpricevalue.text=strprice;
                }
                else
                {
                    strprice=@"NA";
                    
                    cell.lblpricevalue.text=strprice;
                }
            }*/
            y=y+12+15;
        }
        cell.lblline.backgroundColor=[UIColor lightGrayColor];
        cell.lblline.frame=CGRectMake(0,149-20, self.view.frame.size.width, 0.5);
    }
    return cell;
}
- (void)configureCell:(id)object atIndexPath:(NSIndexPath *)indexPath {
    //    if (![object isKindOfClass:[AHTagTableViewCell class]])
    //    {
    //        return;
    //    }
    AHTagTableViewCell *cell = (AHTagTableViewCell *)object;
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    cell.label.isFromBooking = YES;
    cell.label.tags = specializationArr;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 6)
    {
        cell.backgroundColor=[UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1.0f];
    }
    else
    {
        cell.backgroundColor=[UIColor clearColor];
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
