//
//  show_ImageViewViewController.m
//  NewMedSci
//
//  Created by zhangzhihua on 16/4/27.
//  Copyright © 2016年 Bioon. All rights reserved.
//

#import "show_ImageViewViewController.h"
//#import "Header.h"
#define VIEW_WIDTH self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height
@interface show_ImageViewViewController(){
    CGAffineTransform _steptransform;
    CGFloat _scale;
    UIImageView *        _SizeImageView;
    BOOL                   orshowBar;          //判断是否展示导航
    BOOL                   ordoubleClick;       //判断是否已经双击
}
@end


@implementation show_ImageViewViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self show];
    if(self.orPush == NO){
            [self createDismissButton];
    }
    self.view.clipsToBounds = YES;
}

-(void)createDismissButton{
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, VIEW_HEIGHT - 30, VIEW_WIDTH, 30)];
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissButton.frame = CGRectMake(VIEW_WIDTH - 50, 5, 40, 20);
    [dismissButton setTitle:@"退出" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:dismissButton];
    [self.view addSubview:downView];
}
-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//添加手势
-(void)show{
    _SizeImageView = [[UIImageView alloc]init];
    //添加放大手势
    _SizeImageView.userInteractionEnabled = YES;
    UIPinchGestureRecognizer* pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [_SizeImageView addGestureRecognizer:pinch];
    
    //添加滑动手势
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [_SizeImageView addGestureRecognizer:pan];
    
    //单击手势
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap1.numberOfTapsRequired = 1;
    [_SizeImageView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubletap:)];
    tap2.numberOfTapsRequired = 2;
    [_SizeImageView addGestureRecognizer:tap2];
    
    [tap1 requireGestureRecognizerToFail:tap2];
    
    if(self.local_showImageView!=nil){
        _SizeImageView.image = self.local_showImageView.image;
        _SizeImageView.frame = CGRectMake(0, 0, VIEW_WIDTH,VIEW_WIDTH*(self.local_showImageView.image.size.height/self.local_showImageView.image.size.width));
        _SizeImageView.center = CGPointMake(VIEW_WIDTH/2, VIEW_HEIGHT/2);
        [self.view addSubview:_SizeImageView];
    }
}


