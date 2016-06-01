//
//  ALAssetsGroupModel.h
//  get_album_Demo
//
//  Created by zhangzhihua on 16/5/31.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

@interface ALAssetsGroupModel : NSObject
@property (nonatomic , assign)NSInteger count;

@property (nonatomic , strong)NSString *name;

@property (nonatomic , strong)UIImage *image;

@end
