//
//  showListViewController.h
//  get_album_Demo
//
//  Created by zhangzhihua on 16/5/31.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//


/**
 *   照片列表
 */


#import <UIKit/UIKit.h>
#import "ZZH_getAlbumToolViewController.h"


@interface ZZH_showListViewController : UIViewController

@property (nonatomic , strong)NSMutableArray *albumListArray;      //列表信息数组(ALAssetsGroup)

@end
