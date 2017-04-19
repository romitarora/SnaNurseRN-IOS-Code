//
//  ProfileVC.m
//  Snoozo App
//
//  Created by HARI on 7/30/15.
//  Copyright (c) 2015 oneclick. All rights reserved.
//

#import "ProfileVC.h"
#import "USColor.h"
//#import "STPPaymentCardTextField.h"
//#import "PaymentViewController.h"
//#import "Stripe.h"
#import "NurseDetailCell.h"
#import "AHTagTableViewCell.h"

@interface ProfileVC ()
{
    //STPPaymentCardTextField *paymentTextField;
    Splash_VC *spl;
}
//@property (weak, nonatomic) STPPaymentCardTextField *paymentTextField;
@property (weak, nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation ProfileVC
@synthesize isFromTabbar;

-(void)viewWillAppear:(BOOL)animated
{
    
        if(isFromTabbar)
        {
            self.tabBarController.delegate=self;
        }
        self.tabBarController.delegate=self;

    
        [super viewDidLoad];
        if (isFromTabbar)
        {
            [self.navigationItem setHidesBackButton:YES];
        }
        else
        {
            [self.navigationItem setHidesBackButton:YES];
        }
        self.view.backgroundColor=[UIColor whiteColor];
    
    rateVw = [RateView rateViewWithRating:0.0];
    rateVw.hidden=YES;
    
    rateVw.frame = CGRectMake(10,10, 120, 30);
    rateVw.starSize=15;
    rateVw.starNormalColor = [UIColor whiteColor];
    
    btnRate=[UIButton buttonWithType:UIButtonTypeCustom];
    btnRate.frame=CGRectMake(0,10,130,30);
    btnRate.backgroundColor=[UIColor clearColor];
    
    
   
}

- (void)viewDidLoad
{
     serviceCount = 0;
    [self getUserProfile];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor=[UIColor grayColor];
    self.navigationItem.title = @"Profile";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:globelColor}];
    
    
    UIButton *logout=[UIButton buttonWithType:UIButtonTypeCustom];
    logout.frame=CGRectMake(0, 0, 50,30);
    logout.backgroundColor=[UIColor clearColor];
    [logout setTitle:@"Logout" forState:UIControlStateNormal];
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [logout setTitleColor:globelColor forState:UIControlStateNormal];

    logout.titleLabel.font=[UIFont systemFontOfSize:15.0];
    
    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc]initWithCustomView:logout];
    btnLogout.tintColor=[UIColor blackColor];
    btnLogout.tintColor=globelColor;

    btnLogout.title=@"Logout";
    
    
    self.navigationItem.rightBarButtonItem = btnLogout;
    
    nurseImg=[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 210)];
    nurseImg.image = [UIImage imageNamed:@""];
    nurseImg.backgroundColor=[UIColor clearColor];
   // nurseImg.contentMode = UIViewContentModeScaleAspectFill;
    nurseImg.contentMode = UIViewContentModeScaleAspectFit;
    
    tblcontent=[[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, viewHeight-64-44)];
    tblcontent.backgroundColor=[UIColor clearColor];
    tblcontent.separatorStyle=NO;
    tblcontent.delegate=self;
    tblcontent.dataSource=self;
    tblcontent.separatorStyle=UITableViewCellSeparatorStyleNone;
    tblcontent.separatorColor=[UIColor clearColor];
    [self.view addSubview:tblcontent];
    
    [tblcontent setTableHeaderView:nurseImg];
    
    UINib *nib = [UINib nibWithNibName:@"AHTagTableViewCell" bundle:nil];
    [tblcontent registerNib:nib forCellReuseIdentifier:@"cell"];
}

