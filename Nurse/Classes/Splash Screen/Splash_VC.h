//
//  Splash_VC.h
//  Snoozo App
//
//  Created by HARI on 7/30/15.
//  Copyright (c) 2015 oneclick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileVC.h"
#import "LoginVC.h"
#import "BookingVC.h"
#import "TimeAvilabilityVC.h"
@interface Splash_VC : UIViewController<UITabBarControllerDelegate,UITabBarDelegate>
{
    UITabBarController *tabBarController;
    
    UINavigationController *nav;
    UIView *MenuView;
    BOOL isHomeclick,isArroundclick,isBookingclick,isprofileclick;
}

@property BOOL isFromNotify;
@end
