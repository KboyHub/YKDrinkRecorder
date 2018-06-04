//
//  YKPushButton.m
//  YKDrinkRecorder
//
//  Created by yankang on 2018/5/27.
//  Copyright © 2018年 yankang. All rights reserved.
//

#import "YKPushButton.h"

#define plusLineWidth 2.5
#define plusWidthScale 0.8
#define halfPointSexl 0.5
#define halfWidth self.bounds.size.width/2
#define halfHeight self.bounds.size.height/2




@interface YKPushButton ()



@end

IB_DESIGNABLE
@implementation YKPushButton


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.fillColor = [UIColor greenColor];
        self.isPlus = YES;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.fillColor = [UIColor greenColor];
        self.isPlus = YES;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *plusPath = [UIBezierPath bezierPath];
    [plusPath addArcWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:MIN(self.bounds.size.width/2, self.bounds.size.height/2) startAngle:0 endAngle:2*M_PI clockwise:YES];
    [self.fillColor setFill];
    [plusPath fill];
    CGFloat plusWidth = MIN(halfWidth, halfHeight)*plusWidthScale;
    CGFloat halfPlusWidth = plusWidth/2;
    CGPoint startPoint = CGPointMake(halfWidth-halfPlusWidth+halfPointSexl, halfHeight+halfPointSexl);
    CGPoint endPoint = CGPointMake(startPoint.x+plusWidth+halfPointSexl, halfHeight+halfPointSexl);
    [plusPath moveToPoint:startPoint];
    [plusPath addLineToPoint:endPoint];
    plusPath.lineWidth = plusLineWidth;
    [[UIColor whiteColor]setStroke];
    [plusPath stroke];
    if (self.isPlus) {
        [plusPath moveToPoint:CGPointMake(halfWidth+halfPointSexl, halfHeight-halfPlusWidth+halfPointSexl)];
        [plusPath addLineToPoint:CGPointMake(halfWidth+halfPointSexl, halfHeight-halfPlusWidth+halfPointSexl+plusWidth)];
        [plusPath stroke];
    }
    
}


@end
