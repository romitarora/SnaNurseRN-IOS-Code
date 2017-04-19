//
//  SetHoursVC.h
//  Nurse
//
//  Created by one click IT consultany on 9/14/16.
//  Copyright © 2016 com.Oneclick.apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Constant.h"
#import "TimeAvilablilityCell.h"
#import "TimeAvilabilityVC.h"
#import "URLManager.h"
@interface SetHoursVC : UIViewController<UITableViewDelegate,UITableViewDataSource,URLManagerDelegate>
{
    UITableView * hoursTbl;
    NSMutableArray * hoursArr;
    NSString * customerId;
    NSString * strBarPrice;
     NSInteger serviceCount;
}
@property (nonatomic ,strong)NSString * strTitle;
@end
