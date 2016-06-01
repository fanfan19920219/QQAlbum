//
//  showImageView.m
//  get_album_Demo
//
//  Created by zhangzhihua on 16/4/13.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "showImageView.h"
#import "amplifyViewController.h"
#define BUTTON_SIZE 25.f

@implementation showImageView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self addamplify];
        self.userInteractionEnabled = YES;
        self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.selectButton.backgroundColor = [UIColor redColor];
        self.selectButton.selected = NO;
        [self.selectButton addTarget:self action:@selector(selectButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self.selectButton setBackgroundImage:[UIImage imageNamed:@"selete@2x.png"] forState:UIControlStateNormal];
        [self.selectButton setBackgroundImage:[UIImage imageNamed:@"seleted@2x.png"] forState:UIControlStateSelected];
//        [self.selectButton setTitle:@"y" forState:UIControlStateSelected];
        [self addSubview:self.selectButton];
    }
    return self;
}

-(void)selectButtonMethod:(UIButton*)sender {
    sender.selected = !sender.selected;
    showImageView *selectView = (showImageView*)[sender superview];
    NSLog(@"select---tag --- %ld",(long)selectView.tag);
    [self.delegate selecttheImageViewMethod:selectView.tag and:sender.selected];
    if(sender.selected){
        [UIView animateWithDuration:0.1 animations:^{
            sender.frame = CGRectMake(self.frame.size.width - 27.5, 2.5, BUTTON_SIZE + 5, BUTTON_SIZE +5);
        } completion:^(BOOL finished) {
            sender.frame = CGRectMake(self.frame.size.width - 30, 5, BUTTON_SIZE, BUTTON_SIZE);
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
