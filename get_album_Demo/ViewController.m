//
//  ViewController.m
//  get_album_Demo
//
//  Created by zhangzhihua on 16/4/12.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "ViewController.h"
#import "ZZH_getAlbumToolViewController.h"
#import "ZZH_getAlbumRootViewController.h"

#define OPEN_BUTTON_NAME @"打开相册"
#define PUT_BUTTON_NAME @"输出"

@interface ViewController () {
    UIButton *_openButton;
    UIButton *_numButton;

    NSMutableArray  *_getArray;

    ZZH_getAlbumRootViewController *zhh;
}
//ms123456
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor                            = [UIColor whiteColor];
    _openButton                                          = [UIButton buttonWithType:UIButtonTypeCustom];
    _openButton.bounds                                   = CGRectMake(0, 0, 100, 33);
    _openButton.center                                   = self.view.center;
    //_openButton.backgroundColor = [UIColor grayColor];
    [_openButton addTarget:self action:@selector(openAlbum) forControlEvents:UIControlEventTouchUpInside];
    [_openButton setTitle:OPEN_BUTTON_NAME forState:UIControlStateNormal];
    [_openButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:_openButton];

    _numButton                                           = [UIButton buttonWithType:UIButtonTypeCustom];
    _numButton.bounds                                    = CGRectMake(0, 0, 100, 33);
    _numButton.center                                    = CGPointMake(self.view.center.x, 400);
    //_openButton.backgroundColor = [UIColor grayColor];
    [_numButton addTarget:self action:@selector(logNum) forControlEvents:UIControlEventTouchUpInside];
    [_numButton setTitle:PUT_BUTTON_NAME forState:UIControlStateNormal];
    [_numButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:_numButton];

}

//打开相册  并且设置接收返回照片的数组
-(void)openAlbum{
    //获取指针 用来push
    zhh = [ZZH_getAlbumRootViewController Default];
    zhh.maxIndex = 9;
    //用这个方法来获得回调数组
    [ZZH_getAlbumRootViewController Default].returnblock = ^(NSMutableArray *returnArray){_getArray = returnArray;};
    [self presentViewController:zhh animated:YES completion:^{}];
}

-(void)logNum{
    NSLog(@"_getarray --- %@",_getArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
