//
//  ZHH_getAlbumRootViewController.m
//  get_album_Demo
//
//  Created by zhangzhihua on 16/5/31.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "ZHH_getAlbumRootViewController.h"
#import "ZHH_getAlbumToolViewController.h"
#import "showListViewController.h"
@implementation ZHH_getAlbumRootViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    showListViewController *showListVC = [[showListViewController alloc]init];
    ZHH_getAlbumToolViewController *zhh = [[ZHH_getAlbumToolViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:showListVC];
    nav.view.frame = self.view.frame;
    [self addChildViewController:nav];
    [self.view addSubview:nav.view];
    zhh.delegate =  showListVC;
    showListVC.title = @"相册";
    [nav pushViewController:zhh animated:NO];
}
@end
