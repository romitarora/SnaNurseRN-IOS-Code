//
//  NurseDetailCell.m
//  Snuzo App
//
//  Created by one click IT consultany on 7/29/16.
//  Copyright © 2016 Oneclick IT. All rights reserved.
//

#import "NurseDetailCell.h"
#import "Constant.h"
@implementation NurseDetailCell
@synthesize titleLbl,descriptionLbl,iconImgView,linelbl,lblCheckinTime,
imgcheckinimg,
lblcheckinTimeDure,
lblcheckindateDure,
imgcheckindateimg,
lblCheckindate,
lblcheckout,
imgcheckout,
lblcheckouttime,
lblDuration,
imgduration,
lbldurationTime;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        titleLbl = [[UILabel alloc] init];
        titleLbl.text = @"";
        titleLbl.textColor = [UIColor blackColor];
        titleLbl.frame = CGRectMake(15, 05, 200, 20);
        titleLbl.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:titleLbl];
        
        descriptionLbl = [[UITextView alloc] init];
        descriptionLbl.text = @"";
        descriptionLbl.textColor = [UIColor blackColor];
        descriptionLbl.frame = CGRectMake(15, 0, 200, 30);
        descriptionLbl.backgroundColor = [UIColor clearColor];
        descriptionLbl.userInteractionEnabled = NO;
        descriptionLbl.editable = NO;
        descriptionLbl.scrollEnabled = NO;
        [self.contentView addSubview:descriptionLbl];
        
        iconImgView = [[UIImageView alloc] init];
        iconImgView.frame = CGRectMake(10, 10, 30, 40);
        iconImgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:iconImgView];
        
        linelbl = [[UILabel alloc] init];
        linelbl.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1.0f];
        linelbl.hidden = YES;
        [self.contentView addSubview:linelbl];
        
        lblCheckinTime=[[UILabel alloc]init];
        [self.contentView addSubview:lblCheckinTime];
        
        imgcheckinimg=[[UIImageView alloc]init];
        [self.contentView addSubview:imgcheckinimg];
        
        lblcheckinTimeDure=[[UILabel alloc]init];
        [self.contentView addSubview:lblcheckinTimeDure];
        
        lblcheckindateDure=[[UILabel alloc]init];
        [self.contentView addSubview:lblcheckindateDure];
        
        imgcheckindateimg=[[UIImageView alloc]init];
        [self.contentView addSubview:imgcheckindateimg];
        
        lblCheckindate=[[UILabel alloc]init];
        [self.contentView addSubview:lblCheckindate];
        
        lblcheckout=[[UILabel alloc]init];
        [self.contentView addSubview:lblcheckout];
        
        imgcheckout=[[UIImageView alloc]init];
        [self.contentView addSubview:imgcheckout];

        lblcheckouttime=[[UILabel alloc]init];
        [self.contentView addSubview:lblcheckouttime];
        
        lblDuration=[[UILabel alloc]init];
        [self.contentView addSubview:lblDuration];
        
        imgduration=[[UIImageView alloc]init];
        [self.contentView addSubview:imgduration];
        
        lbldurationTime=[[UILabel alloc]init];
        [self.contentView addSubview:lbldurationTime];
        
    }
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
