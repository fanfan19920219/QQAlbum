//
//  ZHH_getAlbumToolViewController.m
//  get_album_Demo
// 晨曦
//  Created by zhangzhihua on 16/4/12.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//
#import "ZHH_getAlbumToolViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>

#import "showImageView.h"

#import "amplifyViewController.h"

#import "showListViewController.h"

#import "show_ImageViewViewController.h"

#import "ALAssetsGroupModel.h"

#define CAMERANAME1 @"相机胶卷"

#define CAMERANAME2 @"所有照片"

#define CAMERANAME3 @"Camera Roll"

#define TITLE_TEXT      @"相机胶卷"

#define VIEW_WIDTH self.view.frame.size.width

#define VIEW_HEIGHT self.view.frame.size.height

#define HEADERVIEW_HEIGHT 64.f

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface ZHH_getAlbumToolViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,showDelegate,setALAssetsGroupDelegate>{
//    UIView                 *_headerView;
//    UIButton              *_albumListButton;
//    UILabel               *_titleLable;
    UICollectionView    *_collectionView;
    NSMutableArray   *_showImageViewArray;
    NSMutableArray   *_selectedindexArray;
    
    UIView                 *_downView;
    UIButton              *_leftButton;
    UIButton              *_rightButton;
    
    NSMutableArray   *_ALAssetsGroupArray;       //相册数组
//    void(^block1)(NSMutableArray *array);
}

@end

@implementation ZHH_getAlbumToolViewController

//viewDidLoad
-(void)viewDidLoad {
    [super viewDidLoad];
    [self create_collectionView];
    [self getAlbumPhoto];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

-(void)create_collectionView{
    //  系统提供的一种流式布局方式
    //  初始化系统的layout
    UICollectionViewFlowLayout *flowLayout  = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing=10.0f;
    flowLayout.minimumLineSpacing=10.0f;
    flowLayout.itemSize=CGSizeMake(80, 80);
    flowLayout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向

    //  创建 collectionView
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, HEADERVIEW_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - 54 - HEADERVIEW_HEIGHT) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //  注册重用的collectionViewCell
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
    
    //[tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
    //[_collectionView scrollToItemAtIndexPath:<#(nonnull NSIndexPath *)#> atScrollPosition:<#(UICollectionViewScrollPosition)#> animated:<#(BOOL)#>]
    
    _downView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
    _downView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_downView];
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame = CGRectMake(0, 0, self.view.frame.size.width/2.0, 44);
    [_leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [_leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    [_downView addSubview:_leftButton];
}

-(void)cancleClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 获取相册里面的照片
-(void)getAlbumPhoto{
    //  初始化放照片的数组
    _showImageViewArray = [[NSMutableArray alloc]init];
    //  初始化选中索引的数组
    _selectedindexArray = [[NSMutableArray alloc]init];
    //初始化相册信息的数组
    _ALAssetsGroupArray = [[NSMutableArray alloc]init];
    //  从相册里面取出来照片
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc]init];
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue1, ^{
        [assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group , BOOL *stop){
            if(group!=NULL)[_ALAssetsGroupArray addObject:group];
            if(group==NULL)[self.delegate setAlassetArray:_ALAssetsGroupArray];//让showListViewController执行代理方法刷新tableView
            //  获取相册的名字
            NSString *groupname = [group valueForProperty:ALAssetsGroupPropertyName];
            if((([groupname isEqualToString:CAMERANAME1]||[groupname isEqualToString:CAMERANAME2]||[groupname isEqualToString:CAMERANAME3])&&(self.albumString==nil))||([self.albumString isEqualToString:groupname])){
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.title = [NSString stringWithFormat:@"%@(%ld)",TITLE_TEXT,(long)[group numberOfAssets]];
                [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index , BOOL *stop){
                    UIImage *image = [UIImage imageWithCGImage:result.thumbnail];
                    //UIImage *image = [UIImage imageWithCGImage:[[result defaultRepresentation] fullResolutionImage]];
                    if(image){
                        showImageView *showImageview = [[showImageView alloc]initWithFrame:CGRectZero];
                        showImageview.delegate = self;
                        showImageview.image = image;
                        showImageview.tag = index;
                        [_showImageViewArray addObject:showImageview];
                    }
                }];
                    [_collectionView reloadData];
                });
            }
        }failureBlock:^(NSError *error) {
        }];
    });
}

#pragma mark - collectionView的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _showImageViewArray.count;
}

//collection的代理方法
- (UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    showImageView *imageView = [_showImageViewArray objectAtIndex:((_showImageViewArray.count - 1) - indexPath.item)];
    imageView.tag = ((_showImageViewArray.count - 1) - indexPath.item);
    imageView.delegate = self;
    [imageView setframe:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    [cell.contentView addSubview:imageView];
    return cell;
}

#pragma mark - showDelegate
     //   单击显示当前照片放大的方法
-(void)recurrentSelectImageView:(NSInteger)selectindex{
    //   从相册里面取出来照片
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc]init];
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue1, ^{
        [assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group , BOOL *stop){
            //   获取相册的名字
            NSString *groupname = [group valueForProperty:ALAssetsGroupPropertyName];
            if((([groupname isEqualToString:CAMERANAME1]||[groupname isEqualToString:CAMERANAME2]||[groupname isEqualToString:CAMERANAME3])&&(self.albumString==nil))||([self.albumString isEqualToString:groupname])){
                [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index , BOOL *stop){
                    if(index == selectindex){
                        UIImage *image = [UIImage imageWithCGImage:[[result defaultRepresentation] fullResolutionImage]];
                        //NSLog(@"当前照片为所选照片-------%ld  ---------  %@",(long)selectindex,image);
                        //回主线程
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"push");
                            [self pushselectCurrentViewcontroller:image];
                        });
                    }
                }];
            }
        }failureBlock:^(NSError *error) {}];
    });
}

-(void)pushselectCurrentViewcontroller:(UIImage*)showImageview{
    show_ImageViewViewController *showVC = [[show_ImageViewViewController alloc]init];
    showVC.local_showImageView = [[UIImageView alloc]initWithImage:showImageview];
    [self presentViewController:showVC animated:YES completion:nil];
}

#pragma mark - 选中时候的方法
-(void)selecttheImageViewMethod:(NSInteger)index and:(BOOL)orSelected{
    NSLog(@"bool --- %d ---- index ---- %ld",orSelected,(long)index);
    if(orSelected){
        [_selectedindexArray addObject:[NSString stringWithFormat:@"%ld",(long)index]];
    }else{
        [_selectedindexArray removeObject:[NSString stringWithFormat:@"%ld",(long)index]];
    }
    for(NSString *indexString in _selectedindexArray){
        NSLog(@"%@",indexString);
    }
}

-(void)selectedimageView{
    
}

@end
