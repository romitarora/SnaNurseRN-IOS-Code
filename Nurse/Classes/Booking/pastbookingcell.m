//
//  pastbookingcell.m
//  Snuzo App
//
//  Created by Oneclick IT on 9/2/15.
//  Copyright (c) 2015 Oneclick IT. All rights reserved.
//

#import "pastbookingcell.h"
#import "Constant.h"
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width


@implementation pastbookingcell
@synthesize imgNurse,lblline,lblNurseName,lblHrs,lblduration,lblarrivaltime,lblRent,lblStatus,btnCancle,lblBookingId,rateVw,lblCat4,lblCat5,lblCat6,lblCat3,lblCat2,lblCat1,lblEndTime,lblStartTime,sepratorLineImg;

- (void)awakeFromNib
{
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        imgNurse=[[AsyncImageView alloc]initWithFrame:CGRectMake(15,16.5,70,70)];
        imgNurse.image=[UIImage imageNamed:@""];
        imgNurse.layer.cornerRadius=35;
        imgNurse.layer.borderColor = [UIColor whiteColor].CGColor;
        imgNurse.layer.borderWidth=0.5;
        imgNurse.contentMode = UIViewContentModeScaleAspectFill;
        [imgNurse setClipsToBounds:YES];
        [self.contentView addSubview:imgNurse];
        
        lblStatus = [[UILabel alloc] init];
        lblStatus.frame = CGRectMake(90, 40, 100, 18);//Jam22-09
        lblStatus.backgroundColor =[UIColor clearColor];
        lblStatus.textColor=[UIColor colorWithRed:255/255.0 green:172/255.0 blue:95/255.0 alpha:1.0];
        lblStatus.font=[UIFont fontWithName:@"AvenirNextLTPro-Demi" size:12];
        lblStatus.text = @"";
        lblStatus.textAlignment = NSTextAlignmentCenter;//Jam22-09
        lblStatus.layer.cornerRadius = 9;
        lblStatus.layer.masksToBounds = YES;
        [self.contentView addSubview:lblStatus];
        
        lblline=[[UILabel alloc]initWithFrame:CGRectMake(20,102.5,ScreenWidth-20, 0.5)];
        lblline.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:lblline];
        
        lblNurseName=[[UILabel alloc]initWithFrame:CGRectMake(90, 15, ScreenWidth-140, 15)];
        lblNurseName.text=@"Richmond Hotel Narita";
        lblNurseName.textColor=[UIColor blackColor];
        lblNurseName.font=[UIFont fontWithName:@"AvenirNextLTPro-Demi" size:15];
        [self.contentView addSubview:lblNurseName];
        
        
        UIImageView * hourBackImg =[[UIImageView alloc] init];
        hourBackImg.frame =CGRectMake(ScreenWidth-50, 32.5,38, 38);
        hourBackImg.backgroundColor =[UIColor clearColor];
        hourBackImg.image = [UIImage imageNamed:@"Hours_box"];
        [self.contentView addSubview:hourBackImg];
        
        lblHrs=[[UILabel alloc]initWithFrame:CGRectMake(0, 10,38, 28)];
        lblHrs.text=@"2 HRS";
        lblHrs.textColor=[UIColor blackColor];
        lblHrs.font =[UIFont systemFontOfSize:10];
        //lblHrs.layer.cornerRadius=20;
        lblHrs.backgroundColor=[UIColor clearColor];
        // lblHrs.clipsToBounds=YES;
        lblHrs.textAlignment=NSTextAlignmentCenter;
        lblHrs.numberOfLines=0;
        [hourBackImg addSubview:lblHrs];
        
        lblduration=[[UILabel alloc]initWithFrame:CGRectMake(90, 70+3,200, 18)];
        lblduration.layer.cornerRadius = 9;
        lblduration.layer.masksToBounds = YES;
        lblduration.backgroundColor =globelColor;
        [self.contentView addSubview:lblduration];
        
        lblStartTime = [[UILabel alloc] init];
        lblStartTime.frame = CGRectMake(90, 70+3, 75, 18);
        lblStartTime.textColor=[UIColor whiteColor];
        lblStartTime.font=[UIFont systemFontOfSize:10];
        lblStartTime.text = @"05 PM";
        lblStartTime.textAlignment = NSTextAlignmentCenter;
        //        lblStartTime.backgroundColor=[UIColor blackColor];
        [self.contentView addSubview:lblStartTime];
        
        sepratorLineImg = [[UIImageView alloc] init];
        sepratorLineImg.frame = CGRectMake(122+25, 70+3+4.5+3, 42, 6);
        sepratorLineImg.image = [UIImage imageNamed:@"white_line.png"];
        sepratorLineImg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:sepratorLineImg];
        
        lblEndTime = [[UILabel alloc] init];
        lblEndTime.frame = CGRectMake(165+25, 70+3, 75, 18);
        lblEndTime.textColor=[UIColor whiteColor];
        lblEndTime.font=[UIFont systemFontOfSize:10];
        lblEndTime.text = @"08 PM";
        lblEndTime.textAlignment = NSTextAlignmentCenter;
        //        lblEndTime.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:lblEndTime];
        
        return self;
    }
    return self;
    
}
-(void) specialization:(NSArray *) arrTemp atIndexPath:(NSIndexPath *) indexPath
{
    
    UIView *box1 ;
    box1=[[UIView alloc] initWithFrame:CGRectMake(85, 30, ScreenWidth-155, 50)];
    
    [box1  setBackgroundColor:[UIColor clearColor]];
    [self.contentView        addSubview:box1];
    
    
    CGSize frameSize = CGSizeMake(ScreenWidth-155, 50);
    UIFont *font = [UIFont fontWithName:@"AvenirNextLTPro-Demi" size:12.0];
    
    CGRect idealFrame  ;
    
    float width= 5.0;
    for (NSInteger i = 0; i < [arrTemp count]; i++)
    {
        NSString * strSpecialist= [NSString stringWithFormat:@"%@",[arrTemp objectAtIndex:i]];
        idealFrame   = [strSpecialist boundingRectWithSize:frameSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{ NSFontAttributeName:font }
                                                   context:nil];
        
        //  NSLog(@"frameSize ==> %f idealFrame.size.width+ %f text ==%@",frameSize.width,idealFrame.size.width+20,strSpecialist);
        
        
        //width = width + idealFrame.size.width+10;
        width = width + idealFrame.size.width+30;
        
        
    }
    // NSLog(@"frameSize ==> %f text_width %f",frameSize.width,width);
    
    if (width>frameSize.width+5)
    {
        // NSLog(@"Gtet ==> width==%f  frameSize.width ==%f",width,frameSize.width);
        
        int x=5,y=5;
        int chLine=0;
        int chWords=0;
        for (NSInteger i = 0; i < [arrTemp count]; i++)
        {
            NSString * strSpecialist= [NSString stringWithFormat:@"%@",[arrTemp objectAtIndex:i]];
            
            UILabel * lblSpl=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 45, 18)];
            lblSpl.text=[NSString stringWithFormat:@" %@",strSpecialist];
            lblSpl.textColor=[UIColor whiteColor];
            lblSpl.font =[UIFont systemFontOfSize:10];
            lblSpl.layer.cornerRadius=8;
            lblSpl.clipsToBounds=YES;
            //lblSpl.textAlignment=NSTextAlignmentCenter;
            lblSpl.backgroundColor=[UIColor colorWithRed:255/255.0 green:172/255.0 blue:95/255.0 alpha:1.0];
            [box1 addSubview:lblSpl];
            
            CGRect idealFrame1 = [strSpecialist boundingRectWithSize:frameSize
                                                             options:NSStringDrawingUsesLineFragmentOrigin
                                                          attributes:@{ NSFontAttributeName:font }
                                                             context:nil];
            
            if (x+idealFrame1.size.width + 20<frameSize.width)
            {
                if (chLine==0)
                {
                    chWords++;
                    
                    if ([arrTemp count]==1)
                    {
                        y=15;
                    }
                    
                    lblSpl.frame =CGRectMake(x, y, idealFrame1.size.width + 20, 18);
                    x=x+idealFrame1.size.width +30;
                    lblSpl.backgroundColor=[self sendingWords:chWords atIndexPath:indexPath];
                    
                }else
                {
                    chWords++;
                    
                    if (i+1<[arrTemp count])
                    {
                        NSString * strSpecialist2= [NSString stringWithFormat:@"%@",[arrTemp objectAtIndex:i+1]];
                        CGRect idealFrame2 = [strSpecialist2 boundingRectWithSize:frameSize
                                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                                       attributes:@{ NSFontAttributeName:font }
                                                                          context:nil];
                        if (idealFrame2.size.width+20+idealFrame1.size.width + 20<frameSize.width)
                        {
                            lblSpl.frame =CGRectMake(x, y, idealFrame1.size.width + 20, 18);
                            lblSpl.backgroundColor=[self sendingWords:chWords atIndexPath:indexPath];
                            
                            x=x+idealFrame1.size.width +30;
                        }else
                        {
                            lblSpl.frame =CGRectMake(x, y, frameSize.width-90, 16);
                            lblSpl.backgroundColor=[self sendingWords:chWords atIndexPath:indexPath];
                            
                            
                            UILabel * lblSpl1=[[UILabel alloc]initWithFrame:CGRectMake(frameSize.width-80, y, 20, 18)];
                            lblSpl1.text=[NSString stringWithFormat:@"+%lu",[arrTemp count]-chWords];
                            lblSpl1.textColor=[UIColor whiteColor];
                            lblSpl1.font =[UIFont systemFontOfSize:12];
                            lblSpl1.layer.cornerRadius=8;
                            lblSpl1.clipsToBounds=YES;
                            lblSpl1.textAlignment=NSTextAlignmentCenter;
                            lblSpl1.backgroundColor=[UIColor colorWithRed:255/255.0 green:172/255.0 blue:95/255.0 alpha:1.0];
                            
                            CGRect idealFrame3 = [lblSpl1.text boundingRectWithSize:frameSize
                                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                                         attributes:@{ NSFontAttributeName:font }
                                                                            context:nil];
                            
                            lblSpl1.frame =CGRectMake(frameSize.width-80, y, idealFrame3.size.width + 20, 18);
                            [box1 addSubview:lblSpl1];
                            lblSpl1.backgroundColor=[UIColor colorWithRed:164/255.0 green:195/255.0 blue:68/255.0 alpha:1.0];
                            
                            break;
                            
                        }
                    }else
                    {
                        lblSpl.frame =CGRectMake(x, y, idealFrame1.size.width + 20, 18);
                        x=x+idealFrame1.size.width +30;
                        lblSpl.backgroundColor=[self sendingWords:chWords atIndexPath:indexPath];
                    }
                    
                }
                
            }else
            {
                if (x==5 && y==5)
                {
                    chWords++;
                    
                    if ([arrTemp count]==1)
                    {
                        y=15;
                    }
                    
                    lblSpl.frame =CGRectMake(x, y, frameSize.width- 20, 18);
                    lblSpl.lineBreakMode=NSLineBreakByTruncatingTail;
                    lblSpl.backgroundColor=[self sendingWords:chWords atIndexPath:indexPath];
                    x=5;
                    y=30;
                    
                }
                else
                {
                    if (chLine==0)
                    {
                        
                        
                        x=5;
                        y=30;
                        
                        chWords++;
                        if (i+1<[arrTemp count])
                        {
                            NSString * strSpecialist2= [NSString stringWithFormat:@"%@",[arrTemp objectAtIndex:i+1]];
                            CGRect idealFrame2 = [strSpecialist2 boundingRectWithSize:frameSize
                                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                                           attributes:@{ NSFontAttributeName:font }
                                                                              context:nil];
                            if (idealFrame2.size.width+20+idealFrame1.size.width + 20<frameSize.width)
                            {
                                lblSpl.frame =CGRectMake(x, y, idealFrame1.size.width + 20, 18);
                                x=x+idealFrame1.size.width +30;
                                lblSpl.backgroundColor=[self sendingWords:chWords atIndexPath:indexPath];
                                
                            }
                            else
                            {
                                lblSpl.frame =CGRectMake(x, y, frameSize.width-90, 18);
                                lblSpl.backgroundColor=[self sendingWords:chWords atIndexPath:indexPath];
                                
                                
                                UILabel * lblSpl1=[[UILabel alloc]initWithFrame:CGRectMake(frameSize.width-80, y, 20, 18)];
                                lblSpl1.text=[NSString stringWithFormat:@"+%lu",[arrTemp count]-chWords];
                                lblSpl1.textColor=[UIColor whiteColor];
                                lblSpl1.font =[UIFont systemFontOfSize:12];
                                lblSpl1.layer.cornerRadius=8;
                                lblSpl1.clipsToBounds=YES;
                                lblSpl1.textAlignment=NSTextAlignmentCenter;
                                lblSpl1.backgroundColor=[UIColor colorWithRed:255/255.0 green:172/255.0 blue:95/255.0 alpha:1.0];
                                
                                CGRect idealFrame3 = [lblSpl1.text boundingRectWithSize:frameSize
                                                                                options:NSStringDrawingUsesLineFragmentOrigin
                                                                             attributes:@{ NSFontAttributeName:font }
                                                                                context:nil];
                                
                                lblSpl1.frame =CGRectMake(frameSize.width-80, y, idealFrame3.size.width + 20, 18);
                                [box1 addSubview:lblSpl1];
                                lblSpl1.backgroundColor=[UIColor colorWithRed:164/255.0 green:195/255.0 blue:68/255.0 alpha:1.0];
                                break;
                                
                            }
                        }else
                        {
                            lblSpl.frame =CGRectMake(x, y, idealFrame1.size.width + 20, 18);
                            x=x+idealFrame1.size.width +30;
                            lblSpl.backgroundColor=[self sendingWords:chWords atIndexPath:indexPath];
                        }
                    }else
                    {
                        lblSpl.text=[NSString stringWithFormat:@"+%lu",[arrTemp count]-chWords];
                        lblSpl.textColor=[UIColor whiteColor];
                        lblSpl.font =[UIFont systemFontOfSize:12];
                        lblSpl.layer.cornerRadius=8;
                        lblSpl.clipsToBounds=YES;
                        lblSpl.textAlignment=NSTextAlignmentCenter;
                        lblSpl.backgroundColor=[UIColor colorWithRed:255/255.0 green:172/255.0 blue:95/255.0 alpha:1.0];
                        [box1 addSubview:lblSpl];
                        
                        CGRect idealFrame1 = [lblSpl.text boundingRectWithSize:frameSize
                                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                                    attributes:@{ NSFontAttributeName:font }
                                                                       context:nil];
                        
                        lblSpl.frame =CGRectMake(x, y, idealFrame1.size.width + 15, 16);
                        
                        lblSpl.backgroundColor=[UIColor colorWithRed:255/255.0 green:172/255.0 blue:95/255.0 alpha:1.0];
                        
                        
                        x=x+idealFrame1.size.width +30;
                        break;
                    }
                }
                if (chLine==0) {
                    chLine++;
                }
                
            }
        }
        
    }
    else
    {
        // NSLog(@"les ==> width==%f  frameSize.width ==%f",width,frameSize.width);
        int x=5,y=15;
        int chLine=0;
        int chWords=0;
        for (NSInteger i = 0; i < [arrTemp count]; i++)
        {
            NSString * strSpecialist= [NSString stringWithFormat:@"%@",[arrTemp objectAtIndex:i]];
            
            UILabel * lblSpl=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 45, 18)];
            lblSpl.text=[NSString stringWithFormat:@" %@",strSpecialist];
            lblSpl.textColor=[UIColor whiteColor];
            lblSpl.font =[UIFont systemFontOfSize:10];
            lblSpl.layer.cornerRadius=8;
            lblSpl.clipsToBounds=YES;
            //lblSpl.textAlignment=NSTextAlignmentCenter;
            lblSpl.backgroundColor=[UIColor colorWithRed:255/255.0 green:172/255.0 blue:95/255.0 alpha:1.0];
            [box1 addSubview:lblSpl];
            
            CGRect idealFrame1 = [strSpecialist boundingRectWithSize:frameSize
                                                             options:NSStringDrawingUsesLineFragmentOrigin
                                                          attributes:@{ NSFontAttributeName:font }
                                                             context:nil];
            
            if (x+idealFrame1.size.width + 20<frameSize.width)
            {
                if (chLine==0)
                {
                    chWords++;
                    
                    if ([arrTemp count]==1)
                    {
                        y=15;
                    }
                    
                    lblSpl.frame =CGRectMake(x, y, idealFrame1.size.width + 20, 18);
                    x=x+idealFrame1.size.width +30;
                    lblSpl.backgroundColor=[self sendingWords:chWords atIndexPath:indexPath];
                    
                }else
                {
                    chWords++;
                    
                    if (i+1<[arrTemp count])
                    {
                        NSString * strSpecialist2= [NSString stringWithFormat:@"%@",[arrTemp objectAtIndex:i+1]];
                        CGRect idealFrame2 = [strSpecialist2 boundingRectWithSize:frameSize
                                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                                       attributes:@{ NSFontAttributeName:font }
                                                                          context:nil];
                        if (idealFrame2.size.width+20+idealFrame1.size.width + 20<frameSize.width)
                        {
                            lblSpl.frame =CGRectMake(x, y, idealFrame1.size.width + 20, 18);
                            lblSpl.backgroundColor=[self sendingWords:chWords atIndexPath:indexPath];
                            
                            x=x+idealFrame1.size.width +30;
                        }
                        else
                        {
                            lblSpl.frame =CGRectMake(x, y, frameSize.width-90, 18);
                            lblSpl.backgroundColor=[self sendingWords:chWords atIndexPath:indexPath];
                            
                            
                            UILabel * lblSpl1=[[UILabel alloc]initWithFrame:CGRectMake(frameSize.width-80, y, 20, 18)];
                            lblSpl1.text=[NSString stringWithFormat:@"+%lu",[arrTemp count]-chWords];
                            lblSpl1.textColor=[UIColor whiteColor];
                            lblSpl1.font =[UIFont systemFontOfSize:12];
                            lblSpl1.layer.cornerRadius=8;
                            lblSpl1.clipsToBounds=YES;
                            lblSpl1.textAlignment=NSTextAlignmentCenter;
                            lblSpl1.backgroundColor=[UIColor colorWithRed:255/255.0 green:172/255.0 blue:95/255.0 alpha:1.0];
                            
                            CGRect idealFrame3 = [lblSpl1.text boundingRectWithSize:frameSize
                                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                                         attributes:@{ NSFontAttributeName:font }
                                                                            context:nil];
                            
                            lblSpl1.frame =CGRectMake(frameSize.width-80, y, idealFrame3.size.width + 20, 18);
                            [box1 addSubview:lblSpl1];
                            lblSpl1.backgroundColor=[UIColor colorWithRed:164/255.0 green:195/255.0 blue:68/255.0 alpha:1.0];
                            
                            break;
                            
                        }
                    }else
                    {
                        lblSpl.frame =CGRectMake(x, y, idealFrame1.size.width + 20, 18);
                        x=x+idealFrame1.size.width +30;
                        lblSpl.backgroundColor=[self sendingWords:chWords atIndexPath:indexPath];
                    }
                    
                }
                
            }else
            {
                if (x==5 && y==5)
                {
                    chWords++;
                    
                    if ([arrTemp count]==1)
                    {
                        y=15;
                    }
                    
                    lblSpl.frame =CGRectMake(x, y, frameSize.width- 20, 18);
                    lblSpl.lineBreakMode=NSLineBreakByTruncatingTail;
                    lblSpl.backgroundColor=[self sendingWords:chWords atIndexPath:indexPath];
                    x=5;
                    y=30;
                    
                }else
                {
                    if (chLine==0)
                    {
                        
                        
                        x=5;
                        y=30;
                        
                        chWords++;
                        if (i+1<[arrTemp count])
                        {
                            NSString * strSpecialist2= [NSString stringWithFormat:@"%@",[arrTemp objectAtIndex:i+1]];
                            CGRect idealFrame2 = [strSpecialist2 boundingRectWithSize:frameSize
                                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                                           attributes:@{ NSFontAttributeName:font }
                                                                              context:nil];
                            if (idealFrame2.size.width+20+idealFrame1.size.width + 20<frameSize.width)
                            {
                                lblSpl.frame =CGRectMake(x, y, idealFrame1.size.width + 20, 18);
                                x=x+idealFrame1.size.width +30;
                                lblSpl.backgroundColor=[self sendingWords:chWords atIndexPath:indexPath];
                                
                            }else
                            {
                                lblSpl.frame =CGRectMake(x, y, frameSize.width-90, 16);
                                lblSpl.backgroundColor=[self sendingWords:chWords atIndexPath:indexPath];
                                
                                
                                UILabel * lblSpl1=[[UILabel alloc]initWithFrame:CGRectMake(frameSize.width-80, y, 20, 18)];
                                lblSpl1.text=[NSString stringWithFormat:@"+%lu",[arrTemp count]-chWords];
                                lblSpl1.textColor=[UIColor whiteColor];
                                lblSpl1.font =[UIFont systemFontOfSize:12];
                                lblSpl1.layer.cornerRadius=8;
                                lblSpl1.clipsToBounds=YES;
                                lblSpl1.textAlignment=NSTextAlignmentCenter;
                                lblSpl1.backgroundColor=[UIColor colorWithRed:255/255.0 green:172/255.0 blue:95/255.0 alpha:1.0];
                                
                                CGRect idealFrame3 = [lblSpl1.text boundingRectWithSize:frameSize
                                                                                options:NSStringDrawingUsesLineFragmentOrigin
                                                                             attributes:@{ NSFontAttributeName:font }
                                                                                context:nil];
                                
                                lblSpl1.frame =CGRectMake(frameSize.width-80, y, idealFrame3.size.width + 20, 18);
                                [box1 addSubview:lblSpl1];
                                lblSpl1.backgroundColor=[UIColor colorWithRed:164/255.0 green:195/255.0 blue:68/255.0 alpha:1.0];
                                break;
                                
                            }
                        }else
                        {
                            lblSpl.frame =CGRectMake(x, y, idealFrame1.size.width + 20, 18);
                            x=x+idealFrame1.size.width +30;
                            lblSpl.backgroundColor=[self sendingWords:chWords atIndexPath:indexPath];
                        }
                    }else
                    {
                        lblSpl.text=[NSString stringWithFormat:@"+%lu",[arrTemp count]-chWords];
                        lblSpl.textColor=[UIColor whiteColor];
                        lblSpl.font =[UIFont systemFontOfSize:12];
                        lblSpl.layer.cornerRadius=8;
                        lblSpl.clipsToBounds=YES;
                        lblSpl.textAlignment=NSTextAlignmentCenter;
                        lblSpl.backgroundColor=[UIColor colorWithRed:255/255.0 green:172/255.0 blue:95/255.0 alpha:1.0];
                        [box1 addSubview:lblSpl];
                        
                        CGRect idealFrame1 = [lblSpl.text boundingRectWithSize:frameSize
                                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                                    attributes:@{ NSFontAttributeName:font }
                                                                       context:nil];
                        
                        lblSpl.frame =CGRectMake(x, y, idealFrame1.size.width + 15, 18);
                        
                        lblSpl.backgroundColor=[UIColor colorWithRed:255/255.0 green:172/255.0 blue:95/255.0 alpha:1.0];
                        
                        
                        x=x+idealFrame1.size.width +30;
                        break;
                    }
                }
                if (chLine==0) {
                    chLine++;
                }
                
            }
        }
    }
    
    //    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    //    paragraphStyle.lineSpacing = 5.0;
    //    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    //
    //    lblCat1.attributedText = string;
    
}

