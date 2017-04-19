//
//  FaqVC.h
//  Snuzo App
//
//  Created by Oneclick IT on 8/29/15.
//  Copyright (c) 2015 Oneclick IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaqCell.h"
#import "URLManager.h"
#import "URBAlertView.h"
#import "MNMBottomPullToRefreshManager.h"
#import "AppDelegate.h"
@interface FaqVC : UIViewController<UITableViewDelegate,UITableViewDataSource,URLManagerDelegate,MNMBottomPullToRefreshManagerClient>
{
    UITableView *tblfaq;
    BOOL ISEXPAND;
    int row;
    int count;
    MNMBottomPullToRefreshManager *PullTorefrehManager_FAQ;
     NSInteger serviceCount;
    NSMutableArray *arrfaq;
    
}
@property (strong, nonatomic) NSMutableArray *expandedCells;

@end
