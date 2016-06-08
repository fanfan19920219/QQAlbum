//
//  ZZH_getAlbumRootViewController.m
//  get_album_Demo
//
//  Created by zhangzhihua on 16/5/31.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "ZZH_getAlbumRootViewController.h"
#import "ZZH_getAlbumToolViewController.h"
#import "ZZH_showListViewController.h"
#define SELF_TITLE @"相册"
@interface ZZH_getAlbumRootViewController()<setALAssetsGroupDelegate>{
    NSMutableArray *_returnArray;
    NSMutableArray  *_indexArray;
}
@end

@implementation ZZH_getAlbumRootViewController
ZZH_getAlbumRootViewController *root;

+(instancetype)Default{
    static dispatch_once_t predicate;
    if(root==nil){
            dispatch_once(&predicate, ^{
            root = [[self alloc]init];
            });
        }
    return root;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    
    //相册列表ViewController
    ZZH_showListViewController *showListVC    = [[ZZH_showListViewController alloc]init];
    
    //  选择照片的ViewController
    ZZH_getAlbumToolViewController *zhh  = [[ZZH_getAlbumToolViewController alloc]init];
    zhh.maxIndex = self.maxIndex;
    //  NavgatioViewController
    UINavigationController *nav       = [[UINavigationController alloc]initWithRootViewController:showListVC];
    nav.view.frame                        = self.view.frame;
    
    //  设置ZHH_getAlbumTooViewController的代理  用来刷新相册列表
    zhh.delegate       = showListVC;
    showListVC.title  = SELF_TITLE;
    //  回调Block 吧getAlbumToolViewController的照片数组传过来
    zhh.returnblock  =  ^(NSMutableArray *returnArray){
        self.returnblock(returnArray);
    };
    [self addChildViewController:nav];
    [self.view addSubview:nav.view];
    [nav pushViewController:zhh animated:NO];
}




@end
