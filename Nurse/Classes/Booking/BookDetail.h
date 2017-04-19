//
//  BookDetail.h
//  Snuzo App
//
//  Created by Oneclick IT on 11/3/15.
//  Copyright © 2015 Oneclick IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
//#import "hoteldetailcell.h"
//#import "MapClass.h"
#import "URLManager.h"


@interface BookDetail : UIViewController<UITableViewDataSource,UITableViewDelegate,URLManagerDelegate>
{
    AsyncImageView *imghotel;
    NSMutableArray *roomtypearrray,*timeArray,*maintime;
 NSInteger serviceCount;
    UIButton *btnBack;
    UILabel *lbltitle;
    UITableView *tblcontent;
    CGPoint lastPos;
    UIImageOrientation scrollOrientation;
    UIImageView *topImg;
    NSInteger price;
    NSString *strmianTime;
    NSString *strCheckoutTime;
    NSString *customerId;
    
    UIButton * acceptBtn;
    UIButton * rejectBtn;
    
    NSString *strHotelID;
    
    UIImageView * typeImg;
    UILabel * hotelTypeLbl;
}
@property (nonatomic,strong)NSMutableArray *HotelDetailArray;
@property(nonatomic,strong)NSString *hotelname,*strBOOKID,*strContact,*isfrombokking,*strLat,*strlon,*strStaus,*isFromPast,*strHospitalName;
@property(nonatomic,strong)NSMutableArray *searchdetailarray;
@property(nonatomic,strong)NSString *imageurl;
@property(nonatomic,strong)NSMutableArray *cartDetails;
@property(nonatomic,strong)NSMutableArray *pricearray;
@property (nonatomic,strong)NSArray *specializationArr;
@property (nonatomic,strong)NSMutableDictionary * acceptRejectDict;
@property BOOL isFromAcceptReject;
@end
