//
//  LoginVC.m
//  Snuzo App
//
//  Created by one click IT consultany on 9/1/15.
//  Copyright (c) 2015 Oneclick IT. All rights reserved.
//

#import "LoginVC.h"
#import "USColor.h"
#import "ProfileVC.h"
#import "FaqVC.h"
#import "NotificationVC.h"
#import "RegisterVC.h"
@interface LoginVC ()
{
    UIImageView * rememberImg;
    UIButton * rememberBtn;
    UIButton * fbBtn;
}
@end



@implementation LoginVC
@synthesize googlePlusSignInButton_,isfromBooking,strIsfromRate,strIsfromCalender;//loginPopup

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        oAuthTwitter = [[OAuthTwitter alloc] initWithConsumerKey:OAUTH_CONSUMER_KEY andConsumerSecret:OAUTH_CONSUMER_SECRET];
//        [oAuthTwitter load];
      
        
    }
    return self;
}
- (void)viewDidLoad
{
    serviceCount = 0;
    {
        // [self showTabBar:self.tabBarController];
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"isLogin"]isEqualToString:@"YES"])
        {
            ProfileVC * profil =[[ProfileVC alloc] init];
            [self.navigationController pushViewController:profil animated:NO];
        }
        else
        {
            if ([isfromBooking isEqualToString:@"YES"])
            {
                // [self hideTabBar:self.tabBarController];
            }
            if ([strIsfromRate isEqualToString:@"YES"])
            {
                // [self hideTabBar:self.tabBarController];
            }
            if ([strIsfromCalender isEqualToString:@"YES"])
            {
                // [self hideTabBar:self.tabBarController];
            }
            else
            {
                self.tabBarController.delegate=self;
            }
            {
                
                UIImageView *bg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, viewHeight)];
                bg.image=[UIImage imageNamed:@"bg-ip-5"];
                [self.view addSubview:bg];
                
                UIView * backView = [[UIView alloc] init];
                backView.frame =CGRectMake(0, 0, self.view.frame.size.width, viewHeight);
                backView.backgroundColor = [UIColor whiteColor];
                backView.alpha = 0.5;
                [self.view addSubview:backView];
                
                UIImageView * logoImg =[[UIImageView alloc] init];
                logoImg.frame=CGRectMake(73.5, 15, 173, 44);
                if (IS_IPHONE_4)
                {
                    // logoImg.frame=CGRectMake(106, 15,108,47);
                    bg.image=[UIImage imageNamed:@"bg-ip-4.png"];
                }
                else if (IS_IPHONE_6)
                {
                    logoImg.frame=CGRectMake(101, 20, 173, 44);
                    bg.image=[UIImage imageNamed:@"bg-ip-6.png"];
                }
                else if (IS_IPHONE_6plus)
                {
                    logoImg.frame=CGRectMake(120.5, 20, 173, 44);
                    bg.image=[UIImage imageNamed:@"bg-ip-6plus.png"];
                }
                logoImg.image=[UIImage imageNamed:@"nursingLogo.png"];
                [self.view addSubview:logoImg];
                
                scrlcontent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 85, self.view.frame.size.width, viewHeight)];
                scrlcontent.scrollEnabled=NO;
                
                if (IS_IPHONE_4) {
                    scrlcontent.frame=CGRectMake(0, 50, self.view.frame.size.width, viewHeight-100);
                    [scrlcontent setContentSize:CGSizeMake(self.view.frame.size.width, scrlcontent.frame.size.height+100)];
                    if (isfromBooking)
                    {
                        
                    }
                    else
                    {
                        //scrlcontent.scrollEnabled=YES;
                        
                        
                    }
                    
                }
                scrlcontent.showsHorizontalScrollIndicator = NO;
                scrlcontent.showsVerticalScrollIndicator = NO;
                //    scrlcontent.pagingEnabled = YES;
                scrlcontent.delegate = self;
                
                
                [self.view addSubview:scrlcontent];
                
                int y=30;
                
                UIImageView *nameview=[[UIImageView alloc]initWithFrame:CGRectMake(33,y, self.view.frame.size.width-66, 39)];
                nameview.image=[UIImage imageNamed:@"text-field.png"];
                nameview.userInteractionEnabled = YES;
                [scrlcontent addSubview:nameview];
                
                
                txtUserName=[[UITextField alloc]initWithFrame:CGRectMake(10,0, nameview.frame.size.width-10, 39)];
                UIColor *color = [UIColor lightGrayColor];
                txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email id" attributes:@{NSForegroundColorAttributeName: color}];
                txtUserName.textAlignment=NSTextAlignmentLeft;
                txtUserName.delegate=self;
                txtUserName.backgroundColor=[UIColor clearColor];
                txtUserName.layer.cornerRadius=1.0;
                txtUserName.returnKeyType=UIReturnKeyNext;
                txtUserName.keyboardType=UIKeyboardTypeEmailAddress;
                
                [nameview addSubview:txtUserName];
                
                y= y+39+15;
                
                UIImageView *lnameview=[[UIImageView alloc]initWithFrame:CGRectMake(33,y, self.view.frame.size.width-66, 39)];
                lnameview.image=[UIImage imageNamed:@"text-field.png"];
                lnameview.userInteractionEnabled = YES;
                [scrlcontent addSubview:lnameview];
                
                txtPassword=[[UITextField alloc]initWithFrame:CGRectMake(10,0, nameview.frame.size.width-10,39)];
                txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
                txtPassword.textAlignment=NSTextAlignmentLeft;
                txtPassword.delegate=self;
                [lnameview addSubview:txtPassword];
                txtPassword.secureTextEntry=YES;
                txtPassword.returnKeyType=UIReturnKeyDone;
                
                txtPassword.layer.cornerRadius=1.0;
                txtUserName.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13];
                txtPassword.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13];
                
                txtUserName.textColor=[UIColor blackColor]; //[USColor colorFromHexString:@"#999999"];
                txtPassword.textColor=[UIColor blackColor];
                //[USColor colorFromHexString:@"#999999"];
                
                
                if(IS_IPHONE_4)
                {
                    y= y+45;
                }
                else
                {
                    y= y+39+10;
                }
                rememberImg=[[UIImageView alloc] init];
                rememberImg.backgroundColor=[UIColor whiteColor];
                rememberImg.frame=CGRectMake(33, y, 12, 12);
                rememberImg.layer.cornerRadius=2;
                rememberImg.layer.borderWidth = 0.5;
                rememberImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
                [scrlcontent addSubview:rememberImg];
                
                UILabel * rememberLbl =[[UILabel alloc] initWithFrame:CGRectMake(50, y-3.5, 100, 20)];
                
                rememberLbl.backgroundColor=[UIColor clearColor];
                rememberLbl.text=@"Remember me";
                [rememberLbl setTextColor:[UIColor blackColor]];
                rememberLbl.font=[UIFont systemFontOfSize:12.0f];
                [scrlcontent addSubview:rememberLbl];
                
                rememberBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                rememberBtn.backgroundColor=[UIColor clearColor];
                rememberBtn.frame=CGRectMake(0, y, 150, 40);
                [rememberBtn addTarget:self action:@selector(remember) forControlEvents:UIControlEventTouchUpInside];
                [scrlcontent addSubview:rememberBtn];
                
                
                UILabel * frgtLbl =[[UILabel alloc] initWithFrame:CGRectMake(150, y-3.5, self.view.frame.size.width-150-33, 20)];
                frgtLbl.backgroundColor=[UIColor clearColor];
                frgtLbl.text=@"Forgot password?";
                frgtLbl.textAlignment = NSTextAlignmentRight;
                [frgtLbl setTextColor:[UIColor blackColor]];
                frgtLbl.font=[UIFont systemFontOfSize:12.0f];
                [scrlcontent addSubview:frgtLbl];
                
                UIButton * frgtBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                frgtBtn.backgroundColor=[UIColor clearColor];
                [frgtBtn addTarget:self action:@selector(forgetClick) forControlEvents:UIControlEventTouchUpInside];
                frgtBtn.frame=CGRectMake(150, y-10, self.view.frame.size.width-150-33, 40);
                
                [scrlcontent addSubview:frgtBtn];
                
                if (IS_IPHONE_4)
                {
                    y=y+40+20;
                    
                }
                else
                {
                    y=y+40+25;
                }
                
                UIButton * loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                loginBtn.backgroundColor=[UIColor clearColor];
                loginBtn.frame=CGRectMake(33, y, self.view.frame.size.width/2-37, 40);
                [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
                loginBtn.titleLabel.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15];
                [loginBtn setTitle:@"Login" forState:UIControlStateNormal];
                loginBtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"footer"]];
                [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                loginBtn.layer.cornerRadius=2.0f;
                [scrlcontent addSubview:loginBtn];
                
                UIButton * registerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                registerBtn.backgroundColor=[UIColor clearColor];
                registerBtn.frame=CGRectMake(self.view.frame.size.width/2+5, y, self.view.frame.size.width/2-37, 40);
                [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
                registerBtn.titleLabel.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15];
                [registerBtn setTitle:@"Register" forState:UIControlStateNormal];
                registerBtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"footer"]];
                [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                registerBtn.layer.cornerRadius=2.0f;
                [scrlcontent addSubview:registerBtn];
                
                y=y+18+12;
                
                [super viewDidLoad];
                
                self.navigationItem.hidesBackButton=YES;
                self.navigationItem.title=@"Login";
                [self.navigationController.navigationBar setTitleTextAttributes:
                 @{NSForegroundColorAttributeName:globelColor}];
                
                NSString * userNameStr =[[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
                
                NSString * passStr =[[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
                
                if ([userNameStr length]==0||[userNameStr isEqual:[NSNull null]]||userNameStr==nil)
                {
                }
                else
                {
                    txtUserName.text=userNameStr;
                    rememberImg.image=[UIImage imageNamed:@"yes"];
                    Isremeber=YES;
                }
                if ([passStr length]==0||[passStr isEqual:[NSNull null]]||passStr==nil)
                {
                }
                else
                {
                    txtPassword.text=passStr;
                    
                    rememberImg.image=[UIImage imageNamed:@"yes"];
                    Isremeber=YES;
                }
                
                if (isfromBooking||strIsfromRate || strIsfromCalender) {
                    
                    UIBarButtonItem * backbarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back icon"]
                                                                                    style:UIBarButtonItemStylePlain
                                                                                   target:self
                                                                                   action:@selector(BackBtnClick)];
                    self.navigationItem.leftBarButtonItem=backbarBtn;
                    self.navigationItem.leftBarButtonItem.tintColor=globelColor;
                    
                }
                else
                {
                    
                    //        scrlcontent.scrollEnabled=YES;
                    
                }
                
            }
        }
        
        
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    serviceCount = 0;
    if ([isfromBooking isEqualToString:@"YES"])
    {
        [self.navigationItem setHidesBackButton:YES];
        self.navigationItem.title = @"Login";
        
    }
    else if ([strIsfromCalender isEqualToString:@"YES"])
    {
        [self.navigationItem setHidesBackButton:YES];
        self.navigationItem.title = @"Login";
    }
    else if ([strIsfromRate isEqualToString:@"YES"])
    {
        [self.navigationItem setHidesBackButton:YES];
        self.navigationItem.title = @"Login";
    }
    else
    {
      //  [self showTabBar:self.tabBarController];
        [self.navigationItem setHidesBackButton:YES];
        self.navigationItem.title = @"Login";
    }
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"isLogin"]isEqualToString:@"YES"])
    {
        
        NSString *customerId = [[[NSUserDefaults standardUserDefaults]valueForKey:@"data"]valueForKey:@"customer_id"];
        if ([customerId isEqualToString:@""]||customerId==nil)
        {
        }
        else
        {
            ProfileVC * profil =[[ProfileVC alloc] init];
            [self.navigationController pushViewController:profil animated:YES];
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    //[self showTabBar:self.tabBarController];
     self.navigationController.title = @"";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)BackBtnClick
{
    if ([isfromBooking isEqualToString:@"YES"])
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Alert " message:@"Are you sure you don't want to login ?" cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        alert.tag=0;
        
        [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
         {
             
             [alertView hideWithCompletionBlock:^{
                 
                 if (buttonIndex == 0)
                 {
                     
                     [self.navigationController popViewControllerAnimated:YES];
                 }
                 else
                 {
                     
                 }
                 
                 
             }];
         }];
        [alert showWithAnimation:URBalertAnimationType];;
    }
    else if ([strIsfromCalender isEqualToString:@"YES"])
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Alert " message:@"Are you sure you don't want to login ?" cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        alert.tag=0;
        
        [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
         {
             
             [alertView hideWithCompletionBlock:^{
                 
                 if (buttonIndex == 0)
                 {
                   //  [self showTabBar:self.tabBarController];
                     self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
                     [self.tabBarController setSelectedIndex:2];
                     self.tabBarController.selectedIndex=2;
                     [self.navigationController popToRootViewControllerAnimated:YES];
                 }
                 else
                 {
                     
                 }
                 
                 
             }];
         }];
        [alert showWithAnimation:URBalertAnimationType];;
    }
    else if ([strIsfromRate isEqualToString:@"YES"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}



#pragma mark- Button Click Method
-(void)forgetClick
{
    
     NSLog(@"Click");
    
    
    
    [txtPassword resignFirstResponder];
    [txtUserName resignFirstResponder];
    
    ForgatePasswordViewController *frg=[[ForgatePasswordViewController alloc]init];
    
    if (isfromBooking) {
        frg.isfromBooking=@"YES";

    }
    else if (strIsfromRate)
    {
        frg.strIsfromRate=@"YES";
    }
   // self.navigationItem.title = @"Back";
   // [self.navigationItem setHidesBackButton:NO];
    frg.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:frg animated:YES];
    
}
-(void)hideProgressBar
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    
    URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Login " message:@"User Login successfully" cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
    [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
     {
         [alertView hideWithCompletionBlock:^{
            // [self showTabBar:tabBarController];

             self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
             [self.tabBarController setSelectedIndex:2];
             self.tabBarController.selectedIndex=2;
             [self.navigationController popToRootViewControllerAnimated:YES];
         }];
//
         
     }];
    [alert showWithAnimation:URBalertAnimationType];;
    
    
}
-(void)loginBtnClick
{
//     [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
//    [txtPassword resignFirstResponder];
//    [txtUserName resignFirstResponder];
//    
//    [self performSelector:@selector(hideProgressBar) withObject:nil afterDelay:2];

    if ([txtUserName.text length]==0)
    {
        
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Required!" message:@"Please enter email id." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
         [alert showWithAnimation:URBalertAnimationType];;

    }
    else if ([self validateEmail:txtUserName.text] ==NO)
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Required!" message:@"Please enter valid email id." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
         [alert showWithAnimation:URBalertAnimationType];;
    }
    else if ([txtPassword.text length]==0)
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Required!" message:@"Please enter password." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        
         [alert showWithAnimation:URBalertAnimationType];;
    } 
    
    else if ([self isPasswordValid:txtPassword.text]==NO)
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Error" message:@"Please ensure that you have at least one lower case letter, one upper case letter, one digit, one special character and at least six digit length" cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        
         [alert showWithAnimation:URBalertAnimationType];;
    }
    else
    {
        
        [txtUserName resignFirstResponder];
        [txtPassword resignFirstResponder];
        
        serviceCount = serviceCount +1;
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
       
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:txtUserName.text forKey:@"email"];
        [dict setValue:txtPassword.text forKey:@"password"];
        [dict setValue:@"ios" forKey:@"device_token"];
       // [dict setValue:@"Normal" forKey:@"login_via"];
        NSString *deviceToken =[[NSUserDefaults standardUserDefaults]valueForKey:@"deviceToken"];
        if (deviceToken ==nil)
        {
            [dict setValue:@"123" forKey:@"device_token"];
        }
        else
        {
            [dict setValue:deviceToken forKey:@"device_token"];
        }
        [dict setValue:@"ios" forKey:@"device_type"];
        
        URLManager *manager = [[URLManager alloc] init];
        manager.commandName = @"login";
        manager.delegate = self;
        [manager urlCall:@"http://snapnurse.com/nurse/login" withParameters:dict];
    }
}
-(void)registerBtnClick
{
    RegisterVC * view = [[RegisterVC alloc] init];
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
}
#pragma mark Password Check

