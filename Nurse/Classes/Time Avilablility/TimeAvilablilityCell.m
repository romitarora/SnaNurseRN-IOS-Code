//
//  TimeAvilablilityCell.m
//  Nurse
//
//  Created by one click IT consultany on 9/14/16.
//  Copyright © 2016 com.Oneclick.apps. All rights reserved.
//

#import "TimeAvilablilityCell.h"

@implementation TimeAvilablilityCell
@synthesize titleLbl,dayOnOffSwitch,seperaterLine,availableStatusLbl,
detailLbl,lblHrs,deleteDateBtn,deleteImg;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        titleLbl = [[UILabel alloc] init];
        titleLbl.frame = CGRectMake(15, 10, 100, 30);
        titleLbl.textColor = [UIColor blackColor];
        titleLbl.textAlignment = NSTextAlignmentLeft;
        titleLbl.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:titleLbl];
        
        lblHrs=[[UILabel alloc]init];
        lblHrs.text=@"HRS";
        lblHrs.textColor=[UIColor darkGrayColor];
        lblHrs.font =[UIFont systemFontOfSize:12];
        //lblHrs.layer.cornerRadius=20;
        lblHrs.backgroundColor=[UIColor clearColor];
       // lblHrs.clipsToBounds=YES;
        lblHrs.textAlignment=NSTextAlignmentCenter;
        lblHrs.numberOfLines=0;
        [self.contentView addSubview:lblHrs];
        
        availableStatusLbl = [[UILabel alloc] init];
        availableStatusLbl.textColor = [UIColor blackColor];
        availableStatusLbl.textAlignment = NSTextAlignmentLeft;
        availableStatusLbl.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:availableStatusLbl];
        
        detailLbl = [[UILabel alloc] init];
        detailLbl.textColor = [UIColor darkGrayColor];
        detailLbl.textAlignment = NSTextAlignmentLeft;
        detailLbl.font =[UIFont boldSystemFontOfSize:12];
        detailLbl.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:detailLbl];
        
        dayOnOffSwitch = [[UISwitch alloc] init];
        [dayOnOffSwitch setOnTintColor:globelColor];
        [self.contentView addSubview:dayOnOffSwitch];
        
        deleteDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteDateBtn.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:deleteDateBtn];
        
        deleteImg = [[UIImageView alloc] init];
        deleteImg.backgroundColor = [UIColor clearColor];
        deleteImg.image = [UIImage imageNamed:@"delete.png"];
        [self.contentView addSubview:deleteImg];
        
        seperaterLine =[[UILabel alloc] init];
        seperaterLine.backgroundColor =[UIColor lightGrayColor];
        seperaterLine.frame =CGRectMake(0, 49, self.frame.size.width, 1);
        [self.contentView addSubview:seperaterLine];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
