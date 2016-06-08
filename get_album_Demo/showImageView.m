//
//  showImageView.m
//  get_album_Demo
//
//  Created by zhangzhihua on 16/4/13.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "showImageView.h"

#define BUTTON_SIZE 25.f

#define BUTTON_ANIMATION_SCALE 1.3f

#define BUTTON_ANIMATION_DURATION 0.1f

@implementation showImageView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self addamplify];
        self.userInteractionEnabled = YES;
        self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.selectButton.selected = NO;
        [self.selectButton addTarget:self action:@selector(selectButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self.selectButton setBackgroundImage:[UIImage imageNamed:@"selete@2x.png"] forState:UIControlStateNormal];
        [self.selectButton setBackgroundImage:[UIImage imageNamed:@"seleted@2x.png"] forState:UIControlStateSelected];
        [self addSubview:self.selectButton];
    }
    return self;
}

-(void)selectButtonMethod:(UIButton*)sender {
    showImageView *selectView = (showImageView*)[sender superview];
    [self.delegate selecttheImageViewMethod:selectView.tag and:!sender.selected];
    if(![self.delegate orCanClick]&&!sender.selected)return;
    sender.selected = !sender.selected;
    if(sender.selected){
        [UIView animateWithDuration:BUTTON_ANIMATION_DURATION animations:^{
            sender.transform =CGAffineTransformScale(sender.transform, BUTTON_ANIMATION_SCALE, BUTTON_ANIMATION_SCALE);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:BUTTON_ANIMATION_DURATION animations:^{
                sender.transform=CGAffineTransformIdentity;
            }];
        }];
    }
}

-(void)setframe:(CGRect)frame {
    self.frame = frame;
    self.selectButton.frame =CGRectMake(self.frame.size.width - 30, 5 , BUTTON_SIZE, BUTTON_SIZE);
}


//添加放大手势
-(void)addamplify {
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap_blow_up:)];
    [self addGestureRecognizer:tap];
}

//放大手势的方法
- (void)tap_blow_up:(UITapGestureRecognizer* )gesture {
    [self.delegate recurrentSelectImageView:self.tag];
}

@end
