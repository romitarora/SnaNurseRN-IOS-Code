//
//  Constant.h
//  ibeacon stores
//
//  Created by One Click IT Consultancy  on 5/14/14.
//  Copyright (c) 2014 One Click IT Consultancy . All rights reserved.
//

#import <Foundation/Foundation.h>


//#define KONTACT_API_KEY @"JrOUjzPCEVSpMaaxDZFyAIZmZwNrztSQ"

//#define kScanditSDKAppKey    @"iqXQ/P4FEeOTEpvIsUyNUZKe38J7B1hUzIYR3cxYWSs"

#define kClientId @"749250371636-6j128qhbro3jtsgbns3mq4tcb9kranku.apps.googleusercontent.com" // Snuzo App

#define URBalertAnimationType URBAlertAnimationTopToBottom

/* Live Account */


//#define StripSkey  @"sk_live_0Zx8Y4iuUFROQs3xUNFGaG9J";
//#define StripPkey @"pk_live_fnxQM6Bi7FtsTdOEqtlJ9mJK";
#define StripSkey [[NSUserDefaults standardUserDefaults] stringForKey:@"StripSkey"]
#define StripPkey [[NSUserDefaults standardUserDefaults] stringForKey:@"StripPkey"]

/* test aaccount*/
/*
#define StripSkey  @"sk_test_atHWeV2HRsofXajI3UZZwVHa";
#define StripPkey @"pk_test_BZiO1vLN7MCQwmJvyCEsAafY";

*/


//#define kClientId    @"101046264356-sogoo3rsdmess2kehp844l06esvnvtj0.apps.googleusercontent.com" // Walk Point for Google+ friends

//#define kGOOGLE_MAP_API_KEY  @"AIzaSyDyP5BWHsqk-AIu-DlFk-WQu4dDwoAZKvc" //for Google map

//#define kGOOGLE_MAP_API_KEY  @"AIzaSyDi_s_WRgo4v0ydkowqKLWfh8vjd6FMJ_8" //for Google map


//#define kClientId    @"75750679664-e1mod9b44h0t599a0ao8m4fovtij1o9a.apps.googleusercontent.com" // Walkpoints


//static NSString * const kClientId = @"101046264356-lqncecos6vad4dp4ej4gmokvgtagl64r.apps.googleusercontent.com";


@protocol Constant <NSObject>

/*typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;
*/
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_4 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)//jam
#define BackendChargeURLString @"http://oneclickitsolution.com/subdomain/whatif/webservice.php"
#define IS_IPHONE_6plus (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0f)//jam
#define APP_DELEGATE (AppDelegate*)[[UIApplication sharedApplication]delegate]

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define globelColor [UIColor colorWithRed:0.0f/255.0f green:32.0f/255.0f blue:218.0f/255.0f alpha:1.0]


#define ALERT_TITLE @"Camboodle"
#define OK_BTN @"OK"
#define ALERT_CANCEL  @"Cancel"
#define ALERT_NO  @"NO"
#define ALERT_YES  @"YES"

#define ACTION_TAKE_PHOTO       @"Take photo"
#define ACTION_LIBRARY_PHOTO    @"Photo from library"


/*
//#define WEB_SERVICE_URL @"http://oneclickitsolution.com/subdomain/whatif/webservice.php"
#define WEB_SERVICE_URL @"http://www.whatif.com.br/partners/webservice/webservice.php"


#define GalleryImagePerRow   			 (IS_IPAD ? 2 :2)


#define ALERT_TITLE @"Walkpoints"
//#define OK_BTN @"OK"
#define OK_BTN  NSLocalizedString(@"OK", nil)

#define ALERT_CANCEL  NSLocalizedString(@"Cancel", nil)
#define ALERT_ERROR  NSLocalizedString(@"Error", nil)

//#define ACTION_TAKE_PHOTO       @"Take Photo"
#define ACTION_TAKE_PHOTO NSLocalizedString(@"Take Photo", nil)
//#define ACTION_LIBRARY_PHOTO    @"Photo From Library"
#define ACTION_LIBRARY_PHOTO NSLocalizedString( @"Photo From Library", nil)

#define CONNECTION_FAILED @"Please check internet connection"

#define REQUEST_TIME_OUT NSLocalizedString(@"The request time out.", nil)
#define NO_NETWORK_CONNECTION  NSLocalizedString(@"No network connectivity", nil)
#define NO_NETWORK_CONNECTION_MESSAGE  NSLocalizedString(@"There is no network connectivity. This application requires a network connection", nil)


#pragma mark current language ---------------------------------------
#define CURRENT_LANGUAGE [[NSUserDefaults standardUserDefaults] stringForKey:@"Current_Language"]


#pragma mark User Credential-----------------------------------------

#define CURRENT_USER_ID [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"]
#define CURRENT_USER_FIRSTNAME [[NSUserDefaults standardUserDefaults] stringForKey:@"Fisrt_Name"]
#define CURRENT_USER_LASTNAME [[NSUserDefaults standardUserDefaults] stringForKey:@"Last_Name"]
#define CURRENT_USER_EMAIL [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Email"]
#define CURRENT_USER_PROFILE_IMAGE [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Image"]
#define CURRENT_USER_BIRTHDATE [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Birthdate"]
#define CURRENT_USER_GENDER [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Gender"]
#define CURRENT_USER_Phone [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Phone"]
#define CURRENT_USER_ZipCode [[NSUserDefaults standardUserDefaults] stringForKey:@"User_ZipCode"]

#define CURRENT_USER_ZipCode [[NSUserDefaults standardUserDefaults] stringForKey:@"User_ZipCode"]



#define CURRENT_USER_Current_Kick_Points [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Kick_Points"]
#define CURRENT_USER_All_Kick_Points [[NSUserDefaults standardUserDefaults] stringForKey:@"User_All_Kick_Points"]
#define CURRENT_USER_Targeted_Kick_Points [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Targrted_Kick_Points"]

#define CURRENT_USER_Selected_Reward_Point [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Selected_Reward_Point"]
#define CURRENT_USER_Selected_Reward_ID [[NSUserDefaults standardUserDefaults] stringForKey:@"User_Selected_Reward_Id"]




*/


@end
