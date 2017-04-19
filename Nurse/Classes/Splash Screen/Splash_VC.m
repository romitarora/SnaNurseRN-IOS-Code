//
//  Splash_VC.m
//  Snoozo App
//
//  Created by HARI on 7/30/15.
//  Copyright (c) 2015 oneclick. All rights reserved.
//

#import "Splash_VC.h"
#import "AppDelegate.h"
#import "FaqVC.h"
#import "ViewController.h"
#import "NotificationVC.h"
#import "TimeAvilabilityVC.h"
@interface Splash_VC ()

@end

@implementation Splash_VC
@synthesize isFromNotify;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    
    NSLog(@"My Device Token =%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"] );
    
    UIImageView *bg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 39, self.view.frame.size.width, self.view.frame.size.height)];
    bg.image=[UIImage imageNamed:@"bgLogin"];
    [self.view addSubview:bg];
    
    
    isHomeclick=YES;
    isArroundclick=NO;
    isprofileclick=NO;
    isBookingclick=NO;
    
  [self finishSplash];


[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationTab) name:@"MoveNotificationtab" object:nil];
    
    // Do any additional setup after loading the view.
}
-(void)notificationTab
{
    tabBarController.selectedIndex=1;
}

-(void)finishSplash
{
    
    AppDelegate * ap=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
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
    [ap.window addSubview:tabBarController.view];
    
    if (self.isFromNotify)
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
   // [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:12.0/255.0 green:12.0/255.0 blue:37.0/255.0 alpha:1.0]];
   // [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    [[UITabBar appearance] setTintColor:[UIColor blackColor]];
    
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
     NSLog(@"dsfs");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
