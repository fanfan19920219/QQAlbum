//
//  ViewController.m
//  get_album_Demo
//
//  Created by zhangzhihua on 16/4/12.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "ViewController.h"
#import "ZHH_getAlbumToolViewController.h"
#import "ZHH_getAlbumRootViewController.h"

@interface ViewController (){
    UIButton *_openButton;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _openButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _openButton.bounds = CGRectMake(0, 0, 100, 33);
    _openButton.center = self.view.center;
    //_openButton.backgroundColor = [UIColor grayColor];
    [_openButton addTarget:self action:@selector(openAlbum) forControlEvents:UIControlEventTouchUpInside];
    [_openButton setTitle:@"打开相册" forState:UIControlStateNormal];
    [_openButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:_openButton];
    
}

-(void)openAlbum{
    ZHH_getAlbumRootViewController *zhh = [[ZHH_getAlbumRootViewController alloc]init];
    [self presentViewController:zhh animated:YES completion:^{
        
    }];
//    zhh.view.frame = self.view.frame;
//    [self addChildViewController:zhh];
//    [self.view addSubview:zhh.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
