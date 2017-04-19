//
//  RegisterVC.m
//  Nurse
//
//  Created by One Click IT Consultancy  on 10/22/16.
//  Copyright © 2016 com.Oneclick.apps. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()

@end

@implementation RegisterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Register";
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
    if (IS_IPHONE_4)
    {
        bg.image=[UIImage imageNamed:@"bg-ip-4.png"];
    }
    else if (IS_IPHONE_6)
    {
        bg.image=[UIImage imageNamed:@"bg-ip-6.png"];
    }
    else if (IS_IPHONE_6plus)
    {
        bg.image=[UIImage imageNamed:@"bg-ip-6plus.png"];
    }
    
    
    UIBarButtonItem * backbarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back icon"]
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(BackBtnClick)];
    self.navigationItem.leftBarButtonItem=backbarBtn;
    self.navigationItem.leftBarButtonItem.tintColor=globelColor;
    
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame= CGRectMake(0, 0, self.view.frame.size.width,viewHeight);
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, viewHeight+100);
    //[self.view addSubview:scrollView];
    
    keyBordScrollView = [[TPKeyboardAvoidingScrollView alloc] init];
    keyBordScrollView.frame= CGRectMake(0, 0, self.view.frame.size.width,viewHeight);
    keyBordScrollView.delegate = self;
    keyBordScrollView.backgroundColor = [UIColor clearColor];
    keyBordScrollView.contentSize = CGSizeMake(self.view.frame.size.width, viewHeight+100);
    [self.view addSubview:keyBordScrollView];
    
    int y=15;
    
    UIImageView *nameview=[[UIImageView alloc]initWithFrame:CGRectMake(33,y, self.view.frame.size.width-66, 39)];
    nameview.image=[UIImage imageNamed:@"text-field.png"];
    nameview.userInteractionEnabled = YES;
    [keyBordScrollView addSubview:nameview];
    
    txtUserName=[[UITextField alloc]initWithFrame:CGRectMake(10,0, nameview.frame.size.width-10, 39)];
    UIColor *color = [UIColor lightGrayColor];
    txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: color}];
    txtUserName.textAlignment=NSTextAlignmentLeft;
    txtUserName.delegate=self;
    txtUserName.backgroundColor=[UIColor clearColor];
    txtUserName.layer.cornerRadius=1.0;
    txtUserName.returnKeyType=UIReturnKeyNext;
    txtUserName.keyboardType=UIKeyboardTypeDefault;
     txtUserName.font = [UIFont systemFontOfSize:16];
    [nameview addSubview:txtUserName];
    
    y = y + 50;
    
    UIImageView *contactview=[[UIImageView alloc]initWithFrame:CGRectMake(33,y, self.view.frame.size.width-66, 39)];
    contactview.image=[UIImage imageNamed:@"text-field.png"];
    contactview.userInteractionEnabled = YES;
    [keyBordScrollView addSubview:contactview];
    
    txtContactNo=[[UITextField alloc]initWithFrame:CGRectMake(10,0, nameview.frame.size.width-10, 39)];
    txtContactNo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Contact No" attributes:@{NSForegroundColorAttributeName: color}];
    txtContactNo.textAlignment=NSTextAlignmentLeft;
    txtContactNo.delegate=self;
    txtContactNo.backgroundColor=[UIColor clearColor];
    txtContactNo.layer.cornerRadius=1.0;
    txtContactNo.returnKeyType=UIReturnKeyNext;
    txtContactNo.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    txtContactNo.font = [UIFont systemFontOfSize:16];
    [contactview addSubview:txtContactNo];
    
    y = y + 50;
    
    UIImageView *emailview=[[UIImageView alloc]initWithFrame:CGRectMake(33,y, self.view.frame.size.width-66, 39)];
    emailview.image=[UIImage imageNamed:@"text-field.png"];
    emailview.userInteractionEnabled = YES;
    [keyBordScrollView addSubview:emailview];
    
    txtEmail=[[UITextField alloc]initWithFrame:CGRectMake(10,0, emailview.frame.size.width-10, 39)];
    txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    txtEmail.textAlignment=NSTextAlignmentLeft;
    txtEmail.delegate=self;
    txtEmail.backgroundColor=[UIColor clearColor];
    txtEmail.layer.cornerRadius=1.0;
    txtEmail.returnKeyType=UIReturnKeyNext;
    txtEmail.keyboardType=UIKeyboardTypeEmailAddress;
    txtEmail.font = [UIFont systemFontOfSize:16];
    [emailview addSubview:txtEmail];
    
    y = y + 50;
    
    UIImageView *addressview=[[UIImageView alloc]initWithFrame:CGRectMake(33,y, self.view.frame.size.width-66, 60)];
    addressview.image=[UIImage imageNamed:@"text-field.png"];
    addressview.userInteractionEnabled = YES;
    [keyBordScrollView addSubview:addressview];
    
    txtAddress=[[UITextView alloc]initWithFrame:CGRectMake(5,0, addressview.frame.size.width-10, 60)];
    txtAddress.text = @"Address";
    txtAddress.textColor = color;
    txtAddress.textAlignment=NSTextAlignmentLeft;
    txtAddress.delegate=self;
    txtAddress.backgroundColor=[UIColor clearColor];
    txtAddress.layer.cornerRadius=1.0;
    txtAddress.font = [UIFont systemFontOfSize:16];
    txtAddress.returnKeyType=UIReturnKeyNext;
    txtAddress.keyboardType=UIKeyboardTypeDefault;
    [addressview addSubview:txtAddress];
    
    y = y + 60 + 11;
    
    UIImageView *cityview=[[UIImageView alloc]initWithFrame:CGRectMake(33,y, self.view.frame.size.width-66, 39)];
    cityview.image=[UIImage imageNamed:@"text-field.png"];
    cityview.userInteractionEnabled = YES;
    [keyBordScrollView addSubview:cityview];
    
    txtCity=[[UITextField alloc]initWithFrame:CGRectMake(10,0, cityview.frame.size.width-10, 39)];
    txtCity.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"City" attributes:@{NSForegroundColorAttributeName: color}];
    txtCity.textAlignment=NSTextAlignmentLeft;
    txtCity.delegate=self;
    txtCity.backgroundColor=[UIColor clearColor];
    txtCity.layer.cornerRadius=1.0;
    txtCity.returnKeyType=UIReturnKeyNext;
    txtCity.keyboardType=UIKeyboardTypeEmailAddress;
     txtCity.font = [UIFont systemFontOfSize:16];
    [cityview addSubview:txtCity];
    
    y = y + 50;
    
    UIImageView *zipCodeview=[[UIImageView alloc]initWithFrame:CGRectMake(33,y, self.view.frame.size.width-66, 39)];
    zipCodeview.image=[UIImage imageNamed:@"text-field.png"];
    zipCodeview.userInteractionEnabled = YES;
    [keyBordScrollView addSubview:zipCodeview];
    
    txtZipCode=[[UITextField alloc]initWithFrame:CGRectMake(10,0, zipCodeview.frame.size.width-10, 39)];
    txtZipCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Zip Code" attributes:@{NSForegroundColorAttributeName: color}];
    txtZipCode.textAlignment=NSTextAlignmentLeft;
    txtZipCode.delegate=self;
    txtZipCode.backgroundColor=[UIColor clearColor];
    txtZipCode.layer.cornerRadius=1.0;
    txtZipCode.returnKeyType=UIReturnKeyNext;
    txtZipCode.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    txtZipCode.font = [UIFont systemFontOfSize:16];
    [zipCodeview addSubview:txtZipCode];
    
    y = y + 50;
    
    UIImageView *specialview=[[UIImageView alloc]initWithFrame:CGRectMake(33,y, self.view.frame.size.width-66, 60)];
    specialview.image=[UIImage imageNamed:@"text-field.png"];
    specialview.userInteractionEnabled = YES;
    [keyBordScrollView addSubview:specialview];
    
    txtSpecialization=[[UITextView alloc]initWithFrame:CGRectMake(5,0, specialview.frame.size.width-10, 60)];
    txtSpecialization.text = @"Specialization";
    txtSpecialization.textColor = color;
    txtSpecialization.textAlignment=NSTextAlignmentLeft;
    txtSpecialization.font = [UIFont systemFontOfSize:16];
    txtSpecialization.delegate=self;
    txtSpecialization.backgroundColor=[UIColor clearColor];
    txtSpecialization.layer.cornerRadius=1.0;
    txtSpecialization.returnKeyType=UIReturnKeyNext;
    txtSpecialization.keyboardType=UIKeyboardTypeDefault;
    [specialview addSubview:txtSpecialization];
    
    y = y + 60 +11;
    
    UIImageView *descriptionview=[[UIImageView alloc]initWithFrame:CGRectMake(33,y, self.view.frame.size.width-66, 60)];
    descriptionview.image=[UIImage imageNamed:@"text-field.png"];
    descriptionview.userInteractionEnabled = YES;
    [keyBordScrollView addSubview:descriptionview];
    
    txtDescription=[[UITextView alloc]initWithFrame:CGRectMake(5,0, descriptionview.frame.size.width-10, 60)];
    txtDescription.text = @"Description";
    txtDescription.textColor = color;
    txtDescription.textAlignment=NSTextAlignmentLeft;
    txtDescription.delegate=self;
    txtDescription.font = [UIFont systemFontOfSize:16];
    txtDescription.backgroundColor=[UIColor clearColor];
    txtDescription.layer.cornerRadius=1.0;
    txtDescription.returnKeyType=UIReturnKeyDone;
    txtDescription.keyboardType=UIKeyboardTypeDefault;
    [descriptionview addSubview:txtDescription];
    
    y = y + 60 +11;
    
    registerbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    registerbtn.backgroundColor=[UIColor clearColor];
    registerbtn.frame=CGRectMake(33, y, self.view.frame.size.width-66, 40);
    [registerbtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    registerbtn.titleLabel.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:15];
    [registerbtn setTitle:@"Register" forState:UIControlStateNormal];
    registerbtn.backgroundColor=globelColor;
    [registerbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerbtn.layer.cornerRadius=2.0f;
    [keyBordScrollView addSubview:registerbtn];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    
   // [self hideTabBar:self.tabBarController];
    
    self.navigationItem.title = @"Register";
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:globelColor}];
}

