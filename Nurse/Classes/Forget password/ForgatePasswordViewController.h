//
//  ForgatePasswordViewController.h
//  Snuzo App
//
//  Created by Oneclick IT on 9/22/15.
//  Copyright © 2015 Oneclick IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "URLManager.h"
#import "AppDelegate.h"


@interface ForgatePasswordViewController : UIViewController<UITextFieldDelegate,URLManagerDelegate>
{
    UITextField *txtUserName;
     NSInteger serviceCount;
}
@property(nonatomic,strong)NSString *isfromBooking;
@property(nonatomic,strong)NSString *strIsfromRate;
@end
