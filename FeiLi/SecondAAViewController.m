//
//  SecondAAViewController.m
//  FeiLi
//
//  Created by lx on 16/4/16.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "SecondAAViewController.h"
#import "SecondAACollectionViewCell.h"
#import "ThirdAAViewController.h"

@interface SecondAAViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{

    UICollectionView *_collectionView;
    UIView *labelView;
    
    
}

@end

NSString *const secondCellID = @"secondCell";
@implementation SecondAAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    labelView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KscreenWidth, 30)];
    labelView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:labelView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 40, 20)];
    label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 40, 20)];
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    label.text = _name;
    [labelView addSubview:label];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 40, 20)];
    label2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    label2.textColor = [UIColor blackColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:12];
    label2.text = self.title;
    [labelView addSubview:label2];
    [self.view addSubview:labelView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(KscreenWidth/3.0, (KscreenHeight-64-30-49)/4.0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+30, KscreenWidth, (KscreenHeight-64-30)) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];

    [_collectionView registerClass:[SecondAACollectionViewCell class] forCellWithReuseIdentifier:secondCellID];
    
    
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _nameArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SecondAACollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:secondCellID forIndexPath:indexPath];
    if (indexPath.row%2 == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    }else
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.label.text = _nameArr[indexPath.row];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ThirdAAViewController *vc = [[ThirdAAViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    vc.title = _nameArr[indexPath.row];
    vc.nameLabel = _name;
    vc.nameLabel2 = self.title;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
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
