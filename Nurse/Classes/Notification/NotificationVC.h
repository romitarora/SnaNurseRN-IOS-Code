//
//  NotificationVC.h
//  Nurse
//
//  Created by one click IT consultany on 8/17/16.
//  Copyright © 2016 com.Oneclick.apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "URLManager.h"
@interface NotificationVC : UIViewController<UITableViewDelegate,UITableViewDataSource,URLManagerDelegate>

{
    UILabel * noticeLbl;
    UITableView * notificationTbl;
    UISegmentedControl * segMentBtn;
    BOOL isFromCancel;
    NSInteger selectedIndex;
    NSInteger selectedSection;
    NSMutableArray * cancelledArr;
    NSMutableArray * pendingArr;
    NSMutableDictionary * pendingDateDict;
    NSMutableDictionary * cancelledDateDict;
    NSInteger serviceCount;
    NSString *customerId;
    NSMutableArray * pendingDateArr;
    NSMutableArray * cancelledDateArr;
    NSMutableDictionary *rejectDict;
    NSMutableDictionary *acceptDict,*deleteDict;
    

}
@end