#pragma mark - Button Avtions
-(void)BackBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)registerBtnClick
{
    if ([txtUserName.text isEqualToString:@""])
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"sign up" message:@"Please enter name" cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        
        [alert showWithAnimation:URBalertAnimationType];;
    }
    else if ([txtContactNo.text isEqualToString:@""])
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"sign up" message:@"Please enter contact number" cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        
        [alert showWithAnimation:URBalertAnimationType];;
    }
    else if ([txtEmail.text isEqualToString:@""])
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"sign up" message:@"Please enter email id" cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        
        [alert showWithAnimation:URBalertAnimationType];;
    }
    else if (![self validateEmail:txtEmail.text])
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"sign up" message:@"Please enter valid email id" cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        
        [alert showWithAnimation:URBalertAnimationType];;
    }
    else if ([txtAddress.text isEqualToString:@""]||[txtAddress.text isEqualToString:@"Address"])
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"sign up" message:@"Please enter address" cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        
        [alert showWithAnimation:URBalertAnimationType];;
    }
    else if ([txtCity.text isEqualToString:@""])
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"sign up" message:@"Please enter city" cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        
        [alert showWithAnimation:URBalertAnimationType];;

    }
    else if ([txtZipCode.text isEqualToString:@""])
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"sign up" message:@"Please enter zipcode" cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        
        [alert showWithAnimation:URBalertAnimationType];;
    }
    else if ([txtSpecialization.text isEqualToString:@""]||[txtSpecialization.text isEqualToString:@"Specialization"])
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"sign up" message:@"Please enter specialization" cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        
        [alert showWithAnimation:URBalertAnimationType];;
    }
    else if ([txtDescription.text isEqualToString:@""]||[txtDescription.text isEqualToString:@"Description"])
    {
        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"sign up" message:@"Please enter description" cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
        
        [alert showWithAnimation:URBalertAnimationType];;
    }
    else
    {
        [txtUserName resignFirstResponder];
        [txtContactNo resignFirstResponder];

        serviceCount = serviceCount + 1;
        
        if (serviceCount == 1)
        {
             [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
        }
        else
        {
            
        }
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
        [dict setValue:txtUserName.text forKey:@"nurse_name"];
        [dict setValue:txtContactNo.text forKey:@"contact_no"];
        [dict setValue:txtAddress.text forKey:@"address"];
        [dict setValue:txtCity.text forKey:@"city"];
        [dict setValue:txtZipCode.text forKey:@"zipcode"];
        [dict setValue:txtEmail.text forKey:@"nurse_email"];
        [dict setValue:txtSpecialization.text forKey:@"specialization"];
        [dict setValue:txtDescription.text forKey:@"description"];
        
        URLManager *manager = [[URLManager alloc] init];
        manager.commandName = @"register";
        manager.delegate = self;
        [manager urlCall:@"http://snapnurse.com/nurse/quiknurse/nurse/NurseContactEnquiry" withParameters:dict];
    }
    
}

