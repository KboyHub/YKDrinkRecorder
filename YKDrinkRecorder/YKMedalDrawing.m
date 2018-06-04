//
//  YKMedalDrawing.m
//  YKDrinkRecorder
//
//  Created by yankang on 2018/6/4.
//  Copyright © 2018年 yankang. All rights reserved.
//

#import "YKMedalDrawing.h"

@implementation YKMedalDrawing


- (void)showMedal:(BOOL)show{
    self.image = show==YES?[self createMedalImage]:nil;
}

- (UIImage *)createMedalImage{
    CGSize imageSize = CGSizeMake(120, 200);
    UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *darkGoldColor = [UIColor colorWithRed:0.6 green:0.5 blue:0.15 alpha:1.0];
    UIColor *midGoldColor = [UIColor colorWithRed:0.86 green:0.73 blue:0.3 alpha:1.0];
    UIColor *lightGoldColor = [UIColor colorWithRed:1.0 green:0.98 blue:0.9 alpha:1.0];

    UIColor *shadow = [[UIColor blueColor]colorWithAlphaComponent:0.80];
    CGSize shadowOffset = CGSizeMake(2.0, 2.0);
    CGFloat shadowradius = 5.0;
    
    CGContextSetShadowWithColor(context, shadowOffset, shadowradius,shadow.CGColor);
    CGContextBeginTransparencyLayer(context, nil);

    //红带
    UIBezierPath *lowerRibbonPath = [UIBezierPath bezierPath];
    [lowerRibbonPath moveToPoint:CGPointMake(0, 0)];
    [lowerRibbonPath addLineToPoint:CGPointMake(40, 0)];
    [lowerRibbonPath addLineToPoint:CGPointMake(78, 70)];
    [lowerRibbonPath addLineToPoint:CGPointMake(38, 70)];
    [lowerRibbonPath closePath];
    [[UIColor redColor]setFill];
    [lowerRibbonPath fill];
    
    //扣环
    UIBezierPath *claspPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(36, 62, 43, 20) cornerRadius:5];
    claspPath.lineWidth = 5.0;
    [darkGoldColor setStroke];
    [claspPath stroke];
    
    //奖章
    UIBezierPath *medallionPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(8, 72, 100, 100)];
    CGContextSaveGState(context);
    [medallionPath addClip];
    //渐变色
    NSArray *colorArray = @[(id)[darkGoldColor CGColor],(id)[midGoldColor CGColor],(id)[lightGoldColor CGColor]];
    CGFloat locations[] = {0,0.51,1};
    CGGradientRef gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), (__bridge CFArrayRef)colorArray, locations);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(40, 40), CGPointMake(100, 160), 0);
    CGContextRestoreGState(context);

#warning 有问题b
    CGAffineTransform transform = CGAffineTransformMakeScale(0.8, 0.8);
    CGAffineTransformTranslate(transform, 15, 30);
    medallionPath.lineWidth = 2.0;
    
    [medallionPath applyTransform:transform];
    [medallionPath stroke];
    
    //蓝带
    UIBezierPath * upperRibbonPath = [UIBezierPath bezierPath];
    [upperRibbonPath moveToPoint:CGPointMake(68, 0)];
    [upperRibbonPath addLineToPoint:CGPointMake(108, 0)];
    [upperRibbonPath addLineToPoint:CGPointMake(78, 70)];
    [upperRibbonPath addLineToPoint:CGPointMake(38, 70)];
    [upperRibbonPath closePath];
    
    [[UIColor blueColor]setFill];
    [upperRibbonPath fill];
    
    //数字
    NSString *numberOne = @"1";
    CGRect numberOneRect = CGRectMake(47, 100, 50, 50);
    UIFont *font = [UIFont fontWithName:@"Academy Engraved LET" size:60];
    NSDictionary *numberOneAttributes = @{NSFontAttributeName:font,NSForegroundColorAttributeName:darkGoldColor};
    [numberOne drawInRect:numberOneRect withAttributes:numberOneAttributes];
    
    CGContextEndTransparencyLayer(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
