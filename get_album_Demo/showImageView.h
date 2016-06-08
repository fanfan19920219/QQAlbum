//
//  showImageView.h
//  get_album_Demo
//
//  Created by zhangzhihua on 16/4/13.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  showDelegate<NSObject>

@optional
-(void)recurrentSelectImageView:(NSInteger)selectindex;

-(void)selecttheImageViewMethod:(NSInteger)index and:(BOOL)orSelected;

-(BOOL)orCanClick;

@end

@interface showImageView : UIImageView

@property (nonatomic , assign)id <showDelegate> delegate;

@property (nonatomic , strong)UIButton *selectButton;

@property (nonatomic, assign)BOOL    orCanClick; //是否可以点击

-(void)setframe:(CGRect)frame;

@end
