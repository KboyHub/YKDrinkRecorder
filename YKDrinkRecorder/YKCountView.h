//
//  YKCountView.h
//  YKDrinkRecorder
//
//  Created by yankang on 2018/5/27.
//  Copyright © 2018年 yankang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKCountView : UIView

@property(nonatomic,assign)IBInspectable NSUInteger  drinkCount;
@property(nonatomic,strong)IBInspectable UIColor  *outLineColor;
@property(nonatomic,strong)IBInspectable UIColor  *countColor;

@end
