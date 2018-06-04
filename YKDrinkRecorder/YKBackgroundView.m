//
//  YKBackgroundView.m
//  YKDrinkRecorder
//
//  Created by yankang on 2018/6/2.
//  Copyright © 2018年 yankang. All rights reserved.
//

#import "YKBackgroundView.h"


@interface YKBackgroundView ()

@end

IB_DESIGNABLE
@implementation YKBackgroundView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.lightColor = [UIColor orangeColor];
        self.darkColor = [UIColor yellowColor];
        self.patternSize = 200.0f;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.lightColor = [UIColor orangeColor];
        self.darkColor = [UIColor yellowColor];
        self.patternSize = 200.0f;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.darkColor.CGColor);
    CGContextFillRect(context, rect);
    
    CGSize drawSize = CGSizeMake(self.patternSize, self.patternSize);
   
    UIGraphicsBeginImageContextWithOptions(drawSize, YES, 0.0);
    CGContextRef drawContext = UIGraphicsGetCurrentContext();
    [self.darkColor setFill];
    
    CGContextFillRect(drawContext, CGRectMake(0, 0, drawSize.width, drawSize.height));
    
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint:CGPointMake(drawSize.width/2, 0)];
    [trianglePath addLineToPoint:CGPointMake(0, drawSize.height/2)];
    [trianglePath addLineToPoint:CGPointMake(drawSize.width, drawSize.height/2)];
    
    [trianglePath moveToPoint:CGPointMake(0, drawSize.height/2)];
    [trianglePath addLineToPoint:CGPointMake(drawSize.width/2, drawSize.height)];
    [trianglePath addLineToPoint:CGPointMake(0, drawSize.height)];
    
    [trianglePath moveToPoint:CGPointMake(drawSize.width, drawSize.height/2)];
    [trianglePath addLineToPoint:CGPointMake(drawSize.width/2, drawSize.height)];
    [trianglePath addLineToPoint:CGPointMake(drawSize.width, drawSize.height)];
    
    [self.lightColor setFill];
    [trianglePath fill];
    

    UIImage *image =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [[UIColor colorWithPatternImage:image]setFill];
    CGContextFillRect(context, rect);
}


@end
