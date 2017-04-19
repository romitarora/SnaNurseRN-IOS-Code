//
//  OCCalendarViewController.m
//  OCCalendar
//
//  Created by Oliver Rickard on 3/31/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "OCCalendarViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "Constant.h"
@interface OCCalendarViewController ()

@end

@implementation OCCalendarViewController
@synthesize delegate, startDate, endDate, selectionMode;

- (id)initAtPoint:(CGPoint)point inView:(UIView *)v arrowPosition:(OCArrowPosition)ap selectionMode:(OCSelectionMode)sm {
    self = [super initWithNibName:nil bundle:nil];
    if(self) {
        insertPoint = point;
        parentView = v;
        arrowPos = OCArrowPositionNone;
        selectionMode = sm;
    }
    return self;
}

- (id)initAtPoint:(CGPoint)point inView:(UIView *)v arrowPosition:(OCArrowPosition)ap {
    return [self initAtPoint:point inView:v arrowPosition:ap selectionMode:OCSelectionDateRange];
}

- (id)initAtPoint:(CGPoint)point inView:(UIView *)v {
    return [self initAtPoint:point inView:v arrowPosition:OCArrowPositionNone];
}
- (void)loadView
{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"DateDone" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeCalView)
                                                 name:@"DateDone"
                                               object:nil];
    [super loadView];
    self.view.frame = CGRectMake(-6, 0, self.view.frame.size.width, parentView.frame.size.height);
    
    
    titleForDatePicker=[[UILabel alloc]initWithFrame:CGRectMake(5,185, self.view.frame.size.width+5, 40)];
    titleForDatePicker.text=@"Select date";
    titleForDatePicker.backgroundColor=globelColor;
    UITapGestureRecognizer *tapG1 =[[UITapGestureRecognizer alloc] init];
    tapG1.delegate = self;
    [titleForDatePicker setUserInteractionEnabled:YES];

    [titleForDatePicker addGestureRecognizer:[tapG1 autorelease]];
    titleForDatePicker.textColor =[UIColor whiteColor];
    titleForDatePicker.textAlignment=NSTextAlignmentCenter;
    titleForDatePicker.font=[UIFont boldSystemFontOfSize:16.];
//    titleForDatePicker.userInteractionEnabled=true;
    

    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, viewHeight)];
    bgView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapG =[[UITapGestureRecognizer alloc] init];
    tapG.delegate = self;
    [bgView addGestureRecognizer:[tapG autorelease]];
    [bgView setUserInteractionEnabled:YES];
    [self.view addSubview:[bgView autorelease]];
    
    whiteview=[[UIView alloc]initWithFrame:CGRectMake(05, 190, self.view.frame.size.width+10, viewHeight)];
    if (IS_IPHONE_4)
    {
        whiteview.frame=CGRectMake(05, 80, self.view.frame.size.width, viewHeight);
        titleForDatePicker.frame=CGRectMake(5,80, self.view.frame.size.width+5, 40);
    }
    else if (IS_IPHONE_6)
    {
        whiteview.frame=CGRectMake(05, 250, self.view.frame.size.width, viewHeight-240);
        titleForDatePicker.frame=CGRectMake(5,250, self.view.frame.size.width+5, 40);
    }
    else if (IS_IPHONE_6plus)
    {
        whiteview.frame=CGRectMake(05, 280, self.view.frame.size.width, viewHeight-240);
        titleForDatePicker.frame=CGRectMake(5,280, self.view.frame.size.width+5, 40);
    }
    whiteview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:whiteview];
    
    
    UITapGestureRecognizer *tapG2 =[[UITapGestureRecognizer alloc] init];
    tapG2.delegate = self;
    
    btndone=[UIButton buttonWithType:UIButtonTypeCustom];
    btndone.frame=CGRectMake(self.view.frame.size.width-40,185, 45,45);
    [btndone addGestureRecognizer:tapG2];
    btndone.backgroundColor=[UIColor clearColor];
    
    [btndone setImage:[UIImage imageNamed:@"done"] forState:UIControlStateNormal];
    btndone.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    //    [closeButton setImage:clsImg forState:UIControlStateNormal];

    //    [closeButton setImage:clsImg forState:UIControlStateNormal];
    
    int width = 390;
    int height = 300;
    
    calView = [[OCCalendarView alloc] initAtPoint:insertPoint withFrame:CGRectMake((self.view.frame.size.width/2)-(width/2),175, width, height) arrowPosition:OCArrowPositionNone];
    
    if (IS_IPHONE_4)
    {
        calView.frame=CGRectMake((self.view.frame.size.width/2)-(width/2),125, width, height);
        
    }
    else if (IS_IPHONE_6)
    {
        calView.frame=CGRectMake((self.view.frame.size.width/2)-(width/2),280, width, height);
    }
    else if (IS_IPHONE_6plus)
    {
        calView.frame=CGRectMake((self.view.frame.size.width/2)-(width/2),280, width, height);
    }
    
    //arrowPosition:OCArrowPositionCentered
    [calView setSelectionMode:selectionMode];
    if(self.startDate) {
        [calView setStartDate:startDate];
    }
    if(self.endDate) {
        [calView setEndDate:endDate];
    }
    [self.view addSubview:[calView autorelease]];
    [self.view addSubview:titleForDatePicker];

    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"RemoveCalendor" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeCalView)
                                                 name:@"RemoveCalendor"
                                               object:nil];
