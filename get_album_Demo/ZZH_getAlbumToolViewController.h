//
//  ZZH_getAlbumToolViewController.h
//  get_album_Demo
//
//  Created by zhangzhihua on 16/4/12.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

/**
 *  处理获取照片ViewController
 */

#import <UIKit/UIKit.h>

@protocol setALAssetsGroupDelegate <NSObject>

@optional
//用来刷新相册的代理方法 用来刷新tableView
-(void)setAlassetArray:(NSMutableArray*)array;

////返回已经选择的照片的代理方法
//-(void)getSelectedPhoto:(NSMutableArray*)selectedPhotoArray;
@end


@interface ZZH_getAlbumToolViewController : UIViewController
@property (nonatomic , assign)id<setALAssetsGroupDelegate> delegate;
@property (nonatomic , strong)NSString *albumString;
@property (nonatomic , assign)NSInteger maxIndex;
@property (nonatomic,strong)void(^returnblock)(NSMutableArray *returnArray);

//-(void)doMethodwithBlock:(void(^)(NSMutableArray *assetArray))block;
@end
