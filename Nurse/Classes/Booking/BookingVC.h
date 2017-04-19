//
//  BookingVC.h
//  Snoozo App
//
//  Created by HARI on 7/30/15.
//  Copyright (c) 2015 oneclick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pastbookingcell.h"
#import "AppDelegate.h"
#import "URLManager.h"
#import "MNMBottomPullToRefreshManager.h"
#import "BookDetail.h"


@interface BookingVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIScrollViewAccessibilityDelegate,URLManagerDelegate,MNMBottomPullToRefreshManagerClient>

{
     NSInteger serviceCount;
    NSInteger countcurrent;
    NSInteger countPast;
    
    MNMBottomPullToRefreshManager * pullToRefreshManager_Images;
    MNMBottomPullToRefreshManager * PullTorefrehManager_Past;
    
    
    
    UILabel *lblcurrentbook;
    UILabel *lblpastbook;
    
    UIImageView *lblLine;
    int page;
    UILabel *lblHotelname;
    UILabel *lblHoteladdress;
    UITableView *tblPastBooking,*tblCurrentBook;
    
    NSString *customerId;

    
    UIView *pastbookView;
    
    NSMutableArray *pastbookArray;
    NSMutableArray *currentbookarray;
    NSMutableArray * bookingListArr;
    NSString * selectedDate;
    
    BOOL isFirstTime;
    BOOL firstTimeCall;
    
    UIScrollView *scrlcontent;
    UIView *currentBookview;
    UILabel * pendingLbl,*cancelledLbl;
    
}
@end