#pragma mark UrlManager Delegates

- (void)onResult:(NSDictionary *)result
{
    NSLog(@"The result is...%@", result);
    
    serviceCount = 0;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    
    if([[result valueForKey:@"commandName"] isEqualToString:@"register"])//jam27-07
    {
        if ([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
        {
            
            URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Login " message:@"Register successfully" cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
            alert.tag=0;
            
            [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
             {
                 [alertView hideWithCompletionBlock:^{
                     
                     [self.navigationController popViewControllerAnimated:YES];
                     
                 }];
             }];
            [alert showWithAnimation:URBalertAnimationType];;
            
            
        }
        else
        {
            URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"sign up" message:[[result valueForKey:@"result"] valueForKey:@"msg"] cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
            
            [alert showWithAnimation:URBalertAnimationType];;
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
                [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
                URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"" message:@"Something went wrong please try again later." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
                
                [alert showWithAnimation:URBalertAnimationType];;
            }
            else
            {
                [self registerBtnClick];
            }
        }
    }
}


#pragma mark - UITextfield Delegate Methods
- (BOOL) textView: (UITextView*) textView
shouldChangeTextInRange: (NSRange) range
  replacementText: (NSString*) text
{
    if ([text isEqualToString:@"\n"])
    {
        
        if (textView == txtAddress)
        {
            [txtCity becomeFirstResponder];
        }
        else if (textView == txtSpecialization)
        {
            [txtDescription becomeFirstResponder];
        }
        else if (textView == txtDescription)
        {
            [textView resignFirstResponder];
        }
        
        return NO;
    }
    
   
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView == txtAddress)
    {
        if ([txtAddress.text isEqualToString:@"Address"])
        {
            txtAddress.text = @"";
            txtAddress.textColor = [UIColor blackColor];
        }
        else
        {
            
        }
    }
    else if (textView == txtSpecialization)
    {
        if ([txtSpecialization.text isEqualToString:@"Specialization"])
        {
            txtSpecialization.text = @"";
            txtSpecialization.textColor = [UIColor blackColor];
        }
        else
        {
            
        }
    }
    else if (textView == txtDescription)
    {
        if ([txtDescription.text isEqualToString:@"Description"])
        {
            txtDescription.text = @"";
            txtDescription.textColor = [UIColor blackColor];
        }
        else
        {
            
        }
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == txtAddress)
    {
        if ([txtAddress.text isEqualToString:@""])
        {
            txtAddress.text = @"Address";
            txtAddress.textColor = [UIColor lightGrayColor];
        }
        else
        {
            
        }
    }
    else if (textView == txtSpecialization)
    {
        if ([txtSpecialization.text isEqualToString:@""])
        {
            txtSpecialization.text = @"Specialization";
            txtSpecialization.textColor = [UIColor lightGrayColor];
        }
        else
        {
            
        }
    }
    else if (textView == txtDescription)
    {
        if ([txtDescription.text isEqualToString:@""])
        {
            txtDescription.text = @"Description";
            txtDescription.textColor = [UIColor lightGrayColor];
        }
        else
        {
            
        }
    }
}
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
        [txtContactNo becomeFirstResponder];
    }
    else if (textField==txtContactNo)
    {
        [txtEmail becomeFirstResponder];
    }
    else if (textField==txtEmail)
    {
        [txtAddress becomeFirstResponder];
    }
    else if (textField==txtCity)
    {
        [txtZipCode becomeFirstResponder];
    }
    else if (textField==txtZipCode)
    {
        [txtSpecialization becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    
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
