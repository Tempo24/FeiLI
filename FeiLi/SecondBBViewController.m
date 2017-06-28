//
//  SecondDetViewController.m
//  FeiLi
//
//  Created by lx on 16/4/9.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "SecondBBViewController.h"
#import "DetailViewController.h"
#import "SecondBBCollectionViewCell.h"

#define BaseURL @"http://gf.zlapi.com/search/quick?client=ios&cv=1.3.0&av=1.0.0&vendor=AppStore&mac=B9D4E99D-4B66-42AE-84F0-A4EAB6638C7D&imei=B9D4E99D-4B66-42AE-84F0-A4EAB6638C7D&uuid=B9D4E99D-4B66-42AE-84F0-A4EAB6638C7D&ptype=iPhone8%2C1&os=9.3.1&ct=-1&kw=30003%3B-1&len=10&token=kDkC8zHbfbSRi%2Fx1suznf4hPjjcVTz3RxUJnBzuzqtg%3D"

@interface SecondBBViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{

    UICollectionView *_collectionView;
    
    NSMutableArray *titleArr;
    NSMutableArray *scArr;
    NSMutableArray *imgArr;
    
     NSArray *cidArr;//链接数组
}

@end
NSString *const detailCellID = @"detailCell";
@implementation SecondBBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *labelView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KscreenWidth, 30)];
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
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(KscreenWidth, (KscreenHeight-64-30)/3.0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+30, KscreenWidth, (KscreenHeight-64-30)) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    //加载xib文件
    UINib *nib = [UINib nibWithNibName:@"detailCollectionCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:detailCellID];
    
    //初始化数组
    titleArr = [NSMutableArray array];
    scArr = [NSMutableArray array];
    imgArr = [NSMutableArray array];
    
    //网络请求
    [self _requstData];
    cidArr = @[@"200000486",@"200000141",@"200000168",@"200000176",@"200000113",@"200000046",@"200000066",@"200000055",@"200000023",@"200000415"];
    
}

- (void)_requstData{
   
    [LXNetWorkManager requestWithURL:BaseURL LXGETNetWorkType:LXGETNetWorkTypeWithGET pramas:nil target:nil action:nil showHUD:YES currentView:self.view successBlock:^(id respondeData) {
        NSDictionary * dic1 = respondeData[@"data"];
        NSArray *arr = dic1[@"articles"];
        
        for (NSDictionary *dic in arr) {
            
            [titleArr addObject:dic[@"preface"]];
            [scArr addObject:dic[@"favCount"]];
            [imgArr addObject:dic[@"img"]];
        }
        
        [_collectionView reloadData];
    } failureBlock:^(NSError *netError) {
        
    }];
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (titleArr.count == 0) {
        return 0;
    }
    return titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SecondBBCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:detailCellID forIndexPath:indexPath];
    if (titleArr.count != 0) {
       cell.titleLabel.text = titleArr[indexPath.row];
    }
    if (scArr.count != 0) {
        cell.scLabel.text = [NSString stringWithFormat:@"%@",scArr[indexPath.row]];
    }
    
    if (imgArr.count != 0) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imgArr[indexPath.row]]];
        
    }
    
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    DetailViewController *vc = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.navigationController.navigationBarHidden = YES;
    vc.scCount = [NSString stringWithFormat:@"%@",scArr[indexPath.row]];
    vc.baseURL = [NSString stringWithFormat:@"http://gf.zlapi.com/collection/view?cid=%@",cidArr[indexPath.row]];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
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
