//
//  SpecialDateVC.h
//  Nurse
//
//  Created by one click IT consultany on 9/14/16.
//  Copyright © 2016 com.Oneclick.apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "OCCalendarViewController.h"
#import "URLManager.h"
@interface SpecialDateVC : UIViewController<OCCalendarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,URLManagerDelegate>
{
    UIButton * dateBtn;
    UIButton * BtnarrivalDate;
    UIButton * toDateBtn;
    UILabel * DateTitle;
    UILabel * toDateLbl;
    NSDate *searchDate;
    BOOL isdateClick;
    BOOL isFromDateClick;
    OCCalendarViewController *calVC;
    UIView *bgView;
    NSMutableArray * hoursArr;
    UITableView * hoursTbl;
    UITextView * txtNote;
    NSString * customerId;
    NSString * strBarPrice, *FromSelectedDate ,*ToSelectedDate;
    NSDate * toDate;
    NSDate * fromDate;
    UIImageView *imgToDate;
     NSInteger serviceCount;

}
@property (nonatomic , strong) NSString * strIsFrom;
@property (nonatomic , strong) NSString * strTitle;
@property (nonatomic , strong) NSString * strDetail;
@property (nonatomic , strong) NSString * strEditDate;
@end