#pragma mark -- GetProfileDetail
-(void)getUserProfile
{
    serviceCount = serviceCount +1;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    NSString *nurseId =[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
   
    [dict setValue:nurseId forKey:@"nurse_id"];
    
    URLManager *manager = [[URLManager alloc] init];
    manager.commandName = @"getProfileDetail";
    manager.delegate = self;
    [manager urlCall:@"http://snapnurse.com/nurse/profile_details" withParameters:dict];
    
}
#pragma mark --- Touch

#pragma mark Touch event
-(void)touch
{
     NSLog(@"text");
    
//    tblYear.hidden=YES;
    [txtfname resignFirstResponder];
    [txtlname resignFirstResponder];
    [txtphNo resignFirstResponder];
    [txtemail resignFirstResponder];
    [txtoldPass resignFirstResponder];
    [txtnewPass resignFirstResponder];
    [txtnewPass resignFirstResponder];
    [txtcardNo resignFirstResponder];
    [txtnameoncard resignFirstResponder];
    [txtconfPass resignFirstResponder];

}

#pragma mark --- LogoutClick

-(void)logout
{
    URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"sign up" message:@"Are you sure you want to logout" cancelButtonTitle:@"ok" otherButtonTitles:@"cancel", nil];
    [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
    alert.tag=0;
    [alert setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView)
     {
         [alertView hideWithCompletionBlock:^{
             
             if(buttonIndex==0)
             {
                 
                 serviceCount = serviceCount+1;
                 NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
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
                 manager.commandName = @"Logout";
                 manager.delegate = self;
                 [manager urlCall:@"http://snapnurse.com/nurse/logout" withParameters:dict];
             }
             else
             {
                 
             }
         }];
     }];
     [alert showWithAnimation:URBalertAnimationType];;
}



#pragma mark - UITableview Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row==0 || indexPath.row == 2 || indexPath.row == 7|| indexPath.row == 9)
    {
        return 30;
    }
    else if (indexPath.row == 1)
    {
        id description = [detailArr valueForKey:@"description"] ;
        NSString *descriptionStr = @"";
        if (description != [NSNull null])
        {
            descriptionStr = (NSString *)description;
            
        }
        else
        {
            descriptionStr = @"NA";
        }
        CGSize totalLengh =[self sizeOfMultiLineLabelWithText:descriptionStr andGivenWidth:300  withFontSize:12];;
        if (totalLengh.height <80)
        {
            return totalLengh.height+20;
        }
        else
        {
            return totalLengh.height+10;
        }
        
       // return UITableViewAutomaticDimension;
    }
    else if (indexPath.row ==8)
    {
        id hospital = strHospital ;
        NSString *hospitalStr = @"";
        if (hospital != [NSNull null])
        {
            hospitalStr = (NSString *)hospital;
            
        }
        else
        {
            hospitalStr = @"NA";
        }
        CGSize totalLengh =[self sizeOfMultiLineLabelWithText:hospitalStr andGivenWidth:300  withFontSize:12];;
        if (totalLengh.height <80)
        {
            return totalLengh.height+20;
        }
        else
        {
            return totalLengh.height+20;
        }

    }
    else if(indexPath.row ==10)
    {
        return UITableViewAutomaticDimension;
    }
    else
    {
        return 35;
    }
    
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 9 )
    {
        return 50;
    }
    
    return 35;
}