- (void)setupViews
{
    
}
- (void)setupConstraints:(UILabel *)lblconstraints {
    NSMutableArray<NSLayoutConstraint *> *constraints = [NSMutableArray new];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4.0-[_label]-4.0-|"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:nil
                                                                               views:@{@"_label": lblconstraints}]];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:lblconstraints
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:1.0
                                                         constant:24.0]];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:lblconstraints
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0
                                                         constant:3.0]];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:lblconstraints
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0
                                                         constant:3.0]];
    
    [NSLayoutConstraint activateConstraints:constraints];
}

#pragma mark - Getter


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma mark - Set Attribute Strings
-(void)setAttributedTextForGivenString:(NSString*)givenString AndLabel:(UILabel*)label AndTextAlignment:(NSTextAlignment)alignment AndLineSpacing:(CGFloat)lineSpacing AndFontName:(NSString*)fontName AndFontSize:(CGFloat)fontSize
{
    NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpacing;
    NSDictionary *attributtes = @{NSParagraphStyleAttributeName : style};
    label.attributedText = [[NSAttributedString alloc] initWithString:givenString attributes:attributtes];
    label.font = [UIFont fontWithName:fontName size:fontSize];
    label.textAlignment = alignment;
}

-(UIColor *)sendingWords:(int)wordscount atIndexPath :(NSIndexPath *)indexPath
{
    UIColor *randColor;
    if ((int)wordscount == 0)
    {
        randColor = [UIColor colorWithRed:88.0f/255.0f green:86.0f/255.0f blue:214.0f/255.0f alpha:1.0f];
    }
    else if ((int)wordscount == 4)
    {
        randColor = [UIColor colorWithRed:142/255.0f green:142/255.0f blue:147/255.0f alpha:1.0f];
    }
    else if ((int)wordscount == 3)
    {
        randColor = [UIColor colorWithRed:26/255.0f green:213/255.0f blue:154/255.0f alpha:1.0f];;
    }
    else if ( (int)wordscount == 2)
    {
        randColor = [UIColor colorWithRed:221/255.0f green:120/255.0f blue:252/255.0f alpha:1.0f];
    }
    else if ((int)wordscount == 1)
    {
        if (indexPath.row % 1)
        {
            randColor = [UIColor colorWithRed:254/255.0f green:100/255.0f blue:143/255.0f alpha:1.0f];
        }
        else if (indexPath.row %2)
        {
            randColor = [UIColor colorWithRed:88.0f/255.0f green:86.0f/255.0f blue:214.0f/255.0f alpha:1.0f];
        }
        else
        {
            randColor = [UIColor colorWithRed:254/255.0f green:100/255.0f blue:143/255.0f alpha:1.0f];
        }
        
    }else
    {
        randColor = [UIColor colorWithRed:88.0f/255.0f green:86.0f/255.0f blue:214.0f/255.0f alpha:1.0f];
    }
    return randColor;
}

#pragma mark - NSAttributedString

+ (NSAttributedString *)attributedString:(NSString *)string {
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    CGSize frameSize = CGSizeMake(200, 50);
    UIFont *font = [UIFont boldSystemFontOfSize:14.0];
    CGRect idealFrame3 = [string boundingRectWithSize:frameSize
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{ NSFontAttributeName:font }
                                              context:nil];
    
    if (idealFrame3.size.width>=175)//HARI03-08-2016
    {
        style.lineBreakMode=NSLineBreakByTruncatingTail;
        style.firstLineHeadIndent = 10.0f;
        
    }else
    {
        style.tailIndent = 10.0f;
        style.firstLineHeadIndent = 10.0f;
        style.headIndent = 10.0f;
    }
    NSDictionary *attributes = @{
                                 NSParagraphStyleAttributeName  : style,
                                 NSFontAttributeName            : [UIFont boldSystemFontOfSize:14.0]
                                 };
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:string
                                                                         attributes:attributes];
    return attributedText;
}

@end
