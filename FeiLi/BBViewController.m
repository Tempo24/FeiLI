//
//  DetViewController.m
//  FeiLi
//
//  Created by lx on 16/4/9.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "BBViewController.h"
#import "BBCollectionViewCell.h"
#import "SecondBBViewController.h"
@interface BBViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{

    UICollectionView *_collectionView;
}

@end

NSString *const cellIDI = @"dtCell";

@implementation BBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIView *labelView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KscreenWidth, 30)];
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
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30+64, KscreenWidth, KscreenHeight-30-64-49) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(KscreenWidth/3.0, (KscreenHeight-64-49-30)/4.0);
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[BBCollectionViewCell class] forCellWithReuseIdentifier:cellIDI];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _nameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BBCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIDI forIndexPath:indexPath];
    if (indexPath.row%2 == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    
    cell.label.text = _nameArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondBBViewController *secVC = [[SecondBBViewController alloc]init];
    [self.navigationController pushViewController:secVC animated:YES];
    secVC.title = _nameArray[indexPath.row];
    secVC.name = self.title;
}

- (void)viewWillAppear:(BOOL)animated{

    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
