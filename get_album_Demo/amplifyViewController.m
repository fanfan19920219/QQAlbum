//
//  amplifyViewController.m
//  get_album_Demo
//
//  Created by zhangzhihua on 16/4/14.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "amplifyViewController.h"

@implementation amplifyViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    //创建show View
    [self create_showView];
    
}

-(void)create_showView{
    [self.view addSubview:_showImageView];
    NSLog(@"showImageView --- %@",_showImageView);
}

@end