-(BOOL) isPasswordValid:(NSString *)pwd {
    
    NSCharacterSet *upperCaseChars = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLKMNOPQRSTUVWXYZ"];
    NSCharacterSet *lowerCaseChars = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz"];
    
    //NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    if ( [pwd length]<6 || [pwd length]>20 )
        return NO;  // too long or too short
    NSRange rang;
    rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
    if ( !rang.length )
        return NO;  // no letter
    rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
    if ( !rang.length )
        return NO;  // no number;
    rang = [pwd rangeOfCharacterFromSet:upperCaseChars];
    if ( !rang.length )
        return NO;  // no uppercase letter;
    rang = [pwd rangeOfCharacterFromSet:lowerCaseChars];
    if ( !rang.length )
        return NO;  // no lowerCase Chars;
    return YES;
}

#pragma mark Email validation
-(BOOL)validateEmail:(NSString*)email
{
    
    if( (0 != [email rangeOfString:@"@"].length) &&  (0 != [email rangeOfString:@"."].length) ){
        NSMutableCharacterSet *invalidCharSet = [[[NSCharacterSet alphanumericCharacterSet] invertedSet]mutableCopy];
        [invalidCharSet removeCharactersInString:@"_-"];
        
        NSRange range1 = [email rangeOfString:@"@" options:NSCaseInsensitiveSearch];
        
        // If username part contains any character other than "."  "_" "-"
        
        NSString *usernamePart = [email substringToIndex:range1.location];
        NSArray *stringsArray1 = [usernamePart componentsSeparatedByString:@"."];
        for (NSString *string in stringsArray1)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet: invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return FALSE;
        }
        NSString *domainPart = [email substringFromIndex:range1.location+1];
        NSArray *stringsArray2 = [domainPart componentsSeparatedByString:@"."];
        
        for (NSString *string in stringsArray2)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return FALSE;
        }
        return TRUE;
    }
    else
    {// no '@' or '.' present
        return FALSE;
    }
}

