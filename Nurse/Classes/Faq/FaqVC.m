//
//  FaqVC.m
//  Snuzo App
//
//  Created by Oneclick IT on 8/29/15.
//  Copyright (c) 2015 Oneclick IT. All rights reserved.
//

#import "FaqVC.h"

@interface FaqVC ()

@end

@implementation FaqVC
-(void)viewWillAppear:(BOOL)animated
{
    count=0;
    [self.expandedCells removeAllObjects];
    serviceCount = 0;
    [self GetFaq];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    serviceCount = 0;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title = @"FAQ";
    self.navigationController.navigationBar.backgroundColor=[UIColor grayColor];
    UIImageView *bg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-113)];
   // bg.image=[UIImage imageNamed:@"bgLogin"];
    [self.view addSubview:bg];
    
    row=-1;
    
    tblfaq=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height-114)style:UITableViewStyleGrouped];
    tblfaq.backgroundColor=[UIColor clearColor];
    tblfaq.delegate=self;
    tblfaq.dataSource=self;
    tblfaq.separatorStyle=normal;
    [self.view addSubview:tblfaq];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --Tableview Delegate And Data Source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrfaq.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==row)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize totalLengh =[self sizeOfMultiLineLabelWithText:[[[arrfaq objectAtIndex:indexPath.section]valueForKey:@"faqs"]valueForKey:@"answer"] andGivenWidth:277  withFontSize:14];
    if (totalLengh.height<45)
    {
        return 70;
    }
    else
    {
        return totalLengh.height;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerview;
    [headerview removeFromSuperview];
    headerview =nil;
    CGSize totalLengh =[self sizeOfMultiLineLabelWithText:[[[arrfaq objectAtIndex:section]valueForKey:@"faqs"]valueForKey:@"question"] andGivenWidth:277  withFontSize:14];
    
    if (totalLengh.height<35)
    {
        headerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
    }
    else
    {
        headerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, totalLengh.height)];
    }
    headerview.backgroundColor=[UIColor clearColor];
    UIImageView *downimg=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-28,(headerview.frame.size.height-10)/2, 17,10)];
    if (section==row)
    {
        downimg.image=[UIImage imageNamed:@"Faq_down"];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.1];
        downimg.transform = CGAffineTransformMakeRotation(M_PI);
        [UIView commitAnimations];
    }
    else
    {
        downimg.image=[UIImage imageNamed:@"Faq_down"];

    }
    [headerview addSubview:downimg];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, self.view.frame.size.width, headerview.frame.size.height);
    button.tag=section;
    [button addTarget:self action:@selector(sectionclick:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:button];
    
    UILabel *lblline=[[UILabel alloc]init] ;
    lblline.frame=CGRectMake(0, headerview.frame.size.height-1, self.view.frame.size.width, 1);
    lblline.backgroundColor=[UIColor lightGrayColor];
    
    UILabel *lbltext=[[UILabel alloc]init];
    lbltext.textColor=globelColor;
    lbltext.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:14];
    lbltext.textAlignment=NSTextAlignmentLeft;
    lbltext.frame=CGRectMake(05,05,self.view.frame.size.width-38,headerview.frame.size.height-10);
    lbltext.text=[[[arrfaq objectAtIndex:section]valueForKey:@"faqs"]valueForKey:@"question"];
    lbltext.numberOfLines=0;
    [headerview addSubview:lbltext];
    [headerview addSubview:lblline];
    return headerview;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    CGSize totalLengh =[self sizeOfMultiLineLabelWithText:[[[arrfaq objectAtIndex:section]valueForKey:@"faqs"]valueForKey:@"question"] andGivenWidth:277  withFontSize:14];
    
    if (totalLengh.height<35)
    {
        return 45;
    }
    else
    {
        return totalLengh.height;
    }
    
    //return 45;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"CellIdentifier";
    FaqCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[FaqCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.lbltext.text = @"TEST ";
    cell.lbltext.textColor=[UIColor whiteColor];
    cell.lbltext.font=[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:14];
    cell.lbltext.numberOfLines=0;
    
    cell.backgroundColor=globelColor;
    cell.selectionStyle=normal;
    
    CGSize totalLengh =[self sizeOfMultiLineLabelWithText:[[[arrfaq objectAtIndex:indexPath.section]valueForKey:@"faqs"]valueForKey:@"answer"] andGivenWidth:277  withFontSize:14];
        
    if (totalLengh.height<45)
    {
        cell.lbltext.frame=CGRectMake(10,0,self.view.frame.size.width-20, 70);
    }
    else
    {
        cell.lbltext.frame=CGRectMake(10,0,self.view.frame.size.width-20, totalLengh.height);
    }
    
    cell.textLabel.backgroundColor=[UIColor redColor];
    [cell.lblline removeFromSuperview];
    cell.lbltext.text=[[[arrfaq objectAtIndex:indexPath.section]valueForKey:@"faqs"]valueForKey:@"answer"];
    cell.lbltext.textAlignment=NSTextAlignmentLeft;
    cell.lbltext.numberOfLines=0;
    [cell.lbltext sizeThatFits:cell.frame.size];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.expandedCells containsObject:indexPath])
    {
        [self.expandedCells removeObject:indexPath];
    }
    else
    {
        [self.expandedCells addObject:indexPath];
    }
    [tableView beginUpdates];
    [tableView endUpdates];
    [tblfaq reloadData];
    
}


