//
//  ZZH_getAlbumRootViewController.h
//  get_album_Demo
//
//  Created by zhangzhihua on 16/5/31.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

/**
 *  根控制器
 */
#import <UIKit/UIKit.h>

@protocol setArray <NSObject>

@optional
-(void)setArray:(NSMutableArray *)mutableArray;

@end
@class LLBLModel;
@interface ZZH_getAlbumRootViewController : UIViewController

+(instancetype)Default;

@property (nonatomic ,assign)NSInteger maxIndex;

@property (nonatomic , strong)LLBLModel *llblModel;

@property (nonatomic,strong)void(^returnblock)(NSMutableArray *returnArray);
//
//@property (nonatomic , strong)NSMutableArray *returnImageArray;
//
//-(void)getSelectImageArray:(NSMutableArray *)imageArray;
//
//@property (nonatomic , assign)id  delegate;

@end