//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
//    v.textLabel.textColor = [UIColor clearColor];
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NurseDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[NurseDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        
    }
    
    
    if (indexPath.row == 0)
    {
        cell.titleLbl.text = @"Description";
        cell.titleLbl.hidden = NO;
        cell.iconImgView.hidden = YES;
        cell.linelbl.hidden = YES;
    }
    else if (indexPath.row == 1)
    {
        cell.titleLbl.hidden = YES;
        cell.iconImgView.hidden = YES;
        cell.linelbl.hidden = YES;
        cell.descriptionLbl.backgroundColor = [UIColor clearColor];
        id description = [detailArr valueForKey:@"description"] ;
        NSString *descriptionStr = @"";
        if (description != [NSNull null])
        {
            descriptionStr = (NSString *)description;
            
        }
        else
        {
            descriptionStr = @"NA";
        }
        cell.descriptionLbl.text = descriptionStr;
        
        CGSize totalLengh =[self sizeOfMultiLineLabelWithText:cell.descriptionLbl.text andGivenWidth:cell.frame.size.width-20  withFontSize:12];
        
        if (totalLengh.height <80)
        {
            cell.descriptionLbl.frame = CGRectMake(15, 0, cell.frame.size.width-15, totalLengh.height+20);
        }
        else
        {
            cell.descriptionLbl.frame = CGRectMake(15, 0, cell.frame.size.width-15, totalLengh.height+10);
        }
    }
    else if (indexPath.row == 2)
    {
        cell.titleLbl.text = @"Contact Detail";
        cell.titleLbl.hidden = NO;
        cell.iconImgView.hidden = YES;
        cell.linelbl.hidden = YES;
        
    }
    else if (indexPath.row == 3)
    {
        id name = [detailArr valueForKey:@"hotel_name"] ;
        NSString *nameStr = @"";
        if (name != [NSNull null])
        {
            nameStr = (NSString *)name;
           
        }
        else
        {
            nameStr = @"NA";
        }
        
        cell.descriptionLbl.text = nameStr;
        cell.titleLbl.hidden = YES;
        cell.iconImgView.hidden = NO;
        cell.linelbl.hidden = NO;
        cell.linelbl.frame = CGRectMake(40, 34, tableView.frame.size.width-40, 1);
        cell.iconImgView.frame = CGRectMake(10, 7.5, 20, 20);
        cell.iconImgView.image = [UIImage imageNamed:@"f-l-name"];
        cell.descriptionLbl.frame = CGRectMake(40, 0, tableView.frame.size.width-40,35);
    }
    else if (indexPath.row == 4)
    {
        id email = [detailArr valueForKey:@"hotel_email"] ;
        NSString *emailStr = @"";
        if (email != [NSNull null])
        {
            emailStr = (NSString *)email;
            
        }
        else
        {
            emailStr = @"NA";
        }

        
        cell.descriptionLbl.text = emailStr;
        cell.titleLbl.hidden = YES;
        cell.iconImgView.hidden = NO;
        cell.linelbl.hidden = NO;
         cell.linelbl.frame = CGRectMake(40, 34, tableView.frame.size.width-40, 1);
        cell.iconImgView.frame = CGRectMake(10, 10.5, 20, 14);
        cell.iconImgView.image = [UIImage imageNamed:@"email.png"];
        cell.descriptionLbl.frame = CGRectMake(40, 0, tableView.frame.size.width-40,35);
    }
    else if (indexPath.row == 5)
    {
        id mobile = [detailArr valueForKey:@"telephone"] ;
        NSString *mobileStr = @"";
        if (mobile != [NSNull null])
        {
            mobileStr = (NSString *)mobile;
            
        }
        else
        {
            mobileStr = @"NA";
        }
        cell.descriptionLbl.text = mobileStr;
        cell.titleLbl.hidden = YES;
        cell.iconImgView.hidden = NO;
        cell.linelbl.hidden = NO;
         cell.linelbl.frame = CGRectMake(40, 34, tableView.frame.size.width-40, 1);
        cell.iconImgView.frame = CGRectMake(15, 7, 10, 21);
        cell.iconImgView.image = [UIImage imageNamed:@"phone.png"];
        cell.descriptionLbl.frame = CGRectMake(40, 0, tableView.frame.size.width-40,35);
    }
    else if (indexPath.row == 6)
    {
        id address = [detailArr valueForKey:@"address"] ;
        NSString *addressStr = @"";
        if (address != [NSNull null])
        {
            addressStr = (NSString *)address;
            
        }
        else
        {
            addressStr = @"NA";
        }
        cell.descriptionLbl.text = addressStr;
        cell.titleLbl.hidden = YES;
        cell.iconImgView.hidden = NO;
        cell.linelbl.hidden = NO;
        cell.linelbl.frame = CGRectMake(40, 34, tableView.frame.size.width-40, 1);
        cell.iconImgView.frame = CGRectMake(14, 7.5, 14, 20);
        cell.iconImgView.image = [UIImage imageNamed:@"destination.png"];
        cell.descriptionLbl.frame = CGRectMake(40, 0, tableView.frame.size.width-40,35);
    }
    else if (indexPath.row == 7)
    {
        cell.titleLbl.text = @"Hospitals";
        cell.titleLbl.hidden = NO;
        cell.iconImgView.hidden = YES;
        cell.linelbl.hidden = YES;
    }
    else if (indexPath.row == 8)
    {
        cell.titleLbl.hidden = YES;
        cell.iconImgView.hidden = YES;
        cell.linelbl.hidden = YES;
        cell.descriptionLbl.backgroundColor = [UIColor clearColor];
        id description = strHospital ;
        NSString *descriptionStr = @"";
        if (description != [NSNull null])
        {
            descriptionStr = (NSString *)description;
        }
        else
        {
            descriptionStr = @"NA";
        }
        cell.descriptionLbl.text = descriptionStr;
        
        CGSize totalLengh =[self sizeOfMultiLineLabelWithText:cell.descriptionLbl.text andGivenWidth:cell.frame.size.width-20  withFontSize:12];
        
        if (totalLengh.height <80)
        {
            cell.descriptionLbl.frame = CGRectMake(15, 0, cell.frame.size.width-15, totalLengh.height+20);
        }
        else
        {
            cell.descriptionLbl.frame = CGRectMake(15, 0, cell.frame.size.width-15, totalLengh.height+20);
        }
    }
    else if (indexPath.row == 9)
    {
        cell.titleLbl.text = @"Specialization";
        cell.titleLbl.hidden = NO;
        cell.iconImgView.hidden = YES;
        cell.linelbl.hidden = YES;
    }
    else if (indexPath.row == 10)
    {
        cell.titleLbl.hidden = YES;
        cell.iconImgView.hidden = YES;
        cell.linelbl.hidden = YES;
        
        
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell1.selectionStyle= UITableViewCellSelectionStyleNone;
        [self configureCell:cell1 atIndexPath:indexPath];
        return cell1;
    }
    
    return cell;
}
- (void)configureCell:(id)object atIndexPath:(NSIndexPath *)indexPath {
    //    if (![object isKindOfClass:[AHTagTableViewCell class]])
    //    {
    //        return;
    //    }
    AHTagTableViewCell *cell = (AHTagTableViewCell *)object;
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    cell.label.tags = [detailArr valueForKey:@"specilaization"];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0 || indexPath.row == 2 || indexPath.row == 7|| indexPath.row == 9)
    {
        cell.backgroundColor=[UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1.0f];
    }
    else
    {
        cell.backgroundColor=[UIColor whiteColor];
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
#pragma mark ----count Line

-(CGSize)sizeOfMultiLineLabelWithText:(NSString*)givenString andGivenWidth:(CGFloat)givenWidth withFontSize:(int)givenFontSize
{
    NSAssert(self, @"UILabel was nil");
    
    //Label text
    NSString *aLabelTextString = givenString;
    
    //Label font
    UIFont *aLabelFont = [UIFont systemFontOfSize:givenFontSize];
    
    //Width of the Label
    CGFloat aLabelSizeWidth = givenWidth;
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        //Return the calculated size of the Label
        return [aLabelTextString boundingRectWithSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : aLabelFont } context:nil].size;
    }
    else
    {
        //version < 7.0
        return [aLabelTextString sizeWithFont:aLabelFont constrainedToSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    }
}
#pragma mark - Scrollview delegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    /*CGFloat yOffset   = scrollView.contentOffset.y-2;
    
    if (yOffset < 0)
    {
        nurseImg.center = CGPointMake(nurseImg.frame.size.width, nurseImg.frame.size.height);
        CGFloat absoluteY = ABS(scrollView.contentOffset.y);
        
        
        if (IS_IPHONE_6)
        {
            [nurseImg setFrame:CGRectMake(-absoluteY, 0, absoluteY+self.view.frame.size.width+absoluteY, absoluteY+250)];
        }
        else if (IS_IPHONE_6plus)
        {
            [nurseImg setFrame:CGRectMake(-absoluteY, 0, absoluteY+self.view.frame.size.width+absoluteY, absoluteY+250)];
        }
        else if (IS_IPHONE_4)
        {
            [nurseImg setFrame:CGRectMake(-absoluteY, 0, absoluteY+self.view.frame.size.width+absoluteY, absoluteY+180)];
        }
        else
        {
            [nurseImg setFrame:CGRectMake(-absoluteY, 0, absoluteY+self.view.frame.size.width+absoluteY, absoluteY+210)];
        }
        
    }
    else
    {
        if (IS_IPHONE_6)
        {
            nurseImg.frame=CGRectMake(0, 0, nurseImg.frame.size.width,250);
        }
        else if (IS_IPHONE_6plus)
        {
            nurseImg.frame=CGRectMake(0, 0, nurseImg.frame.size.width,250);
        }
        else if (IS_IPHONE_4)
        {
            nurseImg.frame=CGRectMake(0, 0, nurseImg.frame.size.width,180);
        }

        else
        {
            nurseImg.frame=CGRectMake(0, 0, nurseImg.frame.size.width,210);
        }
        
        //      topImg.frame=CGRectMake(0, 0, imghotel.frame.size.width,210);
    }
    
    bottomView.frame = CGRectMake(0,nurseImg.frame.size.height-40,self.view.frame.size.width,40);*/
    
}

