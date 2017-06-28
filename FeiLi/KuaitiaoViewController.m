//
//  KuaitiaoViewController.m
//  FeiLi
//
//  Created by lx on 16/4/9.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "KuaitiaoViewController.h"
#import "CollectionViewCell.h"
#import "BBViewController.h"
#import "AAViewController.h"
@interface KuaitiaoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{

    UICollectionView *_collectionView;
    NSArray *arr;
    
    NSArray *_nameArr;//二维数组
    
}

@end

NSString *const cellID = @"cell";

@implementation KuaitiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowlayout];
    flowlayout.itemSize = CGSizeMake(KscreenWidth/3.0, (KscreenHeight-64-49)/4.0);
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.minimumLineSpacing = 0;
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    
    arr = @[@"自己",@"女票",@"男票",@"母亲",@"父亲",@"闺蜜",@"基友",@"同学",@"同事",@"小盆友",@"老师",@"客户"];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"kuaitiao.plist" ofType:nil];
    _nameArr = [NSArray arrayWithContentsOfFile:path];
    

    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:cellID];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (indexPath.row%2 == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    }else{
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    cell.label.text = arr[indexPath.row];
    
    cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"3000%d",indexPath.row+1]];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 || indexPath.row == 7 || indexPath.row == 8) {
        AAViewController *aaVC = [[AAViewController alloc]init];
        [self.navigationController pushViewController:aaVC animated:YES];
        aaVC.title = arr[indexPath.row];
        aaVC.nameArr = _nameArr[indexPath.row];
        
    }else{
        BBViewController *bbVC = [[BBViewController alloc]init];
        [self.navigationController pushViewController:bbVC animated:YES];
        bbVC.title = arr[indexPath.row];
        bbVC.nameArray = _nameArr[indexPath.row];
       
    }
    
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
