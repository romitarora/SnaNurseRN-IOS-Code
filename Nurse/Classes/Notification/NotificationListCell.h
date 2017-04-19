//
//  NotificationListCell.h
//  Nurse
//
//  Created by one click IT consultany on 8/17/16.
//  Copyright © 2016 com.Oneclick.apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "Constant.h"
@interface NotificationListCell : UITableViewCell
{
    
}
@property(nonatomic,strong)UIImageView * acceptImg;
@property(nonatomic,strong)UIImageView * rejectImg;
@property(nonatomic,strong)AsyncImageView * profileImg;
@property(nonatomic,strong)UILabel * titleLbl;
@property(nonatomic,strong)UILabel * msgLbl;
@property(nonatomic,strong)UILabel * statusLbl;
@property(nonatomic,strong)UILabel * agencyNameLbl;
@property(nonatomic,strong)UILabel * lineLbl;
@property(nonatomic,strong)UIButton * acceptBtn;
@property(nonatomic,strong)UIButton * rejectBtn;
@property(nonatomic,strong)UILabel * acceptLbl;
@property(nonatomic,strong)UILabel * rejectLbl;
@property(nonatomic,strong)UILabel * lblduration;
@property(nonatomic,strong)UILabel * lblStartTime,*lblEndTime;
@end