#pragma mark Url menager Delegates

- (void)onResult:(NSDictionary *)result
{
    serviceCount = 0;
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
     NSLog(@"The result is...%@", result);
    
     if([[result valueForKey:@"commandName"] isEqualToString:@"Logout"])
    {
        [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"isLogin"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSUserDefaults standardUserDefaults] setValue:@"null" forKey:@"loginvia"];
        [[NSUserDefaults standardUserDefaults] setValue:@"null" forKey:@"data"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"card.last4"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"STRIP_CUSTOMER_ID"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"cardInfo"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [NSUserDefaults resetStandardUserDefaults];
        
        AppDelegate * ap=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        /* spl=[[Splash_VC alloc]init];
         nav=[[UINavigationController alloc] initWithRootViewController:spl];
         ap.window.rootViewController=nav;
         
         if (IS_OS_8_OR_LATER)
         {
         spl=[[Splash_VC alloc]init];
         nav=[[UINavigationController alloc] initWithRootViewController:spl];
         [ap.window addSubview:nav.view];
         [ap.window makeKeyAndVisible];
         }
         else
         {
         spl=[[Splash_VC alloc]init];
         nav=[[UINavigationController alloc] initWithRootViewController:spl];
         ap.window.rootViewController=nav;
         [ap.window makeKeyAndVisible];
         }*/
        
        [ap setUpTabBarController];
        
    }
    else if ([[result valueForKey:@"commandName"] isEqualToString:@"getProfileDetail"])
    {
        if ([[[result valueForKey:@"result"] valueForKey:@"result"] isEqualToString:@"true"])
        {
            detailArr = [[NSMutableArray alloc] init];
            detailArr = [[[result valueForKey:@"result"] valueForKey:@"result_data"] valueForKey:@"nurse"];
            
            NSMutableArray * tempArr=[NSMutableArray new];
            for (int i = 0; i<[[detailArr valueForKey:@"hospitals"] count]; i++)
            {
                [tempArr addObject:[[[[detailArr valueForKey:@"hospitals"] objectAtIndex:i] valueForKey:@"hospitals"] valueForKey:@"first_name"]];
            }
            strHospital = [tempArr componentsJoinedByString:@"\n"];
            
            id img = [[[detailArr valueForKey:@"photos"] objectAtIndex:0] valueForKey:@"main"];
            NSString *imgstr = @"";
            if (img != [NSNull null])
            {
                imgstr = (NSString *)img;
                NSURL *url = [NSURL URLWithString:imgstr];
                nurseImg.imageURL=url;
                [tblcontent reloadData];
                [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
            }
            else
            {
                
            }
            
           
            
            
            
            
        }
        else
        {
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
        }
    }
}

- (void)onError:(NSError *)error
{
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
    
    //    [app hudEndProcessMethod];
     NSLog(@"The error is...%@", error);
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
//        [alert showWithAnimation:URBalertAnimationType];;
    }
    
    
}
- (void)onNetworkError:(NSError *)error didFailWithCommandName:(NSString *)commandName
{
    NSLog(@"OnNetworkErrorCall");
    if (error.code == -1005)
    {
        if ([commandName isEqualToString:@"getProfileDetail"])
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
                [self getUserProfile];
            }
        }
        else if ([commandName isEqualToString:@"Logout"])
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
                serviceCount = serviceCount+1;
                NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
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
                manager.commandName = @"Logout";
                manager.delegate = self;
                [manager urlCall:@"http://snapnurse.com/nurse/logout" withParameters:dict];
            }
        }
    }

}

