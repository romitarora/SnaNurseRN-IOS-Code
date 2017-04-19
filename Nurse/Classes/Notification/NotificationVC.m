//
//  NotificationVC.m
//  Nurse
//
//  Created by one click IT consultany on 8/17/16.
//  Copyright © 2016 com.Oneclick.apps. All rights reserved.
//

#import "NotificationVC.h"
#import "NurseDetailCell.h"
#import "NotificationListCell.h"
@interface NotificationVC ()
{
    int acceptCount, rejectCount;
    NSInteger acceptServerCount,rejectServerCount;
    UIActivityIndicatorView * indicatorFooter;
}
@end

@implementation NotificationVC

- (void)viewDidLoad
{
    acceptCount = 0;
    rejectCount = 0;
    serviceCount = 0;
    

    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor=[UIColor grayColor];
    self.navigationItem.title = @"Notifications";
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
    
    NSArray *items = [[NSArray alloc] initWithObjects:NSLocalizedString(@"Pending", @"App"),NSLocalizedString( @"Cancelled", @"App"),nil];
    
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
    
    pendingDateArr = [[NSMutableArray alloc] init];
    pendingDateDict = [[NSMutableDictionary alloc] init];
    
    cancelledDateArr = [[NSMutableArray alloc] init];
    cancelledDateDict = [[NSMutableDictionary alloc] init];

    
    notificationTbl=[[UITableView alloc]initWithFrame:CGRectMake(0,50, self.view.frame.size.width, viewHeight-64-49-50)];
    notificationTbl.backgroundColor=[UIColor clearColor];
    notificationTbl.separatorStyle=NO;
    notificationTbl.delegate=self;
    notificationTbl.dataSource=self;
    notificationTbl.separatorStyle=UITableViewCellSeparatorStyleNone;
    notificationTbl.separatorColor=[UIColor clearColor];
    [self.view addSubview:notificationTbl];
    
    pendingArr =[[NSMutableArray alloc] init];
   
    
    indicatorFooter = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(notificationTbl.frame), 44)];
    [indicatorFooter setColor:[UIColor blackColor]];
  //  [indicatorFooter startAnimating];//jam22-09
    [notificationTbl setTableFooterView:indicatorFooter];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    acceptCount = 0;//jam22-09
    rejectCount = 0;//jam22-09
    serviceCount = 0;
    if (segMentBtn.selectedSegmentIndex == 0)
    {
        isFromCancel = NO;
        pendingDateArr = [[NSMutableArray alloc] init];//jam22-09
        pendingDateDict = [[NSMutableDictionary alloc] init];//jam22-09
        [self getAllPendingList];
    }
    else if (segMentBtn.selectedSegmentIndex == 1)
    {
        isFromCancel = YES;
        cancelledDateArr = [[NSMutableArray alloc] init];//jam22-09
        cancelledDateDict = [[NSMutableDictionary alloc] init];//jam22-09
        [self getAllCancelledList];
    }
    [notificationTbl reloadData];
}
-(void)segmenClicked:(id)sender
{
    UISegmentedControl * segment = (UISegmentedControl*)sender;
    
    acceptCount = 0;//jam22-09
    rejectCount = 0;//jam22-09
    serviceCount = 0;
    if (segment.selectedSegmentIndex == 0)
    {
        isFromCancel = NO;
        pendingDateArr = [[NSMutableArray alloc] init];//jam22-09
        pendingDateDict = [[NSMutableDictionary alloc] init];//jam22-09
        [self getAllPendingList];
    }
    else if (segment.selectedSegmentIndex == 1)
    {
         isFromCancel = YES;
        cancelledDateArr = [[NSMutableArray alloc] init];//jam22-09
        cancelledDateDict = [[NSMutableDictionary alloc] init];//jam22-09
        [self getAllCancelledList];
    }
    [notificationTbl reloadData];
}
-(void)getAllPendingList
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
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
            serviceCount = serviceCount +1;
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:customerId forKey:@"nurse_id"];
            [dict setValue:[NSString stringWithFormat:@"%d",acceptCount] forKey:@"start"];
            NSLog(@"%@",dict);
            URLManager *manager = [[URLManager alloc] init];
            manager.commandName = @"getPendingRequest";
            manager.delegate = self;//
            [manager urlCall:@"http://snapnurse.com/nurse/getNursePendingBookings"withParameters:dict];
        }
    }
    else
    {
        noticeLbl.text = @"Please Login First";
        noticeLbl.hidden = NO;
    }

}
-(void)getAllCancelledList
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
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
             serviceCount = serviceCount +1;
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:customerId forKey:@"nurse_id"];
            [dict setValue:[NSString stringWithFormat:@"%d",rejectCount] forKey:@"start"];
            
            NSLog(@"%@",dict);
            
            URLManager *manager = [[URLManager alloc] init];
            manager.commandName = @"getNurseCancelled";
            manager.delegate = self;//
            [manager urlCall:@"http://snapnurse.com/nurse/getNurseCancelledBookings"withParameters:dict];
        }
    }
    else
    {
        noticeLbl.text = @"Please Login First";
        noticeLbl.hidden = NO;
    }
}
#pragma mark - UITableview Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (isFromCancel)
    {
        return cancelledDateArr.count;
    }
    else
    {
       return pendingDateArr.count;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isFromCancel)
    {
        NSInteger totalRows = [[cancelledDateDict valueForKey:[cancelledDateArr objectAtIndex:section]] count];
        return totalRows;
    }
    else
    {
       
        NSInteger totalRows = [[pendingDateDict valueForKey:[pendingDateArr objectAtIndex:section]] count];
       return totalRows;
    }
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
    
    UILabel * titleNameLbl = [[UILabel alloc]init];
    titleNameLbl.frame = CGRectMake(0, 0, sectionHeader.frame.size.width, 30);
    titleNameLbl.text =@"10 Aug 2016 ";
    ;
    titleNameLbl.textColor = [UIColor whiteColor];
    titleNameLbl.textAlignment = NSTextAlignmentCenter;
    titleNameLbl.backgroundColor = [UIColor clearColor];
    titleNameLbl.font = [UIFont fontWithName:@"AvenirNextLTPro-Demi" size:12.5];
    [sectionHeader addSubview:titleNameLbl];
    
    NSString *strdate;
    
    id date ;
    
    if (isFromCancel == YES)
    {
        date = [cancelledDateArr objectAtIndex:section];
    }
    else
    {
        date = [pendingDateArr objectAtIndex:section];
    }
    
    
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
        titleNameLbl.text=strdate1;
    }
    else
    {
        strdate=@"NA";
        titleNameLbl.text=strdate;
    }
    
    return  sectionHeader;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NotificationListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[NotificationListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
    }
    
    if (isFromCancel)
    {
        cell.msgLbl.text = @"cancelled your booking on";
        cell.msgLbl.frame = CGRectMake(70, 30, kScreenWidth-150, 30);
        cell.acceptBtn.hidden = YES;
        cell.rejectBtn.hidden = YES;
        cell.acceptLbl.hidden = YES;
        cell.rejectLbl.hidden = YES;
        cell.acceptImg.hidden = YES;
        cell.rejectImg.hidden = YES;
       
        NSDictionary * dict = [[cancelledDateDict valueForKey:[cancelledDateArr objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        
        id img = [[dict valueForKey:@"0"]valueForKey:@"hotel_image"];
        NSString *imgstr = @"";
        if (img != [NSNull null])
        {
            imgstr = (NSString *)img;
            NSURL *url = [NSURL URLWithString:imgstr];
            cell.profileImg.imageURL=url;
        }
        else
        {
        }
        
        id name = [[dict valueForKey:@"customers"]valueForKey:@"first_name"];
        NSString *nameStr = @"";
        if (name != [NSNull null])
        {
            nameStr = (NSString *)name;
            cell.titleLbl.text=[[dict valueForKey:@"customers"]valueForKey:@"first_name"];
        }
        else
        {
            cell.titleLbl.text=@"NA";
        }
        
        NSString *strdate;;
        NSString * strStartTime;
        NSString * strEndTime;
        
        id startTime = [[dict valueForKey:@"booking_infos"]valueForKey:@"check_in_date_time"];
        NSString *startTimeStr = @"";
        
        if (startTime != [NSNull null])
        {
            startTimeStr = (NSString *)startTime;
            strdate = startTimeStr;
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSLocale *twelveHourLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter1.locale = twelveHourLocale;
            NSDate *  stopTime1 = [formatter1 dateFromString:strdate];
            [formatter1 setDateFormat:@"dd MMM, hh a"];//Jam22-09
            
            strStartTime= [formatter1 stringFromDate:stopTime1];
            cell.lblStartTime.text = strStartTime;
        }
        else
        {
        }
        
        NSString *strEnddate;;
        
        id EndTime = [[dict valueForKey:@"booking_infos"]valueForKey:@"check_out_date_time"];
        NSString *EndTimeStr = @"";
        if (EndTime != [NSNull null])
        {
            EndTimeStr = (NSString *)EndTime;
            strEnddate = EndTimeStr;
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSLocale *twelveHourLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter1.locale = twelveHourLocale;
            NSDate *  stopTime1 = [formatter1 dateFromString:strEnddate];
            [formatter1 setDateFormat:@"dd MMM, hh a"];//Jam22-09
            strEndTime = [formatter1 stringFromDate:stopTime1];
            cell.lblEndTime.text = strEndTime;
        }
        else
        {
            
        }
        
    }
    else
    {
        cell.msgLbl.frame = CGRectMake(70, 30, kScreenWidth-180, 30);
        cell.acceptBtn.hidden = NO;
        cell.rejectBtn.hidden = NO;
        cell.acceptLbl.hidden = NO;
        cell.rejectLbl.hidden = NO;
        cell.acceptImg.hidden = NO;
        cell.rejectImg.hidden = NO;
        
        [cell.acceptBtn addTarget:self action:@selector(acceptBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rejectBtn addTarget:self action:@selector(rejectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString * strTag = [NSString stringWithFormat:@"%ld0%ld",(long)indexPath.section+1,(long)indexPath.row+1];
        
        NSInteger tagValue = [strTag integerValue];
        cell.acceptBtn.tag = tagValue;
        cell.rejectBtn.tag = tagValue;
        
        cell.acceptLbl.frame = CGRectMake(kScreenWidth-104, 35, 42, 20);
        cell.rejectLbl.frame = CGRectMake(kScreenWidth-52, 35,42, 20);
        cell.acceptLbl.textColor = [UIColor colorWithRed:88.0f/255.0f green:155.0f/255.0f blue:18.0f/255.0f alpha:1];
        cell.rejectLbl.textColor = [UIColor redColor];
        cell.acceptLbl.backgroundColor = [UIColor clearColor];
        cell.rejectLbl.backgroundColor = [UIColor clearColor];
        
        NSDictionary * dict = [[pendingDateDict valueForKey:[pendingDateArr objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        
        id img = [[dict valueForKey:@"0"]valueForKey:@"hotel_image"];
        NSString *imgstr = @"";
        if (img != [NSNull null])
        {
            imgstr = (NSString *)img;
            NSURL *url = [NSURL URLWithString:imgstr];
            cell.profileImg.imageURL=url;
        }
        else
        {
        }
        
        id name = [[dict valueForKey:@"customers"]valueForKey:@"first_name"];
        NSString *nameStr = @"";
        if (name != [NSNull null])
        {
            nameStr = (NSString *)name;
            cell.titleLbl.text=[[dict valueForKey:@"customers"]valueForKey:@"first_name"];
        }
        else
        {
            cell.titleLbl.text=@"NA";
        }
        
        NSString *strdate;;
        NSString * strStartTime;
        NSString * strEndTime;
        
        id startTime = [[dict valueForKey:@"booking_infos"]valueForKey:@"check_in_date_time"];
        NSString *startTimeStr = @"";
        
        if (startTime != [NSNull null])
        {
            startTimeStr = (NSString *)startTime;
            strdate = startTimeStr;
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSLocale *twelveHourLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter1.locale = twelveHourLocale;
            NSDate *  stopTime1 = [formatter1 dateFromString:strdate];
            [formatter1 setDateFormat:@"dd MMM, hh a"];
            
            strStartTime= [formatter1 stringFromDate:stopTime1];
            cell.lblStartTime.text = strStartTime;
        }
        else
        {
        }
        
        NSString *strEnddate;;
        
        id EndTime = [[dict valueForKey:@"booking_infos"]valueForKey:@"check_out_date_time"];
        NSString *EndTimeStr = @"";
        if (EndTime != [NSNull null])
        {
            EndTimeStr = (NSString *)EndTime;
            strEnddate = EndTimeStr;
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSLocale *twelveHourLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter1.locale = twelveHourLocale;
            NSDate *  stopTime1 = [formatter1 dateFromString:strEnddate];
            [formatter1 setDateFormat:@"dd MMM, hh a"];
            strEndTime = [formatter1 stringFromDate:stopTime1];
            cell.lblEndTime.text = strEndTime;
        }
        else
        {
        }
        
        cell.msgLbl.text = [NSString stringWithFormat:@"booked you for %@ Hrs on",[[dict valueForKey:@"package_hours"]valueForKey:@"actual_hours"]];
        
    }
    
    cell.lblduration.backgroundColor = globelColor;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor=[UIColor whiteColor];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookDetail *hotelDetail=[[BookDetail alloc]init];
    
    
    NSDictionary * dict;
    if (isFromCancel)
    {
        dict = [[cancelledDateDict valueForKey:[cancelledDateArr objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        hotelDetail.isFromAcceptReject = NO;
    }
    else
    {
         dict = [[pendingDateDict valueForKey:[pendingDateArr objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        hotelDetail.isFromAcceptReject = YES;
        hotelDetail.acceptRejectDict = [[pendingDateDict valueForKey:[pendingDateArr objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
       
    }
    
    id name = [[dict valueForKey:@"customers"]valueForKey:@"first_name"];
    NSString *nameStr = @"";
    if (name != [NSNull null])
    {
        nameStr = (NSString *)name;
        hotelDetail.hotelname=[[dict valueForKey:@"customers"]valueForKey:@"first_name"];
    }
    else
    {
        hotelDetail.hotelname=@"NA";
    }
    
    id img = [[dict valueForKey:@"0"]valueForKey:@"hotel_image"];
    NSString *imgStr = @"";
    if (img != [NSNull null])
    {
        imgStr = (NSString *)img;
       
    }
    else
    {
        imgStr=@"NA";
    }
    
    hotelDetail.imageurl=imgStr;
    hotelDetail.cartDetails=[dict mutableCopy];
    hotelDetail.strBOOKID=[[dict valueForKey:@"booking_infos"]valueForKey:@"booking_id"];
    
    id status = [[dict valueForKey:@"booking_infos"]valueForKey:@"status"];
    NSString *strstatus = @"";
    if (status != [NSNull null])
    {
        strstatus = (NSString *)status;
        
    }
    else
    {
        strstatus=@"NA";
    }
    
    id action = [[dict valueForKey:@"booking_infos"]valueForKey:@"action_by"];
    NSString *actionBy = @"";
    if (action != [NSNull null])
    {
        actionBy = (NSString *)action;
    }
    else
    {
        actionBy=@"NA";
    }

    
    if ([strstatus isEqualToString:@"0"]) {
        strstatus=@"Pending";
        hotelDetail.isFromPast=@"NO";
    }
    else if ([strstatus isEqualToString:@"1"])
    {
        strstatus=@"Booked";
        hotelDetail.isFromPast=@"NO";
    }
    else if ([strstatus isEqualToString:@"2"])
    {
        strstatus=@"Failed";
        hotelDetail.isFromPast=@"YES";
    }
    else if ([strstatus isEqualToString:@"5"])
    {
        strstatus=@"Completed";
        hotelDetail.isFromPast=@"YES";
        
    }
    else if([strstatus isEqualToString:@"3"])
    {
        strstatus=@"Cancelled";
        hotelDetail.isFromPast=@"YES";
    }
    hotelDetail.strStaus=strstatus;
    id specialization = [[dict valueForKey:@"0"]valueForKey:@"specialization"];
    
    NSString *specializationStr = @"";
    if (specialization != [NSNull null])
    {
        specializationStr = (NSString *)specialization;
        NSArray *items = [specializationStr componentsSeparatedByString:@","];
        hotelDetail.specializationArr = items;
    }
    else
    {
        hotelDetail.specializationArr = [NSArray new];
    }
    
     hotelDetail.strHospitalName = [NSString stringWithFormat:@"%@",[[dict valueForKey:@"hospitals"]valueForKey:@"first_name"]];
    hotelDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hotelDetail animated:YES];
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isFromCancel)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES - we will be able to delete all rows
    if (isFromCancel)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{

        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                              {
                                                  
                                                  URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Message" message:@"Are you sure you want to delete this notification" cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
                                                  [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
                                                  alert.tag=0;
                                                  [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
                                                   {
                                                       [alertView hideWithCompletionBlock:^{
                                                           
                                                           if(buttonIndex==0)
                                                           {
                                                               [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
                                                               selectedIndex = indexPath.row;
                                                               selectedSection = indexPath.section;
                                                               
                                                               NSDictionary * dict1 = [[cancelledDateDict valueForKey:[cancelledDateArr objectAtIndex:selectedSection]] objectAtIndex:selectedIndex];
                                                               
                                                               serviceCount = serviceCount =1;
                                                               deleteDict=[[NSMutableDictionary alloc]init];
                                                               [deleteDict setValue:[[dict1 valueForKey:@"booking_infos"]valueForKey:@"booking_id"] forKey:@"booking_id"];
                                                               NSLog(@"%@",deleteDict);
                                                               
                                                               URLManager *manager = [[URLManager alloc] init];
                                                               manager.commandName = @"deleteBooking";
                                                               manager.delegate = self;//
                                                               [manager urlCall:@"http://snapnurse.com/nurse/deleteBooking"withParameters:deleteDict];
                                                               
                                                           }
                                                           else
                                                           {
                                                           }
                                                       }];
                                                   }];
                                                  [alert showWithAnimation:URBalertAnimationType];;
                                              }];
        
        return @[deleteAction];
   
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Message" message:@"Are you sure you want to delete this notification" cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        alert.tag=0;
        [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
         {
             [alertView hideWithCompletionBlock:^{
                 
                 if(buttonIndex==0)
                 {
                     
                 }
                 else
                 {
                 }
             }];
         }];
        [alert showWithAnimation:URBalertAnimationType];;
        
    }
}

#pragma mark - Button Action
-(void)acceptBtnClick:(id)sender
{
   
    NSString * strTag =[NSString stringWithFormat:@"%ld", (long)[sender tag]];
    
    NSArray  * temp = [strTag componentsSeparatedByString:@"0"];
    
    selectedSection = [[temp objectAtIndex:0] integerValue];
    selectedIndex = [[temp lastObject] integerValue];
    
    if (selectedIndex == 1)
    {
        selectedIndex = 0;
    }
    else
    {
        selectedIndex = selectedIndex - 1;
    }
    
    if (selectedSection == 1)
    {
        selectedSection = 0;
    }
    else
    {
        selectedSection = selectedSection - 1;
    }
    
     NSLog(@"selectedIndex %ld and selected section %ld",selectedIndex,selectedSection);
    
    URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Message" message:@"Are you sure you want to accept this request?" cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
    alert.tag=0;
    [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
     {
         [alertView hideWithCompletionBlock:^{
             
             if(buttonIndex==0)
             {
                 
                 NSDictionary * dict1 = [[pendingDateDict valueForKey:[pendingDateArr objectAtIndex:selectedSection]] objectAtIndex:selectedIndex];
                 
                 
                 serviceCount = serviceCount +1;
                 [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
                 
                 acceptDict=[[NSMutableDictionary alloc]init];
                 [acceptDict setValue:[[dict1 valueForKey:@"booking_infos"]valueForKey:@"price"] forKey:@"amount"];
                 [acceptDict setValue:[[dict1 valueForKey:@"booking_infos"]valueForKey:@"hotel_id"] forKey:@"hotel_id"];
                 [acceptDict setValue:[[dict1 valueForKey:@"booking_infos"]valueForKey:@"customer_id"] forKey:@"customer_id"];
                 [acceptDict setValue:[[dict1 valueForKey:@"booking_infos"]valueForKey:@"stripe_customer_id"] forKey:@"stripe_customer_id"];
                 [acceptDict setValue:[[dict1 valueForKey:@"booking_infos"]valueForKey:@"booking_id"] forKey:@"booking_id"];
                 [acceptDict setValue:[[dict1 valueForKey:@"booking_infos"]valueForKey:@"check_in_date_time"] forKey:@"check_in_time"];
                 [acceptDict setValue:[[dict1 valueForKey:@"booking_infos"]valueForKey:@"check_out_date_time"] forKey:@"check_out_time"];
                 [acceptDict setValue:[[dict1 valueForKey:@"package_hours"]valueForKey:@"actual_hours"] forKey:@"duration"];
                 
                 NSLog(@"%@",acceptDict);
                 
                 URLManager *manager = [[URLManager alloc] init];
                 manager.commandName = @"acceptBooking";
                 manager.delegate = self;//
                 [manager urlCall:@"http://snapnurse.com/nurse/acceptBooking"withParameters:acceptDict];
             }
             else
             {
                 [notificationTbl reloadData];
             }
         }];
     }];
    [alert showWithAnimation:URBalertAnimationType];;
}
-(void)deleteAccept:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    [pendingArr removeObjectAtIndex:selectedIndex];
    [notificationTbl reloadData];
}
-(void)deletecancelled:(id)sender
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    [cancelledArr removeObjectAtIndex:selectedIndex];
    [notificationTbl reloadData];
}
-(void)rejectBtnClick:(id)sender
{
    NSLog(@"selectedIndex %ld",(long)[sender tag]);
    NSString * strTag =[NSString stringWithFormat:@"%ld", (long)[sender tag]];
    
    NSArray  * temp = [strTag componentsSeparatedByString:@"0"];
    
    selectedSection = [[temp objectAtIndex:0] integerValue];
    selectedIndex = [[temp lastObject] integerValue];
    
    if (selectedIndex == 1)
    {
        selectedIndex = 0;
    }
    else
    {
        selectedIndex = selectedIndex - 1;
    }
    
    if (selectedSection == 1)
    {
        selectedSection = 0;
    }
    else
    {
        selectedSection = selectedSection - 1;
    }
    
    NSLog(@"selectedIndex %ld and selected section %ld",selectedIndex,selectedSection);
    
    URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Message" message:@"Are you sure you want to reject this request?" cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
    alert.tag=0;
    [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
     {
         [alertView hideWithCompletionBlock:^{
             
             if(buttonIndex==0)
             {
                 
                NSDictionary * dict1 = [[pendingDateDict valueForKey:[pendingDateArr objectAtIndex:selectedSection]] objectAtIndex:selectedIndex];
                 
                 [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
                 
                 rejectDict=[[NSMutableDictionary alloc]init];
                 [rejectDict setValue:[[dict1 valueForKey:@"booking_infos"]valueForKey:@"booking_id"] forKey:@"booking_id"];
                 [rejectDict setValue:[[dict1 valueForKey:@"booking_infos"]valueForKey:@"hotel_id"] forKey:@"nurse_id"];
                 
                 NSLog(@"%@",rejectDict);
                 serviceCount = serviceCount+1;
                 
                 URLManager *manager = [[URLManager alloc] init];
                 manager.commandName = @"rejectBooking";
                 manager.delegate = self;//
                 [manager urlCall:@"http://snapnurse.com/nurse/rejectBooking"withParameters:rejectDict];
                
             }
             else
             {
                  [notificationTbl reloadData];
             }
         }];
     }];
    [alert showWithAnimation:URBalertAnimationType];;
}

#pragma mark - URL Manager Delegates

-(void)onResult:(NSDictionary *)result
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    [indicatorFooter stopAnimating];

    serviceCount = 0;
    NSLog(@"The result is...%@", result);
    
    if([[result valueForKey:@"commandName"] isEqualToString:@"getPendingRequest"])
    {
        if([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
        {
            NSArray * tempAddArr =[[NSArray alloc] init];
           
            acceptServerCount = [[[result objectForKey:@"result"] objectForKey:@"booked"] integerValue];

            
            if ([[[result objectForKey:@"result"] objectForKey:@"data"] count]>0)
            {
                tempAddArr=[[[result objectForKey:@"result"] objectForKey:@"data"] allKeys];
                
                NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
                NSArray *descriptors=[NSArray arrayWithObject: descriptor];
                NSArray *reverseOrder=[tempAddArr sortedArrayUsingDescriptors:descriptors];
                
                [pendingDateArr addObjectsFromArray:reverseOrder];
                [pendingDateDict addEntriesFromDictionary:[[result valueForKey:@"result"] valueForKey:@"data"]];
                 notificationTbl.hidden = NO;//jam22-09
                [notificationTbl reloadData];
                noticeLbl.hidden = YES;
            }
            else
            {
                //jam22-09
                if(acceptCount == 0)
                {
                    noticeLbl.hidden = NO;
                    noticeLbl.text = @"No data found";
                    pendingDateArr = [[NSMutableArray alloc] init];
                    pendingDateDict = [[NSMutableDictionary alloc] init];
                    [notificationTbl reloadData];

                }
                else
                {
                    noticeLbl.hidden = NO;
                    noticeLbl.text = @"No data found";
                   // pendingDateArr = [[NSMutableArray alloc] init];
                  //  pendingDateDict = [[NSMutableDictionary alloc] init];
                    [notificationTbl reloadData];
                }
            }
            
        }
        else
        {
            noticeLbl.hidden = YES;
            
            [notificationTbl reloadData];
            if(acceptCount == 0)
            {
                noticeLbl.hidden = NO;
                noticeLbl.text = @"No data found";//jam22-09
            }
            else
            {
                noticeLbl.hidden = YES;
                
            }
        }
    }
    else if ([[result valueForKey:@"commandName"] isEqualToString:@"getNurseCancelled"])
    {
        if([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
        {
            rejectServerCount = [[[result objectForKey:@"result"] objectForKey:@"booked"] integerValue];

            NSArray * tempAddArr =[[NSArray alloc] init];
            
            if ([[[result objectForKey:@"result"] objectForKey:@"data"] count]>0)
            {
                tempAddArr=[[[result objectForKey:@"result"] objectForKey:@"data"] allKeys];
                
                NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
                NSArray *descriptors=[NSArray arrayWithObject: descriptor];
                NSArray *reverseOrder=[tempAddArr sortedArrayUsingDescriptors:descriptors];
                
                [cancelledDateArr addObjectsFromArray:reverseOrder];
                [cancelledDateDict addEntriesFromDictionary:[[result valueForKey:@"result"] valueForKey:@"data"]];

                notificationTbl.hidden = NO;//jam22-09
                noticeLbl.hidden = YES;
                [notificationTbl reloadData];
            }
            else
            {
                if(rejectCount == 0)//jam22-09
                {
                    noticeLbl.hidden = NO;
                    noticeLbl.text = @"No data found";
                    cancelledDateArr = [[NSMutableArray alloc] init];
                    cancelledDateDict = [[NSMutableDictionary alloc] init];
                    [notificationTbl reloadData];
                }
                else
                {
                    noticeLbl.hidden = NO;
                    noticeLbl.text = @"No data found";
                   // cancelledDateArr = [[NSMutableArray alloc] init];
                   // cancelledDateDict = [[NSMutableDictionary alloc] init];
                    [notificationTbl reloadData];
                }
                
            }
        }
        else
        {
            noticeLbl.hidden = YES;
            
            [notificationTbl reloadData];
            
            if(rejectCount == 0)//jam22-09
            {
                noticeLbl.hidden = NO;
                noticeLbl.text = @"No data found";//jam22-09
            }
            else
            {
                noticeLbl.hidden = YES;
            }
        }
    }
    else if ([[result valueForKey:@"commandName"] isEqualToString:@"rejectBooking"])
    {
        if([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
        {
            //start jam22-09 changed for remove index from dict and arr.
            [[pendingDateDict valueForKey:[pendingDateArr objectAtIndex:selectedSection]] removeObjectAtIndex:selectedIndex];
            
            if ([[pendingDateDict valueForKey:[pendingDateArr objectAtIndex:selectedSection]] count]>0)
            {
                
            }
            else
            {
                [pendingDateDict removeObjectForKey:[pendingDateArr objectAtIndex:selectedSection]];
                 [pendingDateArr removeObjectAtIndex:selectedSection];
                
            }
            
            if (pendingDateDict.count > 0)
            {
                noticeLbl.hidden = YES;
                noticeLbl.text = @"No data found";
                notificationTbl.hidden = NO;
                [notificationTbl reloadData];
            }
            else
            {
                noticeLbl.hidden = NO;
                noticeLbl.text = @"No data found";
                notificationTbl.hidden = YES;
            }
             //end jam22-09 changed for remove index from dict and arr.
            
            URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Message" message:@"Booking rejected successfully" cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
            alert.tag=0;
            [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
             {
                 [alertView hideWithCompletionBlock:^{
                     
                     if(buttonIndex==0)
                     {
                         //[self getAllPendingList];//jam22-09
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
            //start jam22-09 changed for remove index from dict and arr.
            [[pendingDateDict valueForKey:[pendingDateArr objectAtIndex:selectedSection]] removeObjectAtIndex:selectedIndex];
            
            if ([[pendingDateDict valueForKey:[pendingDateArr objectAtIndex:selectedSection]] count]>0)
            {
                
            }
            else
            {
                [pendingDateDict removeObjectForKey:[pendingDateArr objectAtIndex:selectedSection]];
                 [pendingDateArr removeObjectAtIndex:selectedSection];
                
            }
            
            if (pendingDateDict.count > 0)
            {
                noticeLbl.hidden = YES;
                noticeLbl.text = @"No data found";
                notificationTbl.hidden = NO;
                [notificationTbl reloadData];
            }
            else
            {
                noticeLbl.hidden = NO;
                noticeLbl.text = @"No data found";
                notificationTbl.hidden = YES;
            }
            //End jam22-09 changed for remove index from dict and arr.
            
            URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Message" message:@"Booking accepted successfully" cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
            alert.tag=0;
            [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
             {
                 [alertView hideWithCompletionBlock:^{
                     
                     if(buttonIndex==0)
                     {
                        // [self getAllPendingList];//jam22-09
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
    else if ([[result valueForKey:@"commandName"] isEqualToString:@"deleteBooking"])
    {
        if([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
        {
            //start jam22-09 changed for remove index from dict and arr.
            
            [[cancelledDateDict valueForKey:[cancelledDateArr objectAtIndex:selectedSection]] removeObjectAtIndex:selectedIndex];
            
            if ([[cancelledDateDict valueForKey:[cancelledDateArr objectAtIndex:selectedSection]] count]>0)
            {
                
            }
            else
            {
                [cancelledDateDict removeObjectForKey:[cancelledDateArr objectAtIndex:selectedSection]];
                [cancelledDateArr removeObjectAtIndex:selectedSection];
                
            }
            
            if (cancelledDateDict.count > 0)
            {
                 noticeLbl.hidden = YES;
                 noticeLbl.text = @"";
                 notificationTbl.hidden = NO;
                 [notificationTbl reloadData];
            }
            else
            {
                noticeLbl.hidden = NO;
                noticeLbl.text = @"No data found";
                notificationTbl.hidden = YES;
            }
            //End jam22-09 changed for remove index from dict and arr.
            
            URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Message" message:@"Booking deleted successfully" cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
            alert.tag=0;
            [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
             {
                 [alertView hideWithCompletionBlock:^{
                     
                     if(buttonIndex==0)
                     {
                        // [self getAllCancelledList];//jam22-09
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
    else
    {
    }
}
- (void)onError:(NSError *)error
{
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    
    //    [app hudEndProcessMethod];
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
        if ([commandName isEqualToString:@"getPendingRequest"])
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
                [self getAllPendingList];
            }
        }
        else if ([commandName isEqualToString:@"getNurseCancelled"])
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
                [self getAllCancelledList];
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
                [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
                serviceCount = serviceCount+1;
                
                URLManager *manager = [[URLManager alloc] init];
                manager.commandName = @"rejectBooking";
                manager.delegate = self;//
                [manager urlCall:@"http://snapnurse.com/nurse/rejectBooking"withParameters:rejectDict];
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
                serviceCount = serviceCount +1;
                [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
                NSLog(@"%@",acceptDict);
                
                URLManager *manager = [[URLManager alloc] init];
                manager.commandName = @"acceptBooking";
                manager.delegate = self;//
                [manager urlCall:@"http://snapnurse.com/nurse/acceptBooking"withParameters:acceptDict];
            }
        }
        else if ([commandName isEqualToString:@"deleteBooking"])
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
                serviceCount = serviceCount +1;
                [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
                URLManager *manager = [[URLManager alloc] init];
                manager.commandName = @"deleteBooking";
                manager.delegate = self;//
                [manager urlCall:@"http://snapnurse.com/nurse/deleteBooking"withParameters:deleteDict];
            }
        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)refreshTableVeiwList
{
    if (isFromCancel)
    {
        rejectCount=rejectCount+10;
        
        if (rejectCount >= rejectServerCount)
        {
        }
        else
        {
            [self getAllCancelledList];
        }
        NSLog(@"Rejected =%d",rejectCount);
    }
    else
    {
        acceptCount=acceptCount+10;
        
        if (acceptCount >= acceptServerCount)
        {
        }
        else
        {
            [self getAllPendingList];
        }
        NSLog(@"Accepted =%d",acceptCount);
    }
}
-(void)scrollViewDidScroll: (UIScrollView*)scrollView
{
    if (scrollView.contentOffset.y + scrollView.frame.size.height == scrollView.contentSize.height)
    {
        
        [self refreshTableVeiwList];
    }
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
