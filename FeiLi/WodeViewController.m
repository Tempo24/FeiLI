//
//  WodeViewController.m
//  FeiLi
//
//  Created by lx on 16/4/9.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "WodeViewController.h"
#import "SheZhiViewController.h"
#import "WodeCollectionViewCell.h"
#import "BianJIViewController.h"
#import "UserModel.h"
#import "DataBase.h"
#import "DetailViewController.h"
#define BaseURL @"http://gf.zlapi.com/favorites/list?client=ios&cv=1.3.0&av=1.0.0&vendor=AppStore&mac=B9D4E99D-4B66-42AE-84F0-A4EAB6638C7D&imei=B9D4E99D-4B66-42AE-84F0-A4EAB6638C7D&uuid=B9D4E99D-4B66-42AE-84F0-A4EAB6638C7D&ptype=iPhone8%2C1&os=9.3.1&ct=-1&len=20&token=Hk9oG13yd3L29f6owQyOE7KbzmEPUUaiP%2BiXfHbCDwM%3D"

@interface WodeViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    
    UICollectionView *_collectionView;
    UILabel *label;
    UIImageView *imgView;
    
    NSMutableArray *titleArr;
    NSMutableArray *scArr;
    NSMutableArray *imgArr;
    NSArray *urlArr;//链接数组
}

@end

NSString *const collectionCellID = @"CollectionCell";
NSString *const collectionCellID2 = @"firstCollectionCell";
NSString *imageName = @"cao.jpg";
NSString *userName = @"kobe浪";
@implementation WodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = [UIColor clearColor];
    self.title = @"我的";
    UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBut.frame = CGRectMake(0, 0, 44, 44);
    [rightBut setTitle:@"设置" forState:UIControlStateNormal];
    [rightBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [rightBut addTarget:self action:@selector(ClickAction) forControlEvents:UIControlEventTouchUpInside];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake((KscreenWidth-5)/2.0, (KscreenHeight-64-49-10)/3.0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 5;
    layout.headerReferenceSize = CGSizeMake(KscreenWidth, 200);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [self.view addSubview:_collectionView];
    
    
    UINib *nib = [UINib nibWithNibName:@"collectionViewCell" bundle:nil];
    
    [_collectionView registerNib:nib forCellWithReuseIdentifier:collectionCellID];
    
    
    UINib *nib2 = [UINib nibWithNibName:@"firstCollectionViewCell" bundle:nil];
   
    [_collectionView registerNib:nib2 forCellWithReuseIdentifier:collectionCellID2];
   
    [_collectionView registerClass:[WodeCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headCell"];
    
    //初始化数组
    titleArr = [NSMutableArray array];
    scArr = [NSMutableArray array];
    imgArr = [NSMutableArray array];
    
    //网络请求
    [self _requstData];
    urlArr = @[@"200000358",@"200000384",@"200000415",@"200000016",];
    
}

- (void)_requstData{
    
    [LXNetWorkManager requestWithURL:BaseURL LXGETNetWorkType:LXGETNetWorkTypeWithGET pramas:nil target:nil action:nil showHUD:YES currentView:self.view successBlock:^(id respondeData) {
        
        NSDictionary * dic1 = respondeData[@"data"];
        NSArray *arr = dic1[@"articles"];
        
        for (NSDictionary *dic in arr) {
            
            [titleArr addObject:dic[@"title"]];
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
    
    WodeCollectionViewCell *cell;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    
    if (titleArr.count != 0) {
        cell.titleLabel.text = titleArr[indexPath.row];
    }
    if (imgArr.count != 0) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imgArr[indexPath.row]]];
    }
    if (scArr.count != 0) {
        cell.scLabel.text = [NSString stringWithFormat:@"%@",scArr[indexPath.row]];
    }
    

    return cell;
    

}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headCell" forIndexPath:indexPath];
    
    //读取数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"username"];
    NSData *imageData = [defaults dataForKey:@"image"];
    UIImage *image = [UIImage imageWithData:imageData];
    
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake((KscreenWidth-70)/2, (view.frame.size.height-70)/2-30, 70, 70)];
    imgView.backgroundColor = [UIColor whiteColor];
    imgView.layer.cornerRadius = 35.0;
    imgView.clipsToBounds = YES;
    if (image == nil) {
        imgView.image = [UIImage imageNamed:imageName];
    }else{
        imgView.image = image;
    }
    [view addSubview:imgView];

    if (label ==nil) {
        label = [[UILabel alloc]initWithFrame:CGRectMake((KscreenWidth-200)/2, view.frame.size.height-50-30, 200, 20)];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.0];
        [view addSubview:label];
    }
    
    
    if (name == nil ) {
        label.text = userName;
    }else{
        label.text = name;
    }
    

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.frame = view.frame;
    [view addSubview:button];
    [button addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *scLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, view.frame.size.height-30, KscreenWidth, 30)];
    scLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    scLabel.text = @"  我的收藏";
    scLabel.textAlignment = NSTextAlignmentLeft;
    scLabel.textColor = [UIColor blackColor];
    scLabel.font = [UIFont systemFontOfSize:14.0];
    [view addSubview:scLabel];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    DetailViewController *vc = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.baseURL = [NSString stringWithFormat:@"http://gf.zlapi.com/collection/view?cid=%@",urlArr[indexPath.row]];
    vc.scCount = [NSString stringWithFormat:@"%@",scArr[indexPath.row]];
}


- (void)ClickAction{
    SheZhiViewController *vc = [[SheZhiViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)ClickButton:(UIButton *)button{
    BianJIViewController *vc = [[BianJIViewController alloc]init];
    vc.UserImage = imgView.image;
    
    vc.userName = label.text;

    [self.navigationController pushViewController:vc animated:YES];
    
    vc.block = ^(NSString *str){
        label.text = str;
        
        UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake((KscreenWidth-200)/2, KscreenHeight-150, 200, 40)];
        tempLabel.backgroundColor = [UIColor orangeColor];
        tempLabel.textColor = [UIColor whiteColor];
        tempLabel.textAlignment = NSTextAlignmentCenter;
        tempLabel.text = @"修改成功";
        [self.view addSubview:tempLabel];
        
        CATransition *transition = [CATransition animation];
        transition.type = @"push";
        transition.subtype = @"fromTop";
        [tempLabel.layer addAnimation:transition forKey:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((1.5) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tempLabel removeFromSuperview];
            
        });

        //保存修改后的数据
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *name = str;
        [defaults setObject:name forKey:@"username"];
        [defaults synchronize];
    
   };
    
    vc.block1 = ^(NSString *imgName){
        
        imgView.image = [UIImage imageNamed:imgName];
        
        //保存修改后的数据
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        UIImage *image = [UIImage imageNamed:imgName];
        NSData *imageData = UIImageJPEGRepresentation(image, 100);
        [defaults setObject:imageData forKey:@"image"];
        [defaults synchronize];
    
    };
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [_collectionView reloadData];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
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
