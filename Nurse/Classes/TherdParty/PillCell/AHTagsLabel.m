//
//  AHTagsLabel.m
//  AutomaticHeightTagTableViewCell
//
//  Created by WEI-JEN TU on 2016-07-16.
//  Copyright © 2016 Cold Yam. All rights reserved.
//

#import "AHTagsLabel.h"
#import "AHTagView.h"

@implementation AHTagsLabel
@synthesize isFromBooking;
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        //[self setupGesture];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
   // [self setupGesture];
}

- (void)setup {
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.textAlignment = NSTextAlignmentLeft;
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
}
- (void)setupGesture {
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(tap:)];
    [self addGestureRecognizer:recognizer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)tap:(UITapGestureRecognizer *)recognizer {
   /* UILabel *label = (UILabel *)recognizer.view;
    CGSize labelSize = recognizer.view.bounds.size;
    
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:labelSize];
    container.lineFragmentPadding = 0.0;
    container.lineBreakMode = label.lineBreakMode;
    container.maximumNumberOfLines = label.numberOfLines;
    
    NSLayoutManager *manager = [NSLayoutManager new];
    [manager addTextContainer:container];
    
    NSTextStorage *storage = [[NSTextStorage alloc] initWithAttributedString:label.attributedText];
    [storage addLayoutManager:manager];
    
    CGRect rect = [manager usedRectForTextContainer:container];
    CGPoint offset = CGPointMake((labelSize.width - rect.size.width)/2 - rect.origin.x,
                                 (labelSize.height - rect.size.height)/2 - rect.origin.y);
    CGPoint touchPoint = [recognizer locationInView:label];
    CGPoint point = CGPointMake(touchPoint.x - offset.x, touchPoint.y - offset.y);
    NSInteger indexOfCharacter = [manager characterIndexForPoint:point
                                                 inTextContainer:container
                        fractionOfDistanceBetweenInsertionPoints:nil];

    AHTag *tag = _tags[indexOfCharacter];
    NSNumber *enabled = tag.enabled;
    tag.enabled = [NSNumber numberWithBool:!enabled.boolValue];
    [self setTags:_tags];*/
}

#pragma mark - Tags setter

- (void)setTags:(NSArray *)tags
{
//    _tags = tags;
    
    UITableViewCell *cell = [UITableViewCell new];
    NSMutableAttributedString *string = [NSMutableAttributedString new];
    
    
    NSInteger k = 0;
    for (NSInteger i = 0; i < [tags count]; i++)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIColor *randColor;
        if (k== 0)
        {
            randColor = [UIColor colorWithRed:88.0f/255.0f green:86.0f/255.0f blue:214.0f/255.0f alpha:1.0f];
        }
        else if (k== 1)
        {
            randColor = [UIColor colorWithRed:255/255.0f green:172/255.0f blue:95/255.0f alpha:1.0f];
        }
        else if (k== 2)
        {
            randColor = [UIColor colorWithRed:157/255.0f green:192/255.0f blue:46/255.0f alpha:1.0f];
        }
        else if (k== 3)
        {
            randColor = [UIColor colorWithRed:254/255.0f green:100/255.0f blue:143/255.0f alpha:1.0f];
        }
        else if (k== 4)
        {
            randColor = [UIColor colorWithRed:122/255.0f green:204/255.0f blue:200/255.0f alpha:1.0f];
        }
        else if (k== 5)
        {
            randColor = [UIColor colorWithRed:221/255.0f green:120/255.0f blue:252/255.0f alpha:1.0f];
        }
        else if (k== 6)
        {
            randColor = [UIColor colorWithRed:142/255.0f green:142/255.0f blue:147/255.0f alpha:1.0f];
        }
        else if (k== 7)
        {
            randColor = [UIColor colorWithRed:26/255.0f green:213/255.0f blue:154/255.0f alpha:1.0f];
        }
        else if (k== 8)
        {
            randColor = [UIColor colorWithRed:214/255.0f green:145/255.0f blue:253/255.0f alpha:1.0f];
        }
        else if (k== 9)
        {
            randColor = [UIColor colorWithRed:153/255.0f green:102/255.0f blue:204/255.0f alpha:1.0f];
        }
        
        if (k == 9)
        {
            k = 0;
        }
        else
        {
            k++;
        }

        NSString *title ;
        if (isFromBooking)
        {
            title = [tags objectAtIndex:i];
        }
        else
        {
            title = [[[tags objectAtIndex:i] valueForKey:@"hotel_services"]  valueForKey:@"service_name"];
        }
        
        UIColor *color = randColor;
        
        NSNumber *enabled = [NSNumber numberWithBool:YES];
        color = enabled.boolValue == YES ? color : [UIColor clearColor];
        
        AHTagView *view = [AHTagView new];
        view.label.attributedText = [AHTagsLabel attributedString:title];
        view.label.backgroundColor = color;
        if (isFromBooking)
        {
             view.backgroundColor = [UIColor whiteColor];
        }
        else
        {
             view.backgroundColor = [UIColor whiteColor];
        }
       
        
        CGSize size = [view systemLayoutSizeFittingSize:view.frame.size
                          withHorizontalFittingPriority:UILayoutPriorityFittingSizeLevel
                                verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
        
       
        
        view.frame = CGRectMake(0, 0, size.width+20, size.height);
        
        if (cell.frame.size.width > view.frame.size.width)
        {
            
        }
        else
        {
            view.frame = CGRectMake(0, 0, cell.frame.size.width-15, size.height);
        }
        [cell.contentView addSubview:view];
        
        UIImage *image = view.image;
        NSTextAttachment *attachment = [NSTextAttachment new];
        attachment.image = image;
        
        NSAttributedString *attrStr = [NSAttributedString attributedStringWithAttachment:attachment];
        [string appendAttributedString:attrStr];
    }
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 2;
  
    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    
    self.attributedText = string;
    
    if (tags.count == 0)
    {
        if (isFromBooking)
        {
             self.textColor =[UIColor blackColor];
            // self.backgroundColor = [UIColor clearColor];
        }
        else
        {
             self.textColor =[UIColor blackColor];
        }
        self.text = @"No Specialization Found";
       
        self.textAlignment = NSTextAlignmentCenter;
    }
    
    if (isFromBooking)
    {
       // self.textColor =[UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
    }
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
