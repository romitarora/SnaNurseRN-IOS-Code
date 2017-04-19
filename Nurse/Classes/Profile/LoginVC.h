//
//  LoginVC.h
//  Snuzo App
//
//  Created by one click IT consultany on 9/1/15.
//  Copyright (c) 2015 Oneclick IT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "URLManager.h"
#import <Social/Social.h>
#import "ForgatePasswordViewController.h"

@class GPPSignInButton;

@interface LoginVC : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,URLManagerDelegate,UITabBarControllerDelegate,UITabBarDelegate/*,oAuthLoginPopupDelegate,TwitterLoginUiFeedback*/>
{
    UIScrollView *scrlcontent;
    UITextField *txtUserName,*txtPassword;
    BOOL Isremeber;
    NSMutableDictionary *fbdata;
    NSString *strtwetrid;
    NSString *strTwiterEmail;
    UITabBarController *tabBarController;

     NSInteger serviceCount;
    /*OAuthTwitter *oAuthTwitter;
    OAuth *oAuth4sq;
    CustomLoginPopup *loginPopup;*/
    
    NSMutableDictionary *googleJsonDictData;
    
}
@property(retain,nonatomic)UIButton *googlePlusSignInButton_;
@property(nonatomic,strong)NSString *isfromBooking;
@property(nonatomic,strong)NSString *strIsfromRate;
@property(nonatomic,strong)NSString *strIsfromCalender;


//@property (strong, nonatomic) CustomLoginPopup *loginPopup;

@end