-(void)checkUserEmailRegisterInDBWebServiceWithFacebookDict:(NSMutableDictionary*)fbJsonDictData
{
    fbdata=[[NSMutableDictionary alloc]init];
    fbdata=fbJsonDictData;
    
    
    NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc]init];
    [parameter_dict setObject:[fbJsonDictData valueForKey:@"id"] forKey:@"social_id"];
    
    NSString *fbUserImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [fbJsonDictData objectForKey:@"id"]];
    
    UIImage * image1 = [self imageWithURLString:fbUserImageURL];
    NSData * imgData = UIImagePNGRepresentation(image1);
    NSString *encodedImage =[imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    if ([fbJsonDictData valueForKey:@"id"] !=[NSNull null] || [fbJsonDictData valueForKey:@"id"] != NULL || ![[fbJsonDictData valueForKey:@"id"] isEqualToString:@""])
    {
        [parameter_dict setObject:[fbJsonDictData valueForKey:@"email"] forKey:@"facebook_id"];
    }else{
        [parameter_dict setObject:@"" forKey:@"facebook_id"];
    }
    
    if ([fbJsonDictData valueForKey:@"email"] !=[NSNull null] || [fbJsonDictData valueForKey:@"email"] != NULL || ![[fbJsonDictData valueForKey:@"email"] isEqualToString:@""])
    {
        [parameter_dict setObject:[fbJsonDictData valueForKey:@"email"] forKey:@"email"];
    }else{
        [parameter_dict setObject:@"" forKey:@"email"];
    }
    
    if ([fbJsonDictData valueForKey:@"first_name"] !=[NSNull null] || [fbJsonDictData valueForKey:@"first_name"] != NULL || ![[fbJsonDictData valueForKey:@"first_name"] isEqualToString:@""])
    {
        [parameter_dict setObject:[fbJsonDictData valueForKey:@"first_name"] forKey:@"user_first_name"];
    }else{
        [parameter_dict setObject:@"" forKey:@"user_first_name"];
    }
    
    if ([fbJsonDictData valueForKey:@"last_name"] !=[NSNull null] || [fbJsonDictData valueForKey:@"last_name"] != NULL || ![[fbJsonDictData valueForKey:@"last_name"] isEqualToString:@""])
    {
        [parameter_dict setObject:[fbJsonDictData valueForKey:@"last_name"] forKey:@"user_last_name"];
    }else{
        [parameter_dict setObject:@"" forKey:@"user_last_name"];
    }
    
    
    if ([encodedImage isEqualToString:@""] || [encodedImage isEqual:[NSNull null]] || encodedImage == nil || [encodedImage isEqualToString:@"(null)"] || [encodedImage isEqualToString:@"nil"]){
        [parameter_dict setObject:@"" forKey:@"user_image"]; //kp 412 temprorary blank
    }else{
        [parameter_dict setObject:encodedImage forKey:@"user_image"]; //kp 412 temprorary blank
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:parameter_dict forKey:@"detailArr"];
    [[NSUserDefaults standardUserDefaults] setValue:@"Facebook" forKey:@"loginvia"];
    [[NSUserDefaults standardUserDefaults]setValue:@"YES" forKey:@"isLogin"];

    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[fbJsonDictData valueForKey:@"email"] forKey:@"email"];
    [dict setValue:@"Facebook" forKey:@"register_via"];
    
    
    
    URLManager *manager = [[URLManager alloc] init];
    manager.commandName = @"CheckFbid";
    manager.delegate = self;
    [manager urlCall:@"http://snapnurse.com/nurse/webservice/checkStatus" withParameters:dict];
    
    
    
}
#pragma ----
#pragma ----

