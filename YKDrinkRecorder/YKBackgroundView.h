//
//  YKBackgroundView.h
//  YKDrinkRecorder
//
//  Created by yankang on 2018/6/2.
//  Copyright © 2018年 yankang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKBackgroundView : UIView

@property(nonatomic,strong)IBInspectable UIColor  *lightColor;
@property(nonatomic,strong)IBInspectable UIColor  *darkColor;
@property(nonatomic,assign)IBInspectable CGFloat  patternSize;

@end
