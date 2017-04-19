//
//  ForgatePasswordViewController.m
//  Snuzo App
//
//  Created by Oneclick IT on 9/22/15.
//  Copyright © 2015 Oneclick IT. All rights reserved.
//

#import "ForgatePasswordViewController.h"

@interface ForgatePasswordViewController ()

@end

@implementation ForgatePasswordViewController
@synthesize isfromBooking,strIsfromRate;

-(void)viewWillAppear:(BOOL)animated
{
    
   // [self hideTabBar:self.tabBarController];
    
    self.navigationItem.title = @"Forgot Password";
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:globelColor}];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    serviceCount = 0;

    self.navigationItem.title = @"Forgot Password";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:globelColor}];
    
     UIImageView *bg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, viewHeight)];
    bg.image=[UIImage imageNamed:@"bg-ip-5"];
    [self.view addSubview:bg];
    
    UIView * backView = [[UIView alloc] init];
    backView.frame = CGRectMake(0, 0, self.view.frame.size.width, viewHeight);
    
    backView.backgroundColor = [UIColor whiteColor];
    backView.alpha = 0.5;
    [self.view addSubview:backView];
    UIImageView * logoImg =[[UIImageView alloc] init];
    logoImg.frame=CGRectMake(64, 15, 192, 51);
    
    if (IS_IPHONE_4)
    {
        bg.image=[UIImage imageNamed:@"bg-ip-4.png"];
    }
    else if (IS_IPHONE_6plus)
    {
        logoImg.frame=CGRectMake(111, 19, 192, 51);
        bg.image=[UIImage imageNamed:@"bg-ip-6plus.png"];
    }
    else if (IS_IPHONE_6)
    {
        logoImg.frame=CGRectMake(91.5, 19, 192, 51);
        bg.image=[UIImage imageNamed:@"bg-ip-6.png"];
    }
    logoImg.image=[UIImage imageNamed:@"nursingLogo.png"];
    [self.view addSubview:logoImg];
    
    UIBarButtonItem * backbarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back icon"]
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(BackBtnClick)];
    self.navigationItem.leftBarButtonItem=backbarBtn;
    self.navigationItem.leftBarButtonItem.tintColor=globelColor;
    
    UIImageView *nameview=[[UIImageView alloc]initWithFrame:CGRectMake(33,120, self.view.frame.size.width-66, 39)];
    nameview.image=[UIImage imageNamed:@"text-field.png"];
    nameview.userInteractionEnabled = YES;
    [self.view addSubview:nameview];
    
    
    txtUserName=[[UITextField alloc]initWithFrame:CGRectMake(10,0, nameview.frame.size.width-10, 39)];
    UIColor *color = [UIColor lightGrayColor];
    txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email id" attributes:@{NSForegroundColorAttributeName: color}];
    txtUserName.textAlignment=NSTextAlignmentLeft;
    txtUserName.delegate=self;
    txtUserName.backgroundColor=[UIColor clearColor];
    txtUserName.layer.cornerRadius=1.0;
    txtUserName.returnKeyType=UIReturnKeyDone;
    txtUserName.keyboardType=UIKeyboardTypeEmailAddress;
    
    [nameview addSubview:txtUserName];
    
    UIButton * loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.backgroundColor=[UIColor clearColor];
    loginBtn.frame=CGRectMake(33,200,self.view.frame.size.width-66,39);
    [loginBtn addTarget:self action:@selector(getpassword) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.titleLabel.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15];
    [loginBtn setTitle:@"Get password" forState:UIControlStateNormal];
    loginBtn.backgroundColor=globelColor;
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius=2.0f;
    [self.view addSubview:loginBtn];
    
    
    // Do any additional setup after loading the view.
}

#pragma mark --- Back buttonClick

-(void)BackBtnClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    [self.navigationController popViewControllerAnimated:YES];
//    [self showTabBar:self.tabBarController];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Forget  password

-(void)getpassword
{
    
    [txtUserName resignFirstResponder];
    
    
    if ([txtUserName.text isEqualToString:@""])
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Required!" message:@"Please enter Email Id." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        
         [alert showWithAnimation:URBalertAnimationType];;
    }
    else if ([self validateEmail:txtUserName.text] ==NO)
    {
        
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Required!" message:@"Please enter Valid Email Id." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        
         [alert showWithAnimation:URBalertAnimationType];;
    }
    else
    {
        serviceCount = serviceCount+1;

        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:txtUserName.text forKey:@"email"];
        URLManager *manager = [[URLManager alloc] init];
        manager.commandName = @"Forgot";
        manager.delegate = self;
        [manager urlCall:@"http://snapnurse.com/nurse/forgotPassword" withParameters:dict];
    }
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


#pragma mark touche method

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.view endEditing:YES];
    }
}

#pragma mark UrlManager Delegates


- (void)onResult:(NSDictionary *)result
{
    serviceCount = 0;

     NSLog(@"The result is...%@", result);
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    if ([[result valueForKey:@"commandName"]isEqualToString:@"Forgot"])
    {
        if ([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
        {
            URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Error" message:[[result valueForKey:@"result"]valueForKey:@"msg"] cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
            [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
             {
                 
                    [alertView hideWithCompletionBlock:^{
                     [self.navigationController popToRootViewControllerAnimated:YES];
                     
                     
                 }];
             }];
            
             [alert showWithAnimation:URBalertAnimationType];;
        }
        else
        {
            URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Error" message:[[result valueForKey:@"result"]valueForKey:@"msg"] cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
            
             [alert showWithAnimation:URBalertAnimationType];;

        }
    }
    else
    {
        
    }
    
   
    
}
- (void)onError:(NSError *)error
{
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    
    //    [app hudEndProcessMethod];
     NSLog(@"Forgot Password The error is...%@", error);
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
//        
//         [alert showWithAnimation:URBalertAnimationType];;
    }
    
    
}
- (void)onNetworkError:(NSError *)error didFailWithCommandName:(NSString *)commandName
{
    NSLog(@"OnNetworkErrorCall");
    if (error.code == -1005)
    {
        if ([commandName isEqualToString:@"Forgot"])
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
                [self getpassword];
            }
        }
    }
}


#pragma mark - UITextfield Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
        [textField resignFirstResponder];
       return YES;
    
}

#pragma mark Email validation


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