-(void)sectionclick:(UIButton *)sender
{
    if (row==[sender tag])
    {
        row=-1;
    }
    else
    {
        row = [sender tag];
    }
    
    
//    NSArray *indexPathArray = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
//    [tblfaq beginUpdates];
//    [tblfaq reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
//    [tblfaq endUpdates];
    
//    [tblfaq reloadData];
    
    [tblfaq reloadData];
    
}
-(void)GetFaq
{
    serviceCount = serviceCount +1;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:[NSString stringWithFormat:@"%d",count] forKey:@"start"];
     NSLog(@"%@",dict);
    URLManager *manager = [[URLManager alloc] init];
    manager.commandName = @"GetFaq";
    manager.delegate = self;//
    [manager urlCall:@"http://snapnurse.com/nurse/webservice/faq"withParameters:dict];
}

#pragma mark --> URL  MANAGER DELEGATES
-(void)onResult:(NSDictionary *)result
{
    serviceCount = 0;
     NSLog(@"The result is...%@", result);
    if([[result valueForKey:@"commandName"] isEqualToString:@"GetFaq"])
    {
        if([[[result valueForKey:@"result"]valueForKey:@"result"]isEqualToString:@"true"])
        {
            if (count==0)
            {
                [arrfaq removeAllObjects];
                arrfaq=nil;
                arrfaq=[[NSMutableArray alloc]init];
            }
            NSMutableArray*   tempFeedsArray=[[NSMutableArray alloc]init];
            tempFeedsArray=[[[result valueForKey:@"result"]valueForKey:@"data"]mutableCopy];
            [arrfaq addObjectsFromArray:tempFeedsArray ];
            if ([tempFeedsArray count] >=10)
            {
                PullTorefrehManager_FAQ =[[MNMBottomPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f tableView:tblfaq withClient:self];
                [PullTorefrehManager_FAQ tableViewReloadFinished];
                [PullTorefrehManager_FAQ setPullToRefreshViewVisible:YES];
            }
            else
            {
                [PullTorefrehManager_FAQ tableViewReloadFinished];
                [PullTorefrehManager_FAQ setPullToRefreshViewVisible:NO];
            }
            [tblfaq reloadData];
        }
        else
        {
            [PullTorefrehManager_FAQ tableViewReloadFinished];
            [PullTorefrehManager_FAQ setPullToRefreshViewVisible:NO];
            [tblfaq reloadData];
        }
    }
}
- (void)onError:(NSError *)error
{
    
    
    //    [app hudEndProcessMethod];
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
        if ([commandName isEqualToString:@"GetFaq"])
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
                [self GetFaq];
            }
        }
    }
}
#pragma mark --> Scroll View did Scroll


- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==tblfaq)
    {
        
        [PullTorefrehManager_FAQ tableViewReleased];

    }
    
}
#pragma mark MNMBottomPullToRefreshManagerClient
- (void)bottomPullToRefreshTriggered:(MNMBottomPullToRefreshManager *)manager
{
    
    [self performSelector:@selector(loadTable) withObject:nil afterDelay:0.5f];
}


#pragma mark MNMBottomPullToRefreshManagerClient


-(void)loadTable
{
     NSLog(@"Load");
    count=count+10;
    [self GetFaq];
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
