//
//  FaqCell.m
//  Snuzo App
//
//  Created by Oneclick IT on 9/3/15.
//  Copyright (c) 2015 Oneclick IT. All rights reserved.
//

#import "FaqCell.h"


@implementation FaqCell
@synthesize lblline,lbltext;
- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.backgroundColor = [UIColor clearColor];
        
        lblline=[[UILabel alloc]init] ;
        lblline.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"devider"]];
        [self.contentView addSubview:lblline];
        

//        self.backgroundColor=[UIColor whiteColor];
        
        
//        UIImageView *downimg=[[UIImageView alloc]initWithFrame:CGRectMake(320-28,17.5, 17,10)];
//        downimg.image=[UIImage imageNamed:@"Faq_donw"];
//        [self.contentView addSubview:downimg];
        
        
        lbltext=[[UILabel alloc]init];
        
        lbltext.frame=CGRectMake(0, 10, 320-30, 44);
        [self.contentView addSubview:lbltext];
        
        
        
        
        
    }
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
