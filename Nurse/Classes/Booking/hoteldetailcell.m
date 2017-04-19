//
//  hoteldetailcell.m
//  Snuzo App
//
//  Created by Oneclick IT on 8/31/15.
//  Copyright (c) 2015 Oneclick IT. All rights reserved.
//

#import "hoteldetailcell.h"

@implementation hoteldetailcell
@synthesize lblline,lbldesc,starImg,Imgbad,lbldeschotel,lblpriceperhours,bookBtn,imgaddres,lbladdress,lblcontact,imgcontact,btncontact,lblCheckinTime,imgcheckinimg,lblcheckinTimeDure,lblCheckindate,imgcheckindateimg,lblcheckindateDure,lblcheckout,imgcheckout,lblcheckouttime,lblDuration,imgduration,lbldurationTime,lblprice,lblpricevalue,lblfees,lblfeesvalue,lbltext,lbltextvalue,lbltotal,lbltotalvalue,btnAddress,btnRate,ImgEmail,LblEmaild,lblCard,lblCardNo,rateVw,ImgCard,ImgPrice,lblStatus,lblNurseTitle,lblbookingTitle,lblStatusTitle,lblNurseName,lblbookingDetail;
;
- (void)awakeFromNib
{
    
    
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        lblline=[[UILabel alloc]init] ;
                  //]WithFrame:CGRectMake(0, self.frame.size.height-2, self.frame.size.width, 2)];
        lblline.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"devider"]];
        [self.contentView addSubview:lblline];
        
        lbldesc=[[UILabel alloc]init];
        lbldesc.textColor=[UIColor whiteColor];
        lbldesc.font=[UIFont systemFontOfSize:12.0];
        
        Imgbad=[[UIImageView alloc]init];
        [self.contentView addSubview:Imgbad];
        
        lbldeschotel=[[UILabel alloc]init];
        [self.contentView addSubview:lbldeschotel];
        
        lblpriceperhours=[[UILabel alloc]init];
        [self.contentView addSubview:lblpriceperhours];
        
        
        bookBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:bookBtn];
        
        imgaddres=[[UIImageView alloc]init];
        [self.contentView addSubview:imgaddres];

        
        lbladdress=[[UILabel alloc]init];
        [self.contentView addSubview:lbladdress];
        
        
        imgcontact=[[UIImageView alloc]init];
        [self.contentView addSubview:imgcontact];
        
        lblcontact=[[UILabel alloc]init];
        [self.contentView addSubview:lblcontact];

        
        btncontact=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btncontact];
        
        imgcheckinimg=[[UIImageView alloc]init];
        [self.contentView addSubview:imgcheckinimg];
        
        lblCheckinTime=[[UILabel alloc]init];
        [self.contentView addSubview:lblCheckinTime];
        
        lblcheckinTimeDure=[[UILabel alloc]init];
        [self.contentView addSubview:lblcheckinTimeDure];
        
        lblCard=[[UILabel alloc]init];
        [self.contentView addSubview:lblCard];
        
        lblCardNo=[[UILabel alloc]init];
        [self.contentView addSubview:lblCardNo];
        
        imgcheckindateimg=[[UIImageView alloc]init];
        [self.contentView addSubview:imgcheckindateimg];
        
        lblCheckindate=[[UILabel alloc]init];
        [self.contentView addSubview:lblCheckindate];
        
        lblcheckindateDure=[[UILabel alloc]init];
        [self.contentView addSubview:lblcheckindateDure];
        
        imgcheckout=[[UIImageView alloc]init];
        [self.contentView addSubview:imgcheckout];
        
        lblcheckout=[[UILabel alloc]init];
        [self.contentView addSubview:lblcheckout];
        
        lblcheckouttime=[[UILabel alloc]init];
        [self.contentView addSubview:lblcheckouttime];

        imgduration=[[UIImageView alloc]init];
        [self.contentView addSubview:imgduration];
        
        lblDuration=[[UILabel alloc]init];
        [self.contentView addSubview:lblDuration];
        
        lbldurationTime=[[UILabel alloc]init];
        [self.contentView addSubview:lbldurationTime];

        lblprice=[[UILabel alloc]init];
        [self.contentView addSubview:lblprice];

        lblpricevalue=[[UILabel alloc]init];
        [self.contentView addSubview:lblpricevalue];
        
        lblfees=[[UILabel alloc]init];
        [self.contentView addSubview:lblfees];
        
        lblfeesvalue=[[UILabel alloc]init];
        [self.contentView addSubview:lblfeesvalue];

        lbltext=[[UILabel alloc]init];
        [self.contentView addSubview:lbltext];
        
        
        lbltextvalue=[[UILabel alloc]init];
        [self.contentView addSubview:lbltextvalue];
        
        
        lbltotal=[[UILabel alloc]init];
        [self.contentView addSubview:lbltotal];
        

        lbltotalvalue=[[UILabel alloc]init];
        [self.contentView addSubview:lbltotalvalue];
        
        
        rateVw = [RateView rateViewWithRating:0.0];
        rateVw.hidden=YES;
        
        [self.contentView addSubview:rateVw];
        
        btnAddress=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:btnAddress];

        btnRate=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:btnRate];
        
        ImgEmail=[[UIImageView alloc]init];
        
        [self.contentView addSubview:ImgEmail];
        
        LblEmaild=[[UILabel alloc]init];
        [self.contentView addSubview:LblEmaild];
        
        ImgPrice=[[UIImageView alloc]init];
        [self.contentView addSubview:ImgPrice];
        
        ImgCard=[[UIImageView alloc]init];
        [self.contentView addSubview:ImgCard];
        
        lblNurseName=[[UILabel alloc]init];
        [self.contentView addSubview:lblNurseName];
        lblNurseTitle=[[UILabel alloc]init];
        [self.contentView addSubview:lblNurseTitle];
        lblbookingDetail=[[UILabel alloc]init];
        [self.contentView addSubview:lblbookingDetail];
        lblbookingTitle=[[UILabel alloc]init];
        [self.contentView addSubview:lblbookingTitle];
        lblStatusTitle=[[UILabel alloc]init];
        [self.contentView addSubview:lblStatusTitle];
        lblStatus=[[UILabel alloc]init];
        [self.contentView addSubview:lblStatus];

        /*
         lblprice
         lblpricevalue
         lblfees
         lblfeesvalue
         lbltext
         lbltextvalue
         */
        
    }
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
