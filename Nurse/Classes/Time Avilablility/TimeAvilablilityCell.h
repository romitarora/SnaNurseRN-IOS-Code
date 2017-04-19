//
//  TimeAvilablilityCell.h
//  Nurse
//
//  Created by one click IT consultany on 9/14/16.
//  Copyright © 2016 com.Oneclick.apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "AppDelegate.h"
@interface TimeAvilablilityCell : UITableViewCell
{
    
}
@property(nonatomic,strong)UILabel * titleLbl ,*lblHrs;
@property(nonatomic,strong)UILabel * seperaterLine;
@property(nonatomic,strong)UILabel * availableStatusLbl;
@property(nonatomic,strong)UILabel * detailLbl;
@property(nonatomic,strong)UISwitch * dayOnOffSwitch;
@property(nonatomic,strong)UIButton * deleteDateBtn;
@property(nonatomic,strong)UIImageView * deleteImg;
@end
