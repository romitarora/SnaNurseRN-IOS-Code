//
//  ProfileVC.h
//  Snoozo App
//
//  Created by HARI on 7/30/15.
//  Copyright (c) 2015 oneclick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "URBAlertView.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "URLManager.h"
#import "AsyncImageView.h"
#import "Splash_VC.h"
#import "RateView.h"

@class ProfileVC;
//
//@protocol PaymentViewControllerDelegate<NSObject>
//
//- (void)paymentViewController:(ProfileVC *)controller didFinish:(NSError *)error;
//
//@end
@interface ProfileVC : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,URLManagerDelegate,UITabBarDelegate,UITabBarControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
     UIView * mainImgHeader;
    AsyncImageView * nurseImg;
    
    UILabel *lblcardDetail;
    
    NSString *strcardbard;
    
    UIButton *personalinfo;
     NSInteger serviceCount;
    UIButton *paymentcardinfo;
    UIImageView *imgProfile;
    UIImageView *ProfileImage;
    
    UIScrollView *scrlPersonal;
    NSMutableArray *Yearaaray;
    NSMutableArray *Montharray;

    NSString * strHospital;
    
    UINavigationController *nav;
    
    BOOL IsyearClcik;
    BOOL Ismonthclick;
    UIButton *paymentsavebtn;
    UIButton *paymentClosebtn;
    
    
    UIButton * monthBtn;
    
    
    UIScrollView *scrlcontent;
    int page;
    UIView *personalView,*paymentview,*cardview;
    
    UIView * HeaderView,*bottomView;
    UILabel * lbltitle;
    UIButton * btnRate;
    RateView * rateVw;
    
    UIImageView *lblLine;
    UIButton * yearBtn;
    UITableView *tblYear;
    UITableView *tblcontent;
    
    NSMutableArray * specializationArr;
    
    UITextField *txtfname,*txtlname,*txtphNo,*txtemail,*txtoldPass,*txtnewPass,*txtconfPass,*txtnameoncard,*txtcardNo;
    
    NSMutableArray * detailArr;
    
}
@property BOOL isFromTabbar;
//@property (nonatomic) NSDecimalNumber *amount;
//@property (nonatomic, weak) id<PaymentViewControllerDelegate> delegate;
@end
