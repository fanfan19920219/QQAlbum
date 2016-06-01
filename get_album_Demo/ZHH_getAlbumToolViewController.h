//
//  ZHH_getAlbumToolViewController.h
//  get_album_Demo
//
//  Created by zhangzhihua on 16/4/12.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol setALAssetsGroupDelegate <NSObject>

@optional
-(void)setAlassetArray:(NSMutableArray*)array;
@end


@interface ZHH_getAlbumToolViewController : UIViewController
@property (nonatomic , assign )id<setALAssetsGroupDelegate> delegate;
@property (nonatomic , strong)NSString *albumString;
@end
