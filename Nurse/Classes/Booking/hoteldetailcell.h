//
//  hoteldetailcell.h
//  Snuzo App
//
//  Created by Oneclick IT on 8/31/15.
//  Copyright (c) 2015 Oneclick IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"
@interface hoteldetailcell : UITableViewCell
{
    
}
@property(nonatomic,strong)UILabel *lblline;
@property(nonatomic,strong) UILabel *lbldesc;
@property(nonatomic,strong)UIImageView *starImg;
@property(nonatomic,strong)UIImageView *Imgbad;
@property(nonatomic,strong)UILabel *lblpriceperhours;
@property(nonatomic,strong)UILabel *lbldeschotel;
@property(nonatomic,strong)UIButton *bookBtn;
@property(nonatomic,strong) UIImageView *imgaddres;
@property(nonatomic,strong)UILabel *lbladdress;
@property(nonatomic,strong)UILabel *lblcontact;
@property(nonatomic,strong)UIImageView *imgcontact;
@property(nonatomic,strong)UIButton *btncontact;
@property(nonatomic,strong)UILabel *lblCheckinTime;
@property(nonatomic,strong)UIImageView *imgcheckinimg;
@property(nonatomic,strong)UILabel *lblcheckinTimeDure;
@property(nonatomic,strong)UILabel *lblCheckindate;
@property(nonatomic,strong)UIImageView *imgcheckindateimg;
@property(nonatomic,strong)UILabel *lblcheckindateDure;
@property(nonatomic,strong)UILabel *lblcheckout;
@property(nonatomic,strong)UIImageView *imgcheckout;
@property(nonatomic,strong)UILabel *lblcheckouttime;
@property(nonatomic,strong)UIButton *btnAddress;
@property(nonatomic,strong)UIButton *btnRate;
@property(nonatomic,strong)UILabel *lblDuration;
@property(nonatomic,strong)UIImageView *imgduration;
@property(nonatomic,strong)UILabel *lbldurationTime;
@property(nonatomic,strong)UILabel *lblprice;
@property(nonatomic,strong)UILabel *lblpricevalue;
@property(nonatomic,strong)UILabel *lblfees;
@property(nonatomic,strong)UILabel *lblfeesvalue;
@property(nonatomic,strong)UILabel *lbltext;
@property(nonatomic,strong)UILabel *lbltextvalue;
@property(nonatomic,strong)UILabel *lbltotal;
@property(nonatomic,strong)UILabel *lbltotalvalue;
@property(nonatomic,strong)UILabel *LblEmaild;
@property(nonatomic,strong)UIImageView *ImgEmail;
@property(nonatomic,strong)UILabel *lblCard;
@property(nonatomic,strong)RateView *rateVw;

@property(nonatomic,strong)UIImageView *ImgPrice;
@property(nonatomic,strong)UIImageView *ImgCard;
@property(nonatomic,strong)UILabel *lblCardNo;
@property(nonatomic,strong)UILabel *lblbookingTitle;
@property(nonatomic,strong)UILabel *lblbookingDetail;
@property(nonatomic,strong)UILabel *lblNurseName;
@property(nonatomic,strong)UILabel *lblNurseTitle;
@property(nonatomic,strong)UILabel *lblStatusTitle;
@property(nonatomic,strong)UILabel *lblStatus;



@end