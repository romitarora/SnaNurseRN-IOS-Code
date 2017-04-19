//
//  RegisterVC.h
//  Nurse
//
//  Created by One Click IT Consultancy  on 10/22/16.
//  Copyright © 2016 com.Oneclick.apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "URLManager.h"
@interface RegisterVC : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate,URLManagerDelegate>
{
    TPKeyboardAvoidingScrollView *keyBordScrollView;
    UIScrollView * scrollView;
    
    UITextField * txtUserName;
    UITextField * txtContactNo;
    UITextField * txtEmail;
    UITextField * txtCity;
    UITextField * txtZipCode;
    UITextView * txtSpecialization;
    UITextView * txtAddress;
    UITextView * txtDescription;
    UIButton * registerbtn;
    NSInteger serviceCount;
}

@end
