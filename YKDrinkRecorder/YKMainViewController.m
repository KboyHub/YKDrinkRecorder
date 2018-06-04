//
//  YKMainViewController.m
//  YKDrinkRecorder
//
//  Created by yankang on 2018/5/27.
//  Copyright © 2018年 yankang. All rights reserved.
//

#import "YKMainViewController.h"
#import "YKCountView.h"
#import "YKGraphView.h"
#import "YKMedalDrawing.h"

@interface YKMainViewController ()
@property (weak, nonatomic) IBOutlet YKCountView *countView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet YKGraphView *graphView;
@property(weak,nonatomic)IBOutlet UILabel  *averageWaterDrunk;
@property(weak,nonatomic)IBOutlet UILabel  *maxLabel;
@property(weak,nonatomic)IBOutlet UIStackView  *stackView;

@property (weak, nonatomic) IBOutlet YKMedalDrawing *medalView;

@property(nonatomic,assign)BOOL  isShowGraphView;

@end

@implementation YKMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isShowGraphView = NO;
    [self.countView addObserver:self forKeyPath:@"drinkCount" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self checkTotal];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ((NSInteger)change[@"new"]<9||(NSInteger)change[@"new"]>0) {
        [self.countView setNeedsDisplay];
    }
}

- (IBAction)addDrinkCount:(UIButton *)sender {
    if (self.isShowGraphView) {
        return;
    }
    if (self.countView.drinkCount<8) {
        self.countView.drinkCount +=1;
    }
    [self checkTotal];
    self.countLabel.text = [NSString stringWithFormat:@"%lu",self.countView.drinkCount];
}
- (IBAction)reduceDrinkCount:(UIButton *)sender {
    if (self.isShowGraphView) {
        return;
    }
    if (self.countView.drinkCount>0) {
        self.countView.drinkCount -=1;
    }
    [self checkTotal];
    self.countLabel.text = [NSString stringWithFormat:@"%lu",self.countView.drinkCount];
}

- (IBAction)tapContainterView:(UITapGestureRecognizer *)sender {
    if (!self.isShowGraphView) {
        //显示绘图
        [UIView transitionFromView:self.countView toView:self.graphView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight|UIViewAnimationOptionShowHideTransitionViews completion:nil];
          self.graphView.drinkArray = [NSMutableArray arrayWithObjects:@4, @2, @6, @4, @5, @8, @3, nil];
        [self setGraphViewDisplay];
    }else{
        //隐藏绘图
        [UIView transitionFromView:self.graphView toView:self.countView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft|UIViewAnimationOptionShowHideTransitionViews completion:nil];
    }
    self.isShowGraphView = !self.isShowGraphView;

}

- (void)setGraphViewDisplay{
    NSUInteger maxDayIndex = self.stackView.arrangedSubviews.count-1;
    [self.graphView.drinkArray replaceObjectAtIndex:self.graphView.drinkArray.count-1 withObject:[NSNumber numberWithUnsignedInteger:self.countView.drinkCount]];
    [self.graphView setNeedsDisplay];
    self.maxLabel.text = [NSString stringWithFormat:@"%d",[self.graphView getMaxValue]];
    NSUInteger totalGlasses = 0;
    for (int i = 0; i<self.graphView.drinkArray.count; i++) {
        totalGlasses +=[self.graphView.drinkArray[i] integerValue];
    }
    NSUInteger average = totalGlasses/self.graphView.drinkArray.count;
    self.averageWaterDrunk.text =[NSString stringWithFormat:@"%lu",average];
    
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setLocalizedDateFormatFromTemplate:@"EEEEE"];
    for (NSInteger i = 0; i<maxDayIndex+1; i++) {
        NSDateComponents *components = [[NSDateComponents alloc]init];
        [components setValue:-i forComponent:NSCalendarUnitDay];
         NSDate *date = [calendar dateByAddingComponents:components toDate:today options:0];
        UILabel *label = self.stackView.arrangedSubviews[maxDayIndex-i];
        label.text = [formatter stringFromDate:date];
    }
}

- (void)checkTotal{
    if (self.countView.drinkCount >= 8) {
        [self.medalView showMedal:YES];
    }else{
        [self.medalView showMedal:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [self.countView removeObserver:self forKeyPath:@"drinkCount"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
