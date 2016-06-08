//
//  ZZH_AnimationTool.m
//  ZZH_AnimationProject
//
//  Created by zhangzhihua on 16/6/2.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "ZZH_AnimationTool.h"
#define DEFAULT_TIME 1.5f

@interface ZZH_AnimationTool () {
    UIView *_animationView;
    CGPoint toPoint;
    CGRect  toRect;
}
@end


@implementation ZZH_AnimationTool

static ZZH_AnimationTool *zzh;
+(instancetype)Default{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zzh = [[ZZH_AnimationTool alloc]init];
    });
    return zzh;
}

//  CenterAnimation
-(void)setviewCenter_FromValue:(CGPoint)fromValue toValue:(CGPoint)toValue moveView:(UIView*)moveView Durationtime:(double)durationtime{
    self.status = ANIMATIONSTYLEMOVECENTER;
    _animationView = moveView;
    //获得一个动画对象
    CABasicAnimation* basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"position";
    basicAnimation.fromValue = [NSValue valueWithCGPoint:fromValue];
    basicAnimation.toValue = [NSValue valueWithCGPoint:toValue];
    basicAnimation.duration = durationtime;
    //layer 停留在动画结束的位置
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.delegate = self;
    //定义动画效果
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //添加动画
    [moveView.layer addAnimation:basicAnimation forKey:@"centerAnimation"];
//    [CATransaction setDisableActions:NO];//设置是否启动隐式动画
    toPoint = toValue;
}

//  BoundsAnimation
-(void)setviewSize_FromValue:(CGRect)fromValue toValue:(CGRect)toValue moveView:(UIView*)moveView Durationtime:(double)durationtime{
    self.status = ANIMATIONSTYLECHANGESIZE;
    _animationView = moveView;
    //获得一个动画对象
    CABasicAnimation* basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"bounds";
    basicAnimation.fromValue = [NSValue valueWithCGRect:fromValue];
    basicAnimation.toValue = [NSValue valueWithCGRect:toValue];
    basicAnimation.duration = durationtime;
    //layer 停留在动画结束的位置
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.delegate = self;
    //定义动画效果
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //添加动画
    [moveView.layer addAnimation:basicAnimation forKey:@"boundsAnimation"];
    //    [CATransaction setDisableActions:NO];//设置是否启动隐式动画
    toRect = toValue;
}

//  CenterAndBoundsAnimation
-(void)setviewSizeAndCenter_FromBounds:(CGRect)fromBounds toBounds:(CGRect)toBounds FromCenter:(CGPoint)fromeCenter toCenter:(CGPoint)toCenter moveView:(UIView*)moveView Durationtime:(double)durationtime{
    self.status = ANIMATIONSTYLEMOVECENTERANDCHANGESIZE;
    _animationView = moveView;
    
    //可以同时执行多个动画，组装多个动画同时执行
    CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
    //center
    CABasicAnimation* basicAnimationCenter = [CABasicAnimation animation];
    basicAnimationCenter.keyPath = @"position";
    basicAnimationCenter.fromValue = [NSValue valueWithCGPoint:fromeCenter];
    basicAnimationCenter.toValue = [NSValue valueWithCGPoint:toCenter];
    //定义动画效果
    basicAnimationCenter.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //bounds
    CABasicAnimation* basicAnimationBounds = [CABasicAnimation animation];
    basicAnimationBounds.keyPath = @"bounds";
    basicAnimationBounds.fromValue = [NSValue valueWithCGRect:fromBounds];
    basicAnimationBounds.toValue = [NSValue valueWithCGRect:toBounds];
    //定义动画效果
    basicAnimationBounds.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    //可以组装任意多个
    animationGroup.animations = @[basicAnimationCenter, basicAnimationBounds];
    
    animationGroup.duration = durationtime;
    animationGroup.delegate= self;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    
    //[animationGroup setAutoreverses:YES];设置是否返回
    [moveView.layer addAnimation:animationGroup forKey:@"BoundsAndCenterAnimationGroup"];
    
    
    toPoint = toCenter;
    toRect = toBounds;
}

- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"动画开始了");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        NSLog(@"动画执行完毕");
        switch (self.status) {
            case ANIMATIONSTYLECHANGESIZE:{
                _animationView.bounds = toRect;
            }break;
            case ANIMATIONSTYLEMOVECENTER:{
                _animationView.center = toPoint;
            }break;
            case ANIMATIONSTYLEMOVECENTERANDCHANGESIZE:{
                _animationView.center = toPoint;
                _animationView.bounds = toRect;
            }break;
            default:
                break;
        }
    } else {
        NSLog(@"动画被打断");
    }
}

@end
