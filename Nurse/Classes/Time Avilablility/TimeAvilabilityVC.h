//
//  TimeAvilabilityVC.h
//  Nurse
//
//  Created by one click IT consultany on 9/14/16.
//  Copyright © 2016 com.Oneclick.apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Splash_VC.h"
#import "AppDelegate.h"
#import "TimeAvilablilityCell.h"
#import "SetHoursVC.h"
#import "URLManager.h"
@interface TimeAvilabilityVC : UIViewController<UITableViewDelegate,UITableViewDataSource,URLManagerDelegate>
{
    UISegmentedControl * segMentBtn;
    UILabel * noticeLbl;
    UITableView * daysAndSpicialTbl;
    BOOL isFromDays;
    NSInteger selectedIndex;
    NSInteger selectedSection;
    NSMutableArray * daysArr ,* tempDaysArr;
    NSMutableArray * specialDateArr, *specialMonthArr ,* specialYearArr;
    UIButton * addBtn;
    NSString * customerId;
    NSMutableDictionary * daysKeyDict;
    NSString * dayName;
    NSMutableDictionary * monthKeysDict, *dateKeysDict ,* yearsKeysDict,*deleteDict;
     NSInteger serviceCount;
}

@end