#pragma mark - UITextfield Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
     NSLog(@"Here is the txt tag=%d",[textField tag]);
    
    
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    //    textField.textColor=[UIColor colorWithHexString:@"52b5df"];
    return YES;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==txtUserName)
    {
        [txtPassword becomeFirstResponder];
    }
    else if (textField==txtPassword)
    {
        [textField resignFirstResponder];
    }
    
    
    
    return YES;
    
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark - getImageFromData
- (UIImage *)imageWithURLString:(NSString *)string
{
    NSURL *url = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

-(void)remember
{
    
    if (Isremeber) {
        rememberImg.image=[UIImage imageNamed:@""];
        Isremeber=NO;

    }
    else
    {
        rememberImg.image=[UIImage imageNamed:@"yes"];
        Isremeber=YES;
        
    }
}
#pragma mark UrlManager Delegates

- (void)onResult:(NSDictionary *)result
{
     NSLog(@"The result is...%@", result);
    
    serviceCount = 0;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];

    if([[result valueForKey:@"commandName"] isEqualToString:@"login"])//jam27-07
    {
        if ([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
        {
            NSString *loginId=[[[[[result valueForKey:@"result"]valueForKey:@"data"]valueForKey:@"hotels"]objectAtIndex:0] valueForKey:@"hotel_id"];
            
            [[NSUserDefaults standardUserDefaults] setValue:loginId forKey:@"user_id"];
            [[NSUserDefaults standardUserDefaults] setValue:@"Normal" forKey:@"loginvia"];
            [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
                URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Login " message:@"User logged in successfully" cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
                alert.tag=0;
                
                [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
                 {
                     [alertView hideWithCompletionBlock:^{
                         
                         if ([isfromBooking isEqualToString:@"YES"])
                         {
                             NSArray *array = [self.navigationController viewControllers];
                             [self.navigationController popToViewController:[array objectAtIndex:2]animated:YES];
                         }
                         else if ([strIsfromRate isEqualToString:@"YES"])
                         {
                             NSArray *array = [self.navigationController viewControllers];
                             [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
                         }
                         else if ([strIsfromCalender isEqualToString:@"YES"])
                         {
                             NSArray *array = [self.navigationController viewControllers];
                             [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
                         }
                         else
                         {
                             //        [self GOTONEXTVIEW];
                             ProfileVC * profil =[[ProfileVC alloc] init];
                             [self.navigationController pushViewController:profil animated:YES];
                             
                         }
                         
                     }];
                 }];
                [alert showWithAnimation:URBalertAnimationType];;
            
            
        }
        else
        {
            URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"sign up" message:[[result valueForKey:@"result"] valueForKey:@"msg"] cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
            
             [alert showWithAnimation:URBalertAnimationType];;
//
        }
    }
    else
    {
         NSLog(@"Wrong");
        
    }
    
}
- (void)onError:(NSError *)error
{
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
     NSLog(@"Login The error is...%@", error);
    
    NSInteger ancode = [error code];
    
    if (ancode == -1009)
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Booking" message:@"There is no network connectivity. This application requires a network connection." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
         [alert showWithAnimation:URBalertAnimationType];;
    }
    else if(ancode == -1001)
    {
        if (isError == NO)
        {
            isError = YES;
            URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Booking" message:@"The request time out." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
            [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                [alertView hideWithCompletionBlock:^{
                    isError = NO;
                }];
            }];
            
            [alert showWithAnimation:URBalertAnimationType];;
            
        }
        else
        {
            
        }
    }
    else
    {
//        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Booking" message:[error localizedDescription] cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
//         [alert showWithAnimation:URBalertAnimationType];;
    }
    
    
}
- (void)onNetworkError:(NSError *)error didFailWithCommandName:(NSString *)commandName
{
    NSLog(@"OnNetworkErrorCall");
    if (error.code == -1005)
    {
        if ([commandName isEqualToString:@"login"])
        {
            if (serviceCount >=3)
            {
                serviceCount = 0;
                URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"" message:@"Something went wrong please try again later." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
                
                [alert showWithAnimation:URBalertAnimationType];;
            }
            else
            {
                [self loginBtnClick];
            }
        }
    }
}






#pragma mark Sing up Naviagation
-(void)singup
{
    
    if ([isfromBooking isEqualToString:@"YES"])
    {
        NSArray *array = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[array objectAtIndex:2]animated:YES];
    }
    else if ([strIsfromRate isEqualToString:@"YES"])
    {
        NSArray *array = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
    }
    else if ([strIsfromCalender isEqualToString:@"YES"])
    {
        NSArray *array = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
    }
    else
    {
//        [self GOTONEXTVIEW];
        ProfileVC * profil =[[ProfileVC alloc] init];
        [self.navigationController pushViewController:profil animated:YES];
    
    }
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return viewController != tabBarController.selectedViewController;
}
-(void)GOTONEXTVIEW
{
    AppDelegate * ap=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    BookingVC   *home=[[BookingVC alloc]init];
   NotificationVC *Booking = [[NotificationVC alloc]init];
    LoginVC *ProfVC = [[LoginVC alloc]init];
     FaqVC *faqvc=[[FaqVC alloc]init];
    
    ProfVC = [[LoginVC alloc]init];
    
    tabBarController = [[UITabBarController alloc] init];
    tabBarController.tabBar.tintColor=[UIColor blackColor];
    tabBarController.tabBar.backgroundColor=[UIColor blackColor];
    tabBarController.delegate=self;
    tabBarController.tabBar.backgroundImage=[UIImage imageNamed:@"footer"];
     //tabBarController.tabBar.backgroundColor = [UIColor colorWithRed:0/255.0f green:32.0f/255.0f blue:194.0f/255.0f alpha:1];
    
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
    UIImage *ProfileIcon = [UIImage imageNamed:@"selected-profile"];//
    UIImage *ProfileIconUnselected = [UIImage imageNamed:@"profile"];//
    UITabBarItem *ProfileItem = [[UITabBarItem alloc] initWithTitle:nil image:ProfileIconUnselected selectedImage:ProfileIcon];
    UINavigationController *ProfileNav = [[UINavigationController alloc] initWithRootViewController: ProfVC];
    
    [ProfileNav.navigationBar setTranslucent:NO];
    ProfileNav.tabBarItem = ProfileItem;
    
    ProfileNav.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0, -5, 0);;
    ProfileItem.image = [ProfileIcon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    NSArray* controllers = [NSArray arrayWithObjects: Home,bokkingNav, ProfileNav, nil];
    [tabBarController setViewControllers: controllers animated:NO];
    [ap.window addSubview:tabBarController.view];
    
    // Set bar button tint color to app theme color
    [[UIBarButtonItem appearance] setTintColor:[UIColor clearColor]];
    // Set Tab Bar Items Selected Tint color to App Theme Color
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:12.0/255.0 green:12.0/255.0 blue:37.0/255.0 alpha:1.0]];
   // [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:12.0/255.0 green:12.0/255.0 blue:37.0/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UITabBar appearance] setTintColor:[UIColor blackColor]];
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}



- (void)didDisconnectWithError:(NSError *)error;
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];

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