//    [self.view addSubview:btndone];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)setStartDate:(NSDate *)sDate {
    if(startDate) {
        [startDate release];
        startDate = nil;
    }
    startDate = [sDate retain];
    [calView setStartDate:startDate];
}

- (void)setEndDate:(NSDate *)eDate {
    if(endDate) {
//        [endDate release];
        endDate = nil;
    }
    endDate = [eDate retain];
    [calView setEndDate:endDate];
}


- (void)removeCalView {
    startDate = [[calView getStartDate] retain];
    endDate = [[calView getEndDate] retain];
    
     NSLog(@"startDate:%@ endDate:%@", startDate.description, endDate.description);
    
     NSLog(@"CalView Selected:%d", [calView selected]);
    
    if([calView selected])
    {
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setTimeZone:[NSTimeZone systemTimeZone]];
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *currentTime = [dateFormatter1 stringFromDate:[NSDate date]];

         NSLog(@"Original time=====%@",currentTime);
        
        NSDate *mydate = [dateFormatter1 dateFromString:currentTime];
        NSTimeInterval secondsInEightHours = 1 * 60 * 60;
        NSDate *dateEightHoursAhead = [mydate dateByAddingTimeInterval:secondsInEightHours];
        currentTime = [dateFormatter1 stringFromDate:dateEightHoursAhead];
         NSLog(@"update time=====%@",currentTime);
        
        
        
        
        NSDate * finalDate =[dateFormatter1 dateFromString:currentTime];
         NSLog(@"finalDate==%@",finalDate);
        

        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        [formatter setTimeZone:[NSTimeZone systemTimeZone]];
        endDate=finalDate;
        NSString *strStartdate = [formatter stringFromDate:startDate];
        NSString *strEnddate=[formatter stringFromDate:endDate];
        if([startDate compare:endDate] == NSOrderedAscending)
        {
            if ([strStartdate isEqualToString:strEnddate])
            {
                [self.delegate completedWithStartDate:startDate endDate:startDate];
                [calView removeFromSuperview];
                calView = nil;
            }
            else
            {
                
            }
        }
        else 
        {
            [self.delegate completedWithStartDate:startDate endDate:startDate];
            [calView removeFromSuperview];
            calView = nil;
        }
    }
    else
    {
        [self.delegate completedWithNoSelection];
        [calView removeFromSuperview];
        calView = nil;
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if(calView)
    {
            [self performSelector:@selector(removeCalView) withObject:nil afterDelay:0.1f];
    }
    else
    {
        //Recreate the calendar if it doesn't exist.
        
        //CGPoint insertPoint = CGPointMake(200+130*0.5, 200+10);
        CGPoint point = [touch locationInView:self.view];
        int width = 390;
        int height = 300;
        
        calView = [[OCCalendarView alloc] initAtPoint:point withFrame:CGRectMake(point.x - width*0.5, point.y - 31.4, width, height)];
        [self.view addSubview:[calView autorelease]];
    }
    
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)dealloc {
    self.startDate = nil;
    self.endDate = nil;
    [super dealloc];
}



#pragma mark - Date Conversion
-(NSString *)getRealTimeFromUTCTimeDate:(NSDate *)utcDate
{
    NSTimeZone * destinationTimeZone = [NSTimeZone systemTimeZone];
    float timeZoneOffset = [destinationTimeZone secondsFromGMTForDate:utcDate];
    
    NSDate *finalDate = [utcDate dateByAddingTimeInterval:timeZoneOffset];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * strRealTime = [df stringFromDate:finalDate];
    
    return strRealTime;
}

@end
