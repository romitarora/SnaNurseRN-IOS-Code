//
//  pastbookingcell.h
//  Snuzo App
//
//  Created by Oneclick IT on 9/2/15.
//  Copyright (c) 2015 Oneclick IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "RateView.h"

@interface pastbookingcell : UITableViewCell
{
    
}
@property(nonatomic,strong)AsyncImageView *imgNurse;
@property(nonatomic,strong)UILabel *lblline;
@property(nonatomic,strong)RateView *rateVw;
@property(nonatomic,strong)UILabel *lblNurseName;
@property(nonatomic,strong)UILabel *lblduration;
@property(nonatomic,strong)UIImageView * sepratorLineImg;
@property(nonatomic,strong)UIButton *btnCancle;
@property(nonatomic,strong)UILabel *lblarrivaltime,*lblHrs,*lblRent,*lblStatus,*lblBookingId;
@property(nonatomic,strong)UILabel *lblCat1,*lblCat2,*lblCat3,*lblCatMore,*lblCat4,*lblCat5,*lblCat6,*lblStartTime,*lblEndTime;
-(void) specialization:(NSArray *) arrTemp atIndexPath:(NSIndexPath *) indexPath;

@end