#pragma mark -放大手势
- (void)pinch:(UIPinchGestureRecognizer* )gesture {
    //    NSLog(@"-----------------");
    //判断一下手势的状态，通常使用的有三个
    //手势的每一个状态都会调用这个回调方法，所以我们需要判断一下，在不同的状态下，做不同的操作
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            //开始
            if(_scale>0.1)gesture.scale = _scale;
            NSLog(@"开始----%f",gesture.scale);
        }
            break;
        case UIGestureRecognizerStateChanged:{
            NSLog(@"-----%f", gesture.scale);
            
            //在原始的基础上缩放到多少倍
            gesture.view.transform = CGAffineTransformMakeScale(gesture.scale, gesture.scale);
        }
            break;
        case UIGestureRecognizerStateEnded:{
            //完成
            _scale=  gesture.scale;
            [UIView animateWithDuration:0.2 animations:^{
                if(_scale<=1){
                    _scale=1;
                    gesture.view.transform = CGAffineTransformMakeScale(_scale, _scale);
                    _SizeImageView.center = CGPointMake(VIEW_WIDTH/2, VIEW_HEIGHT/2);
                }
                if(_scale>2){
                    _scale=2;
                    gesture.view.transform = CGAffineTransformMakeScale(_scale, _scale);
                }
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark -滑动手势
//移动
- (void)pan:(UIPanGestureRecognizer* )gesture {
//    NSLog(@"-----------------");

    //判断一下手势的状态，通常使用的有三个
    //手势的每一个状态都会调用这个回调方法，所以我们需要判断一下，在不同的状态下，做不同的操作
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            //开始
            NSLog(@"开始");
        }
            break;
        case UIGestureRecognizerStateChanged:{
            //移动
            NSLog(@"移动");

            //view，获得手势绑定的 view
            CGPoint point = [gesture translationInView:self.view];

            //NSStringFromCGPoint，把 CGPoint 转换为 NSString
            //CGPointFromString，把 NSString 转换为 CGPoint
            NSLog(@"%@ ---- %f --- %f", NSStringFromCGPoint(point),_SizeImageView.frame.size.width,_SizeImageView.center.x);

            //重置移动的距离，重置为 0，0，那么下次得到的 point，就是两次移动之间的距离。
            [gesture setTranslation:CGPointZero inView:gesture.view];

            //移动 view
            //原始坐标 ＋ 偏移量
//            gesture.view.center = CGPointMake(gesture.view.center.x + point.x, gesture.view.center.y + point.y);

            //CGRectOffset，对一个 CGRect 做偏移，返回一个新的 CGRect
            gesture.view.frame = CGRectOffset(gesture.view.frame, point.x, point.y);
        }
            break;
        case UIGestureRecognizerStateEnded:{
            //完成
            NSLog(@"结束");
            [UIView animateWithDuration:0.2 animations:^{
                //横坐标约束
                if(_SizeImageView.frame.size.width >= VIEW_WIDTH){
                    if((_SizeImageView.center.x>VIEW_WIDTH/2)&&(_SizeImageView.center.x>_SizeImageView.frame.size.width/2)){
                        _SizeImageView.center = CGPointMake(VIEW_WIDTH/2+(_SizeImageView.frame.size.width - VIEW_WIDTH)/2, _SizeImageView.center.y);
                    }else if((_SizeImageView.center.x<VIEW_WIDTH/2)&&((_SizeImageView.center.x + _SizeImageView.frame.size.width/2)<VIEW_WIDTH)){
                        _SizeImageView.center = CGPointMake(VIEW_WIDTH/2-(_SizeImageView.frame.size.width - VIEW_WIDTH)/2, _SizeImageView.center.y);
                    }
                }
                //纵坐标约束
                if(_SizeImageView.frame.size.height >= VIEW_HEIGHT){
                    if((_SizeImageView.center.y>VIEW_HEIGHT/2)&&(_SizeImageView.center.y>_SizeImageView.frame.size.height/2)){
                        _SizeImageView.center = CGPointMake(_SizeImageView.center.x , VIEW_HEIGHT/2+(_SizeImageView.frame.size.height - VIEW_HEIGHT)/2);
                    }else if((_SizeImageView.center.y<VIEW_HEIGHT/2)&&((_SizeImageView.center.y + _SizeImageView.frame.size.height/2)<VIEW_HEIGHT)){
                        _SizeImageView.center = CGPointMake(_SizeImageView.center.x , VIEW_HEIGHT/2-(_SizeImageView.frame.size.height - VIEW_HEIGHT)/2);
                    }
                }else{
                    _SizeImageView.center = CGPointMake(_SizeImageView.center.x , VIEW_HEIGHT/2);
                }
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark -单击手势
-(void)tap:(UITapGestureRecognizer*)gesture{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{}break;
        case UIGestureRecognizerStateChanged:{}break;
        case UIGestureRecognizerStateEnded:{
            //完成
            NSLog(@"111");
            orshowBar = !orshowBar;
            self.navigationController.navigationBarHidden = orshowBar;
        }
            break;
        default:
            break;
    }
}

#pragma mark - 双击手势
-(void)doubletap:(UITapGestureRecognizer*)gesture{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
        }break;
        case UIGestureRecognizerStateChanged:{
        }break;
        case UIGestureRecognizerStateEnded:{
            NSLog(@"doubleClick!");
            ordoubleClick = !ordoubleClick;
            [UIView animateWithDuration:0.2 animations:^{
                if(ordoubleClick&&(_scale<1.5)){
                    gesture.view.transform = CGAffineTransformMakeScale(1.5, 1.5);
                }else{
                    _scale = 1.0f;
                    gesture.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                    _SizeImageView.center = CGPointMake(VIEW_WIDTH/2, VIEW_HEIGHT/2);
                    ordoubleClick= NO;
                }
            }];
        }break;
        default:
            break;
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   // [self dismissViewControllerAnimated:YES completion:nil];
}
@end
