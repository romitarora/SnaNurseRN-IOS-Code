//
//  MMParallaxCell.h
//  MMParallaxCell
//
//  Created by Ralph Li on 3/27/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "RateView.h"


@interface MMParallaxCell : UITableViewCell

@property (nonatomic, strong) AsyncImageView *parallaxImage;
@property (nonatomic, strong) UIImageView *upperImage;
@property (nonatomic, strong) UIImageView *starImg;
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *addressLbl;
@property (nonatomic, strong) UILabel *priceLbl;
@property (nonatomic, strong) UILabel *timeLbl;
@property(nonatomic,strong)RateView *rateVw;





@property (nonatomic, assign) CGFloat parallaxRatio; //ratio of cell height, should between [1.0f, 2.0f], default is 1.5f;

@end
