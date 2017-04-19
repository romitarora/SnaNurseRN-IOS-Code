//
//  AppDelegate.m
//  Nurse
//
//  Created by one click IT consultany on 8/16/16.
//  Copyright © 2016 com.Oneclick.apps. All rights reserved.
//

#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "FaqVC.h"
#import "ViewController.h"
#import "NotificationVC.h"
#import "TimeAvilabilityVC.h"
@interface AppDelegate ()<UITabBarControllerDelegate>
{
    MBProgressHUD * HUD;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   
    isFromBackground = NO;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    NSLog(@"User Info : %@", [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]);
    
    spl=[[Splash_VC alloc]init];

    if ([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey])
    {
        spl.isFromNotify=YES;
    }
    else
    {
        spl.isFromNotify=NO;
    }
    
    nav=[[UINavigationController alloc] initWithRootViewController:spl];
    self.window.rootViewController=nav;
    
    if (IS_OS_8_OR_LATER)
    {
        nav=[[UINavigationController alloc] initWithRootViewController:spl];
        [self.window addSubview:nav.view];
        [self.window makeKeyAndVisible];
        _timerSplash = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(cancelsplash) userInfo:nil repeats:NO];
    }
    else
    {
        nav=[[UINavigationController alloc] initWithRootViewController:spl];
        self.window.rootViewController=nav;
        [self.window makeKeyAndVisible];
        _timerSplash = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(cancelsplash) userInfo:nil repeats:NO];
    }
    
    [self setUpTabBarController];
    [application setStatusBarHidden:NO];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    [Fabric with:@[[Crashlytics class]]];
    // Override point for customization after application launch.
    return YES;
}
-(void) cancelsplash
{
    if(spl)
    {
        [spl.view removeFromSuperview];
        self->spl = nil;
    }
    [self setUpTabBarController];
}
-(void)clearBadgeCount
{
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"isLogin"]isEqualToString:@"YES"])
    {
        NSString *  customerId = [[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
        if ([customerId isEqualToString:@""]||customerId==nil)
        {
        }
        else
        {
            NSMutableDictionary * dict =[[NSMutableDictionary alloc] init];
            [dict setValue:customerId forKey:@"user_id"];
            URLManager *manager = [[URLManager alloc] init];
            manager.commandName = @"clearBagdeCount";
            manager.delegate = self;
            [manager urlCall:@"http://snapnurse.com/nurse/readMessage" withParameters:dict];
        }
    }
}

#pragma mark - Notification
#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:   (UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler

{
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive)
    {
        // user has tapped notification
        NSLog(@"user has tapped notification %@", [userInfo description]);
        
        if (isFromBackground)
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"MoveNotificationtab" object:nil];
        }
        else
        {
        }
    }
    else
    {
        NSLog(@"user opened app from app icon%@", [userInfo description]);
    }
    
    NSDictionary *test =(NSDictionary *)[userInfo objectForKey:@"aps"];
    NSString *alertString =(NSString *) [test objectForKey:@"alert"];
    NSLog(@"String recieved: %@",alertString);
    
