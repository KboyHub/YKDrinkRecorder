//
//  YKGraphView.h
//  YKDrinkRecorder
//
//  Created by yankang on 2018/5/27.
//  Copyright © 2018年 yankang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKGraphView : UIView

@property(nonatomic,strong)IBInspectable UIColor  *startColor;

@property(nonatomic,strong)IBInspectable UIColor  *endColor;

@property(nonatomic,strong)NSMutableArray  *drinkArray;

- (int)getMaxValue;

@end
