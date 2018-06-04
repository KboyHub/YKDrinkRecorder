//
//  YKGraphView.m
//  YKDrinkRecorder
//
//  Created by yankang on 2018/5/27.
//  Copyright © 2018年 yankang. All rights reserved.
//

#import "YKGraphView.h"


#define cornerRadiusSize CGSizeMake(8.0,8.0)
#define margin 20.0
#define topBorder 60
#define bottomBorder 50
#define colorAlpha 0.3
#define circleDiameter 5.0

IB_DESIGNABLE
@implementation YKGraphView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.startColor = [UIColor colorWithRed:250/255.0f green:233/255.0f blue:222/255.0f alpha:1];
        self.endColor = [UIColor colorWithRed:252/255.0f green:79/255.0f blue:8/255.0f alpha:1];
      
    }
    
    return self;
}



- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.startColor = [UIColor colorWithRed:250/255.0f green:233/255.0f blue:222/255.0f alpha:1];
        self.endColor = [UIColor colorWithRed:252/255.0f green:79/255.0f blue:8/255.0f alpha:1];
        self.drinkArray = [NSMutableArray arrayWithObjects:@4, @2, @6, @4, @5, @8, @3, nil];

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //绘图上下文
//***1.绘制圆角矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:cornerRadiusSize];
    [path addClip];
//***2.绘制渐变色
    CGContextRef context = UIGraphicsGetCurrentContext();
    //颜色库
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //要使用的颜色数组
    NSArray *colorArray = @[(id)[self.startColor CGColor],(id)[self.endColor CGColor]];
    //范围
    CGFloat locations[] = {0,1};
    //变化率
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colorArray, locations);
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointMake(0, self.bounds.size.height);
    //线性绘图
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);

//***3.绘制曲线
    UIBezierPath *graphPath = [UIBezierPath bezierPath];
    [graphPath moveToPoint:CGPointMake([self getXPoint:0],[self getYPoint:[self.drinkArray[0] intValue]])];
    for (int i = 0; i<self.drinkArray.count; i++) {
        CGPoint nextPoint =  CGPointMake([self getXPoint:i],[self getYPoint:[self.drinkArray[i] intValue]]);
        [graphPath addLineToPoint:nextPoint];
    }
    [[UIColor whiteColor]setStroke];
    [[UIColor whiteColor]setFill];
    [graphPath stroke];
//***4.绘制曲线下边区域
    CGContextSaveGState(context);//裁剪之前保持状态
    UIBezierPath *clippingGraphPath = [graphPath copy];
    [clippingGraphPath addLineToPoint:CGPointMake([self getXPoint:(int)(self.drinkArray.count-1)],self.bounds.size.height)];
    [clippingGraphPath addLineToPoint:CGPointMake([self getXPoint:0], self.bounds.size.height)];
    [clippingGraphPath closePath];
    [clippingGraphPath addClip];
    [[UIColor greenColor]setFill];
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:rect];
    [rectPath fill];
//***5.绘制曲线下边区域白色渐变
    CGFloat highestYPoint = [self getYPoint:[self getMaxValue]];
    CGPoint graphStartPoint = CGPointMake(margin,highestYPoint);
    CGPoint graphEndPoint = CGPointMake(margin,self.bounds.size.height);
    CGContextDrawLinearGradient(context, gradient, graphStartPoint, graphEndPoint, 0);
    graphPath.lineWidth = 2.0f;
    [graphPath stroke];
    CGContextRestoreGState(context);//裁剪之后释放状态
//***6.绘制各个圆点
    
    for (int i = 0; i<self.drinkArray.count; i++) {
        CGPoint point = CGPointMake([self getXPoint:i],[self getYPoint:[self.drinkArray[i] intValue]]);
        point.x -= circleDiameter/2;
        point.y -= circleDiameter/2;
        [[UIColor whiteColor]setFill];
        [[UIBezierPath bezierPathWithOvalInRect:CGRectMake(point.x,point.y,circleDiameter,circleDiameter)] fill];
    }
//***7.添加三条水平线
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    //最上部线
    [linePath moveToPoint:CGPointMake(margin, topBorder)];
    [linePath addLineToPoint:CGPointMake(self.bounds.size.width-margin, topBorder)];
    //中部线
    [linePath moveToPoint:CGPointMake(margin, self.bounds.size.height - topBorder - bottomBorder)];
    [linePath addLineToPoint:CGPointMake(self.bounds.size.width-margin, self.bounds.size.height - topBorder - bottomBorder)];
    //下部线
    [linePath moveToPoint:CGPointMake(margin, self.bounds.size.height-bottomBorder)];
    [linePath addLineToPoint:CGPointMake(self.bounds.size.width-margin, self.bounds.size.height-bottomBorder)];
    [[[UIColor whiteColor]colorWithAlphaComponent:colorAlpha] setStroke];
    linePath.lineWidth = 1.0;
    [linePath stroke];
    
    
    

    
    

    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

- (CGFloat)getXPoint:(int)column{
    CGFloat graphWidth = self.bounds.size.width-margin*2 -4;
    CGFloat spacing = graphWidth/(self.drinkArray.count-1);
    return column*spacing+margin+2;
}

- (CGFloat)getYPoint:(int)column{
    CGFloat graphHeight = self.bounds.size.height - topBorder - bottomBorder;
    int maxValue = [self getMaxValue];
    CGFloat y = (column) / (CGFloat)(maxValue) * graphHeight;
    return graphHeight+topBorder-y;
}

- (int)getMaxValue{
    int maxValue = [self.drinkArray[0] intValue];
    for (int i = 0; i<self.drinkArray.count; i++) {
        if (maxValue <[self.drinkArray[i] intValue]) {
            maxValue = [self.drinkArray[i] intValue];
        }
    }
    return maxValue;
}




@end