- (void)save:(id)sender
{
    
    
  //  [paymentTextField resignFirstResponder];
    
//    if (self.paymentTextField.cardNumber==nil || [self.paymentTextField.cardNumber length]<=15 || [self.paymentTextField.cardNumber isEqual:[NSNull null]] || self.paymentTextField.isValid==NO)
//    {
//        paymentsavebtn.enabled=YES;
//        
//        URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Warning" message:@"Please enter valid card details." cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
//        
//         [alert showWithAnimation:URBalertAnimationType];;
//        
//    }
//else
//{
//    if (![self.paymentTextField isValid]) {
//        return;
//    }
//    
//    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudForprocessMethod];
//    
//    STPCard *card = [[STPCard alloc] init];
//    card.number = self.paymentTextField.cardNumber;
//    card.expMonth = self.paymentTextField.expirationMonth;
//    card.expYear = self.paymentTextField.expirationYear;
//    card.cvc = self.paymentTextField.cvc;
//    
//    
//    
//  
//    
//    
//    
//    [[STPAPIClient sharedClient] createTokenWithCard:card
//                                          completion:^(STPToken *token, NSError *error) {
//                                              [(AppDelegate *)[[UIApplication sharedApplication] delegate] hudEndProcessMethod];
//                                              if (error) {
//                                                  NSDictionary *dict=[[NSDictionary alloc]init];
//                                                  dict=error.userInfo;
//
//                                                  
//                                                  URBAlertView * alert =[[URBAlertView alloc] initWithTitle:@"Error" message:[dict valueForKey:@"NSLocalizedDescription"] cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//                                                  [alert setMessageFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
//                                                  [alert showWithAnimation:URBalertAnimationType];;
////                                                  [self.delegate paymentViewController:self didFinish:error];
//                                              }
//                                              else
//                                              {
//                                                  NSLog(@"My Token==%@",token.tokenId);
//                                                  
//                                                  [[NSUserDefaults standardUserDefaults] setValue:card.last4 forKey:@"card.last4"];
//                                                  [[NSUserDefaults standardUserDefaults]synchronize];
//                                                  NSMutableDictionary *dictcard=[[NSMutableDictionary alloc]init];
//                                                  NSString *strcardexpmont=[NSString stringWithFormat:@"%u",[[token card] expMonth]];
//                                                  NSString *strcardexpYear=[NSString stringWithFormat:@"%u",[[token card] expYear]];
//                                                  strcardbard=[NSString stringWithFormat:@"%ld",(long)[[token card]brand]];
//                                                  NSString *strcontry=[NSString stringWithFormat:@"%@",[[token card]country]];
//                                                  
//                                                  
//                                                  [dictcard setValue:card.last4 forKey:@"card.last4"];
//                                                  [dictcard setValue:strcardexpmont forKey:@"ExpirMonth"];
//                                                  [dictcard setValue:strcardexpYear forKey:@"ExpireYear"];
//                                                  [dictcard setValue:strcardbard forKey:@"cardBrand"];
//                                                  [dictcard setValue:strcontry forKey:@"CardContry"];
//                                                  
//                                                  
//                                                  [[NSUserDefaults standardUserDefaults]setValue:dictcard forKey:@"cardInfo"];
//                                                  [[NSUserDefaults standardUserDefaults]synchronize];
//                                                  
//                                                  
//                                                  iscustomer=YES;
//                                                  
//                                                  
//                                                  NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
//                                                  //                                              [dict setObject:@"YES" forKey:@"iscustomer"];
//                                                  [dict setObject:@"Customer for test@mail.com" forKey:@"description"];
//                                                  [dict setObject:token.tokenId forKey:@"source"];
//                                                  
//                                                  
//                                                  URLManager *manager = [[URLManager alloc] init];
//                                                  manager.commandName = @"CreateCustomer";
//                                                  manager.delegate = self;
//                                                  [manager urlCall:@"https://api.stripe.com/v1/customers" withParameters:dict];
//                                                  ;
//                                              }
//                                          }];
//    
//
//}
    
}

-(void)closeClick
{
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         cardview.frame = CGRectMake(0,viewHeight,paymentview.frame.size.width, paymentview.frame.size.height);
                         
                     }
                     completion:^(BOOL finished){
                     }];
    // [paymentTextField resignFirstResponder];
    personalinfo.enabled=YES;
    paymentcardinfo.enabled=YES;
    scrlcontent.scrollEnabled=YES;
    tblYear.hidden=NO;
    cardview.hidden=YES;

}
-(void)doneClicked:(id)sender
{
     NSLog(@"Done Clicked.");
    [paymentview endEditing:YES];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([tabBarController.viewControllers indexOfObject:viewController] == tabBarController.selectedIndex)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
