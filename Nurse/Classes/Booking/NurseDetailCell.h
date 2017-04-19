//
//  NurseDetailCell.h
//  Snuzo App
//
//  Created by one click IT consultany on 7/29/16.
//  Copyright © 2016 Oneclick IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NurseDetailCell : UITableViewCell
@property (nonatomic , strong) UILabel * titleLbl;
@property (nonatomic , strong) UITextView * descriptionLbl;
@property (nonatomic , strong) UIImageView * iconImgView;
@property (nonatomic , strong) UILabel * linelbl;
@property(nonatomic,strong)UILabel *lblCheckinTime;
@property(nonatomic,strong)UIImageView *imgcheckinimg;
@property(nonatomic,strong)UILabel *lblcheckinTimeDure;
@property(nonatomic,strong)UILabel *lblcheckindateDure;
@property(nonatomic,strong)UIImageView *imgcheckindateimg;
@property(nonatomic,strong)UILabel *lblCheckindate;
@property(nonatomic,strong)UILabel *lblcheckout;
@property(nonatomic,strong)UIImageView *imgcheckout;
@property(nonatomic,strong)UILabel *lblcheckouttime;
@property(nonatomic,strong)UILabel *lblDuration;
@property(nonatomic,strong)UIImageView *imgduration;
@property(nonatomic,strong)UILabel *lbldurationTime;
@end