//    if([[userInfo objectForKey:@"aps"] objectForKey:@"badge"] != nil)
//    {
//        // The key existed...
//        [application setApplicationIconBadgeNumber:[[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] intValue]];
//    }
//    else
//    {
//        // No joy...
//        
//    }
    
    NSLog(@"User Info : %@", [userInfo description]);

    NSLog(@"User Info Alert Message : %@", [[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    
    
    URBAlertView *alertView = [[URBAlertView alloc] initWithTitle:ALERT_TITLE message:alertString cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView setMessageFont:[UIFont systemFontOfSize:14.0]];
    [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
        [alertView hideWithCompletionBlock:^{
        }];
    }];
    [alertView showWithAnimation:URBAlertAnimationTopToBottom];
    
}
#endif
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *deviceTokenStr = [[[[deviceToken description]
                                  stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                 stringByReplacingOccurrencesOfString: @">" withString: @""]
                                stringByReplacingOccurrencesOfString: @" " withString: @""] ;
    NSLog(@"My Token =%@",deviceTokenStr);
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"content---%@", token);
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"updatedDeviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
// A function for parsing URL parameters
- (NSDictionary*)parseURLParams:(NSString *)query
{
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val = [[kv objectAtIndex:1]
                         stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [params setObject:val forKey:[kv objectAtIndex:0]];
    }
    return params;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    isFromBackground = YES;
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [self clearBadgeCount];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark Hud Method
-(void)hudForprocessMethod
{
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    [self.window addSubview:HUD];
    [HUD show:YES];
    
}
-(void)hudEndProcessMethod
{
    
    [HUD hide:YES];
}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
#pragma mark UrlManager Delegates
- (void)onResult:(NSDictionary *)result
{
    NSLog(@"result %@",result);
    if([[result valueForKey:@"commandName"] isEqualToString:@"clearBagdeCount"])
    {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
}
- (void)onError:(NSError *)error
{
    NSLog(@"The error is...%@", error);
    NSInteger ancode = [error code];
    if (ancode == -1009)
    {
    }
    else if(ancode == -1001)
    {
    }
    else
    {
    }
}
- (void)onNetworkError:(NSError *)error didFailWithCommandName:(NSString *)commandName
{
    NSLog(@"OnNetworkErrorCall");
    if (error.code == -1005)
    {
       
    }
}
-(void)setUpTabBarController
{
    BookingVC*  home=[[BookingVC alloc]init];
    NotificationVC *Booking = [[NotificationVC alloc]init];
    LoginVC *ProfVC = [[LoginVC alloc]init];
    TimeAvilabilityVC *timeVC=[[TimeAvilabilityVC alloc]init];
    
    ProfVC = [[LoginVC alloc]init];
    
    tabBarController = [[UITabBarController alloc] init];
    tabBarController.tabBar.tintColor=[UIColor blackColor];
    tabBarController.tabBar.backgroundColor=[UIColor blackColor];
    tabBarController.delegate=self;
    tabBarController.tabBar.backgroundImage=[UIImage imageNamed:@"footer"];
    // tabBarController.tabBar.backgroundColor = globelColor;
    
    //Home Tab Bar Item And Icon
    UIImage *HomeIcon = [UIImage imageNamed:@"book-selected"];
    UIImage *HomeIconUnselected = [UIImage imageNamed:@"book"];
    UITabBarItem *HomeItem = [[UITabBarItem alloc] initWithTitle:@"" image:HomeIconUnselected selectedImage:HomeIcon];
    //    HomeItem.imageInsets = UIEdgeInsetsMake(5, 0, -6, 0);
    UINavigationController *Home = [[UINavigationController alloc] initWithRootViewController:home];
    [Home.navigationBar setTranslucent:NO];
    Home.tabBarItem = HomeItem;
    
    Home.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0, -5, 0);;
    HomeItem.selectedImage = [HomeIcon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    HomeItem.image =[HomeIconUnselected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    //Booking Tabbar Icon
    UIImage *Bookingicon = [UIImage imageNamed:@"selected-notification"];//
    UIImage *BookingiconUnselected = [UIImage imageNamed:@"notification"];
    UITabBarItem *BookingItem = [[UITabBarItem alloc] initWithTitle:nil image:BookingiconUnselected selectedImage:Bookingicon];
    
    UINavigationController *bokkingNav = [[UINavigationController alloc] initWithRootViewController: Booking];
    [bokkingNav.navigationBar setTranslucent:NO];
    bokkingNav.tabBarItem = BookingItem;
    bokkingNav.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0, -5, 0);;
    
    BookingItem.selectedImage = [Bookingicon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BookingItem.image =[BookingiconUnselected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //Profile Icon
    UIImage *ProfileIcon = [UIImage imageNamed:@"selected-profile.png"];//
    UIImage *ProfileIconUnselected = [UIImage imageNamed:@"Profile.png"];//
    UITabBarItem *ProfileItem = [[UITabBarItem alloc] initWithTitle:nil image:ProfileIconUnselected selectedImage:ProfileIcon];
    UINavigationController *ProfileNav = [[UINavigationController alloc] initWithRootViewController: ProfVC];
    
    [ProfileNav.navigationBar setTranslucent:NO];
    ProfileNav.tabBarItem = ProfileItem;
    
    ProfileNav.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0, -5, 0);;
    ProfileItem.selectedImage = [ProfileIcon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ProfileItem.image =[ProfileIconUnselected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //Time Icon
    UIImage *timeIcon = [UIImage imageNamed:@"selected-availibility"];//
    UIImage *timeIconUnselected = [UIImage imageNamed:@"availibility"];//
    UITabBarItem *TimeItem = [[UITabBarItem alloc] initWithTitle:nil image:timeIconUnselected selectedImage:timeIcon];
    UINavigationController *TimeNav = [[UINavigationController alloc] initWithRootViewController: timeVC];
    
    [TimeNav.navigationBar setTranslucent:NO];
    TimeNav.tabBarItem = TimeItem;
    
    TimeNav.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0, -5, 0);;
    TimeItem.selectedImage = [timeIcon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    TimeItem.image =[timeIconUnselected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //
    NSArray* controllers = [NSArray arrayWithObjects: Home,bokkingNav, ProfileNav,TimeNav, nil];
    
    //      NSArray* controllers = [NSArray arrayWithObjects: Home,bokkingNav, ProfileNav, nil];
    [tabBarController setViewControllers: controllers animated:NO];
    [self.window addSubview:tabBarController.view];
    
    if (isFromNotify)
    {
        [tabBarController setSelectedIndex:1];
    }
    else
    {
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"isLogin"]isEqualToString:@"YES"])
        {
            [tabBarController setSelectedIndex:0];
        }
        else
        {
            [tabBarController setSelectedIndex:2];
        }
    }
    
    
    // Set bar button tint color to app theme color
    [[UIBarButtonItem appearance] setTintColor:[UIColor clearColor]];
    // Set Tab Bar Items Selected Tint color to App Theme Color
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:12.0/255.0 green:12.0/255.0 blue:37.0/255.0 alpha:1.0]];
    
    [[UITabBar appearance] setTintColor:[UIColor blackColor]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
}
- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame __TVOS_PROHIBITED;   // in screen coordinates
{
    if (newStatusBarFrame.size.height == 40)
    {
        viewHeight = kScreenHeight - 20;
        
        addHight = kScreenHeight - viewHeight + 20;
    }
    else
    {
        viewHeight = kScreenHeight ;
        addHight = kScreenHeight - viewHeight+20;
        
    }
    
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"dsfs");
    
}
@end
