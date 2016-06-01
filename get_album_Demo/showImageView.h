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

@end

@interface showImageView : UIImageView

@property (nonatomic , assign)id <showDelegate> delegate;
@property (nonatomic , strong)UIButton *selectButton;
-(void)setframe:(CGRect)frame;

@end
