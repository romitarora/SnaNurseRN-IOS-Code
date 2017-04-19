//
//  MMParallaxCell.m
//  MMParallaxCell
//
//  Created by Ralph Li on 3/27/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import "MMParallaxCell.h"

@interface MMParallaxCell()

@property (nonatomic, strong) UITableView *parentTableView;

@end

@implementation MMParallaxCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void) setup
{
    // Initialization code
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.parallaxImage = [AsyncImageView new];
    [self.contentView addSubview:self.parallaxImage];
    [self.contentView sendSubviewToBack:self.parallaxImage];
    self.parallaxImage.backgroundColor = [UIColor clearColor];
    self.parallaxImage.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
    
    self.parallaxRatio = 1.5f;
    
    self.upperImage=[UIImageView new];
    self.upperImage.image=[UIImage imageNamed:@""];
    self.upperImage.backgroundColor=[UIColor blackColor];
    self.upperImage.alpha=0.3;
    [self.contentView addSubview:self.upperImage];
    self.parallaxImage.contentMode = UIViewContentModeScaleAspectFill;
    
    self.nameLbl=[UILabel new];
    self.nameLbl.frame=CGRectMake(10, 100, 205, 20);
    self.nameLbl.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    self.nameLbl.textColor=[UIColor whiteColor];
    [self.contentView addSubview:self.nameLbl];
    self.nameLbl.text=@"Richmond Hotel Narita";
    
    UIImageView * pinImg =[UIImageView new];
    pinImg.image=[UIImage imageNamed:@"pinAdd"];
    pinImg.frame=CGRectMake(10, 125, 9.5, 12.5);
    [self.contentView addSubview:pinImg];
    
    pinImg.image = [pinImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    pinImg.tintColor=[UIColor whiteColor];
    
    self.addressLbl=[UILabel new];
    self.addressLbl.frame=CGRectMake(25, 125-2, 165, 16);
    self.addressLbl.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    self.addressLbl.textColor=[UIColor whiteColor];
    [self.contentView addSubview:self.addressLbl];
    self.addressLbl.text=@"Whitehall Place, London, Engaland, 380005";
    
    self.priceLbl=[UILabel new];
    self.priceLbl.frame=CGRectMake(200, 100, 60, 16);
    self.priceLbl.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    self.priceLbl.textColor=[UIColor whiteColor];
    self.priceLbl.textAlignment=NSTextAlignmentRight;
    
    
    [self.contentView addSubview:self.priceLbl];
    self.priceLbl.text=@"$50";
    self.timeLbl=[UILabel new];
    self.timeLbl.frame=CGRectMake(272, 100, 55, 16);
    self.timeLbl.textAlignment=NSTextAlignmentLeft;
    self.timeLbl.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    self.timeLbl.textColor=[UIColor whiteColor];
    [self.contentView addSubview:self.timeLbl];
    self.timeLbl.text=@"2 HRS";
    
    int i=0;
    self.starImg = [UIImageView new];
    i=230;
    self.starImg.frame = CGRectMake(i,120,85,14);
    self.starImg.image=[UIImage imageNamed:@"4star"];
//    [self.contentView addSubview:self.starImg];
    
    
    self.rateVw = [RateView rateViewWithRating:0.0];
    self.rateVw.hidden=YES;
    [self.contentView addSubview:self.rateVw];

    
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    
    [self safeRemoveObserver];
    
    UIView *v = newSuperview;
    while ( v )
    {
        if ( [v isKindOfClass:[UITableView class]] )
        {
            self.parentTableView = (UITableView*)v;
            break;
        }
        v = v.superview;
    }
    [self safeAddObserver];
}
- (void)removeFromSuperview
{
    [super removeFromSuperview];
    [self safeRemoveObserver];
}
- (void)safeAddObserver
{
    if ( self.parentTableView )
    {
        @try
        {
            [self.parentTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        }
        @catch(NSException *exception)
        {
            
        }
    }
}

- (void)safeRemoveObserver
{
    if ( self.parentTableView )
    {
        @try
        {
            [self.parentTableView removeObserver:self forKeyPath:@"contentOffset" context:nil];
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            self.parentTableView = nil;
        }
    }
}

- (void)dealloc
{
    [self safeRemoveObserver];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.parallaxRatio = self.parallaxRatio;
    return;
}

- (void)setParallaxRatio:(CGFloat)parallaxRatio
{
    _parallaxRatio = MAX(parallaxRatio, 1.0f);
    _parallaxRatio = MIN(parallaxRatio, 2.0f);
    
    CGRect rect = self.bounds;
    rect.size.height = rect.size.height*parallaxRatio;
    self.parallaxImage.frame = rect;
    self.upperImage.frame=rect;
    
    [self updateParallaxOffset];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ( [keyPath isEqualToString:@"contentOffset"] )
    {
        if ( ![self.parentTableView.visibleCells containsObject:self] || (self.parallaxRatio==1.0f) )
        {
            return;
        }
        [self updateParallaxOffset];
    }
}

- (void)updateParallaxOffset
{
    CGFloat contentOffset = self.parentTableView.contentOffset.y;
    
    CGFloat cellOffset = self.frame.origin.y - contentOffset;
    
    CGFloat percent = (cellOffset+self.frame.size.height)/(self.parentTableView.frame.size.height+self.frame.size.height);
    
    CGFloat extraHeight = self.frame.size.height*(self.parallaxRatio-1.0f);
    
    CGRect rect = self.parallaxImage.frame;
    rect.origin.y = -extraHeight*percent;
    self.parallaxImage.frame = rect;
    self.upperImage.frame=rect;
}

@end
