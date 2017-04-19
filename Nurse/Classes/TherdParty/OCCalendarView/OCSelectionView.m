//
//  OCSelectionView.m
//  OCCalendar
//
//  Created by Oliver Rickard on 3/30/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "OCSelectionView.h"

@implementation OCSelectionView
@synthesize selectionMode = _selectionMode;
@synthesize selected;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        selected = NO;
        startCellX = -1;
        startCellY = -1;
        endCellX = -1;
        endCellY = -1;
        
		hDiff = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 41 : 43;
        vDiff = 30;
        
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (BOOL) selected {
    return selected;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if(selected)
    {
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = UIGraphicsGetCurrentContext();
        
       
        
        UIColor* darkColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.72];
        
        UIColor* color = [UIColor clearColor];// [UIColor colorWithRed: 180.0/255.0 green: 46.0/255.0 blue: 218.0/255.0 alpha: 0.86];
        
        UIColor* color2 = [UIColor clearColor];//[UIColor colorWithRed: 180.0/255.0 green: 46.0/255.0 blue: 218.0/255.0 alpha: 0.88];
        NSArray* gradient3Colors = [NSArray arrayWithObjects: 
                                    (id)color.CGColor, 
                                    (id)color2.CGColor, nil];
        CGFloat gradient3Locations[] = {0, 1};
        CGGradientRef gradient3 = CGGradientCreateWithColors(colorSpace, (CFArrayRef)gradient3Colors, gradient3Locations);
        
        int tempStart = MIN(startCellY, endCellY);
        int tempEnd = MAX(startCellY, endCellY);
        for(int i = tempStart; i <= tempEnd; i++) {
            //// selectedRect Drawing
            int thisRowEndCell = 0;
            int thisRowStartCell;
            if(startCellY == i) {
                thisRowStartCell = startCellX;
                if (startCellY > endCellY)
                {
                    thisRowStartCell = 0; thisRowEndCell = startCellX;
                }
            } else {
                thisRowStartCell = 0;
            }
            
            if(endCellY == i) {
                thisRowEndCell = endCellX;
                
                if (startCellY > endCellY) {
                    thisRowStartCell = endCellX; thisRowEndCell = 6;
                }
            } else if (!(startCellY > endCellY)) {
                thisRowEndCell = 6;
            }
            CGFloat cornerRadius;
            if(_selectionMode == OCSelectionSingleDate) {
                cornerRadius = 0.0;
            } else {
                cornerRadius = 0.0;
            }
			float width_offset= UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 25 : 20;
            UIBezierPath* selectedRectPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(MIN(thisRowStartCell, thisRowEndCell)*hDiff, i*vDiff, (ABS(thisRowEndCell-thisRowStartCell))*hDiff+width_offset, 21) cornerRadius: cornerRadius];
            CGContextSaveGState(context);
//            [selectedRectPath addClip];
            CGContextDrawLinearGradient(context, gradient3, CGPointMake((MIN(thisRowStartCell, thisRowEndCell)+.5)*hDiff, (i+1)*vDiff), CGPointMake((MIN(thisRowStartCell, thisRowEndCell)+.5)*hDiff, i*vDiff), 0);
            CGContextRestoreGState(context);
            
            CGContextSaveGState(context);
            [darkColor setStroke];
            selectedRectPath.lineWidth = 0.5;
            [selectedRectPath stroke];
            CGContextRestoreGState(context);
        }
        
        CGGradientRelease(gradient3);
        CGColorSpaceRelease(colorSpace);
    }
}

-(void) singleSelection:(NSSet *)touches {
   
    
    
    self.selected = YES;
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    startCellX = MIN((int)(point.x)/hDiff,6);
    startCellY = (int)(point.y)/vDiff;
    
    endCellX = MIN(startCellX,6);
    endCellY = startCellY;
    [self setNeedsDisplay];
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self singleSelection:touches];
    [self performSelector:@selector(DateDone) withObject:nil afterDelay:.2];
    
    
}
-(void)DateDone
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DateDone" object:nil];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if(_selectionMode == OCSelectionSingleDate) {
        [self singleSelection:touches];
        return;
    }
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    if(CGRectContainsPoint(self.bounds, point)) {
        endCellX = MIN((int)(point.x)/hDiff,6);
        endCellY = (int)(point.y)/vDiff;
        
        [self setNeedsDisplay];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(_selectionMode == OCSelectionSingleDate) {
        [self singleSelection:touches];
        return;
    }
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    if(CGRectContainsPoint(self.bounds, point)) {
        endCellX = MIN((int)(point.x)/hDiff,6);
        endCellY = (int)(point.y)/vDiff;
        
        [self setNeedsDisplay];
    }
}

-(void)resetSelection {
    startCellX = -1;
    startCellY = -1;
    endCellY = -1;
    endCellX = -1;
    selected = NO;
    [self setNeedsDisplay];
}

-(CGPoint)startPoint {
    return CGPointMake(startCellX, startCellY);
}

-(CGPoint)endPoint {
    return CGPointMake(endCellX, endCellY);
}

-(void)setStartPoint:(CGPoint)sPoint {
    startCellX = sPoint.x;
    startCellY = sPoint.y;
    selected = YES;
    [self setNeedsDisplay];
}

-(void)setEndPoint:(CGPoint)ePoint {
    endCellX = ePoint.x;
    endCellY = ePoint.y;
    selected = YES;
    [self setNeedsDisplay];
}

@end