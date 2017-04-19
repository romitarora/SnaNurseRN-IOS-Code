//
//  AppDelegate.h
//  Nurse
//
//  Created by one click IT consultany on 8/16/16.
//  Copyright © 2016 com.Oneclick.apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Splash_VC.h"
#import "URLManager.h"
#import "constant.h"
#import "URLManager.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
BOOL isError;
BOOL isFromBackground;
NSInteger viewHeight, addHight;
BOOL isHideCal;
NSDate * globalChangeDate;

@class Splash_VC;
@interface AppDelegate : UIResponder <UIApplicationDelegate,URLManagerDelegate,UITabBarDelegate,UITabBarControllerDelegate>
{
    Splash_VC *spl;
    UINavigationController *nav;
    NSInteger serviceCount;
    UITabBarController * tabBarController;
    BOOL isFromNotify;
    NSTimer * _timerSplash;
    
}

@property (strong, nonatomic) UIWindow *window;
-(void)hudForprocessMethod;
-(void)hudEndProcessMethod;
-(UIColor*)colorWithHexString:(NSString*)hex;
-(void)setUpTabBarController;


@end

