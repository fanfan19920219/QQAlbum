//
//  showListViewController.m
//  get_album_Demo
//
//  Created by zhangzhihua on 16/5/31.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import             "ZZH_showListViewController.h"
#import             "ALAssetsGroupModel.h"
#import             <AssetsLibrary/AssetsLibrary.h>

#define VIEW_WIDTH  self.view.frame.size.width

#define VIEW_HEIGHT self.view.frame.size.height

#define TEXT_STRING [NSString stringWithFormat:@"%@ (%ld)",model.name,model.count]

#define SELF_TITLE @"相机"

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface ZZH_showListViewController ()<setALAssetsGroupDelegate,UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
}
@end

@implementation ZZH_showListViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title  = SELF_TITLE;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self create_ViewControllers];
}

/**
 *  界面
 */
-(void)create_ViewControllers{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, VIEW_WIDTH, VIEW_HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.dataSource =self;
    _tableView.delegate = self;
    _tableView.rowHeight = 80;
    [self.view addSubview:_tableView];
}

/**
 *  代理方法
 *
 *  @param tableView 展示照片的表
 *  @param indexPath indexPath
 *
 *  @return UitableViewCell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    ALAssetsGroupModel *model = [_albumListArray objectAtIndex:(_albumListArray.count - 1) - indexPath.row];
    cell.textLabel.text               = TEXT_STRING;
    cell.textLabel.textColor        = RGBA(88, 88, 88, 1);
    cell.imageView.image            = model.image;
    cell.accessoryType              = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"click");
    ZZH_getAlbumToolViewController *album = [[ZZH_getAlbumToolViewController alloc]init];
    album.delegate      = self;
    album.albumString = [[_albumListArray objectAtIndex:(_albumListArray.count - 1) - indexPath.row] name];
    [self.navigationController pushViewController:album animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _albumListArray.count;
}

/**
 *  界面将要消失的方法
 *
 *  @param animated
 */
-(void)viewWillAppear:(BOOL)animated{
    [_tableView reloadData];
}
/**
 *  给相册选择列表赋值
 *
 *  @param array 传过来的数组
 */
-(void)setAlassetArray:(NSMutableArray *)array{
    _albumListArray = [[NSMutableArray alloc]init];
    
    for(ALAssetsGroup *group in array){
        ALAssetsGroupModel *model = [[ALAssetsGroupModel alloc]init];
        model.name =[NSString stringWithFormat:@"%@",[group valueForProperty:ALAssetsGroupPropertyName]];
        model.count = [group numberOfAssets];
        model.image = [UIImage imageWithCGImage:[group posterImage]];
        [_albumListArray addObject:model];
    }
}

@end
