//
//  LSAnimationView.m
//  LSAnimationDemo
//
//  Created by Liusui on 16/8/29.
//  Copyright © 2016年 Liusui. All rights reserved.
//

#import "LSAnimationView.h"
static NSInteger const row = 5;
@implementation LSAnimationView{
    int _i;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    _i = 0;
    [self setAnimation];
}

- (void)setAnimation{
    if (_i == row) {
        for (UIView *view in self.subviews) {
            [view.layer addAnimation:[self animationWithOpacityFrom:1 To:0 Duration:1.1 BeginTime:0] forKey:@"animation"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [view removeFromSuperview];
            });
        }
        _i = 0;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UILabel *label = [self listLabel];
        [label setFrame:CGRectMake(10, 10 + _i * 40, 250, 30)];
        label.alpha = 1;
        [self addSubview:label];
        [label.layer addAnimation:[self animationWithOpacityFrom:0.0 To:1.0 Duration:1 BeginTime:1] forKey:@"animation"];
        _i ++;
        [self setAnimation];
    });
}

- (UILabel *)listLabel{
    UILabel *label = [[UILabel alloc]init];
    label.text = @"不到卡上的哈是多哈是多哈上的挥洒的";
    label.font = [UIFont systemFontOfSize:14];
    return label;
}

- (CAAnimation *)animationWithOpacityFrom:(CGFloat) from To:(CGFloat) to Duration:(CGFloat) duration BeginTime:(CGFloat)beginTime{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = duration;
    animation.repeatCount = 0;
    animation.fromValue = [NSNumber numberWithFloat:from];
    animation.toValue = [NSNumber numberWithFloat:to];
    return animation;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
