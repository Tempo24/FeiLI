//
//  ZJViewController.m
//  FeiLi
//
//  Created by lx on 16/4/16.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "AAViewController.h"
#import "AACollectionViewCell.h"
#import "SecondAAViewController.h"
@interface AAViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{

    UICollectionView *_collectionView;
    NSArray *_arr;
    NSArray *_array;//二维数组
    UIView *labelView;
}

@end

NSString *const aaCellID = @"aaCell";
@implementation AAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    labelView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KscreenWidth, 30)];
    labelView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:labelView];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 40, 20)];
    label1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    label1.textColor = [UIColor blackColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:12];
    label1.text = self.title;
    [labelView addSubview:label1];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(KscreenWidth, (KscreenHeight-64-49-30)/2.0);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+30, KscreenWidth, KscreenHeight-64-30-49) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];

    [_collectionView registerClass:[AACollectionViewCell class] forCellWithReuseIdentifier:aaCellID];
    
    _arr = @[@"女士",@"男士"];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"ManOrGirl.plist" ofType:nil];
    _array = [NSArray arrayWithContentsOfFile:path];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AACollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:aaCellID forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor whiteColor];
        cell.label.text = _arr[0];
    }else{
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.label.text = _arr[1];

    }
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",indexPath.row+1]];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SecondAAViewController *aaVC = [[SecondAAViewController alloc]init];
    [self.navigationController pushViewController:aaVC animated:YES];
    aaVC.title = _arr[indexPath.row];
    aaVC.name = self.title;
    aaVC.nameArr = _array[indexPath.row];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
