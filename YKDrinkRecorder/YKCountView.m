//
//  YKCountView.m
//  YKDrinkRecorder
//
//  Created by yankang on 2018/5/27.
//  Copyright © 2018年 yankang. All rights reserved.
//

#import "YKCountView.h"

#define numberOfGlasses 8
#define LineWidth 5.0
#define arcWidthScale 0.6
#define halfWidth self.bounds.size.width/2
#define halfHeight self.bounds.size.height/2

IB_DESIGNABLE
@implementation YKCountView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.outLineColor = [UIColor blueColor];
        self.countColor = [UIColor orangeColor];
        self.drinkCount = 0;
    }
    
    return self;
}



- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.outLineColor = [UIColor blueColor];
        self.countColor = [UIColor orangeColor];
        self.drinkCount = 0;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *countPath = [UIBezierPath bezierPath];
    CGPoint centPoint = CGPointMake(halfWidth,halfHeight);
    CGFloat radius = MAX(halfWidth,halfHeight);
    CGFloat startAngle = 3*M_PI/4;
    CGFloat endAngle = M_PI/4;
    CGFloat arcWidth = radius*arcWidthScale;
    countPath.lineWidth = arcWidth;
    [countPath addArcWithCenter:centPoint radius:radius-arcWidth/2 startAngle:startAngle endAngle:endAngle clockwise:YES];
    [self.countColor setStroke];
    [countPath stroke];
    
    
    UIBezierPath *outLinePath = [UIBezierPath bezierPath];
    CGFloat angleDiffience = 2*M_PI -startAngle +endAngle;
    CGFloat arcLengthPerClass = angleDiffience/(CGFloat)numberOfGlasses;
    CGFloat outLineEndAngle = arcLengthPerClass*self.drinkCount+startAngle;
    [outLinePath addArcWithCenter:centPoint radius:halfWidth-LineWidth/2 startAngle:startAngle endAngle:outLineEndAngle clockwise:YES];
    [outLinePath addArcWithCenter:centPoint radius:radius-arcWidth+LineWidth/2 startAngle:outLineEndAngle endAngle:startAngle clockwise:NO];
    [outLinePath closePath];
    [self.outLineColor setStroke];
    outLinePath.lineWidth = LineWidth;
    [outLinePath stroke];
    
    //***绘制刻度
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [self.outLineColor setFill];
    CGFloat markerWidth = 5.0f;
    CGFloat markerSize = 10.0f;
    UIBezierPath *markerPath = [UIBezierPath bezierPathWithRect:CGRectMake(-markerWidth/2, 0, markerWidth, markerSize)];
    CGContextTranslateCTM(context, rect.size.width/2, rect.size.height/2);
    for (int i = 0; i<numberOfGlasses; i++) {
        CGContextSaveGState(context);
        CGFloat angle =arcLengthPerClass *i +startAngle - M_PI/2;
        CGContextRotateCTM(context, angle);
        CGContextTranslateCTM(context, 0, rect.size.height/2-markerSize);
        [markerPath fill];
        CGContextRestoreGState(context);
    }
    CGContextRestoreGState(context);

}


@end
