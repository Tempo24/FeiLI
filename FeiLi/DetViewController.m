//
//  DetViewController.m
//  FeiLi
//
//  Created by lx on 16/4/16.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "DetViewController.h"
#import "DetTableViewCell.h"
#import "DetailViewController.h"

#define BaseURL @"http://gf.zlapi.com/search/category?client=ios&cv=1.3.0&av=1.0.0&vendor=AppStore&mac=B9D4E99D-4B66-42AE-84F0-A4EAB6638C7D&imei=B9D4E99D-4B66-42AE-84F0-A4EAB6638C7D&uuid=B9D4E99D-4B66-42AE-84F0-A4EAB6638C7D&ptype=iPhone8%2C1&os=9.3.1&ct=-1&kw=11001%3B-1&len=10&token=kDkC8zHbfbSRi%2Fx1suznf4hPjjcVTz3RxUJnBzuzqtg%3D"

@interface DetViewController ()<UITableViewDataSource,UITableViewDelegate>{

    DetTableViewCell *cell;
    UITableView *_tableView;
    NSMutableArray *imgURL;
    NSMutableArray *titleLabel;
    NSMutableArray *scCount;
    NSArray *urlArr;//链接数组
    BOOL isSelected;
}

@end

@implementation DetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

    //初始化数组
    imgURL = [NSMutableArray array];
    titleLabel = [NSMutableArray array];
    scCount = [NSMutableArray array];
    
    //请求网络数据
    [self _requestData];
    urlArr = @[@"200000191",@"200000183",@"200000171",@"200000136",@"200000100",@"200000088",@"200000102",@"200000094",@"200000060",@"200000428"];
}



- (void)_requestData{

    [LXNetWorkManager requestWithURL:BaseURL LXGETNetWorkType:LXGETNetWorkTypeWithGET pramas:nil target:nil action:nil showHUD:YES currentView:self.view successBlock:^(id respondeData) {
        NSDictionary *data = respondeData[@"data"];
        NSArray *articles = data[@"articles"];
        for (NSDictionary *dict in articles) {
            [imgURL addObject:dict[@"img"]];
            [titleLabel addObject:dict[@"preface"]];
            [scCount addObject:dict[@"favCount"]];
        }
        //刷新单元格
        [_tableView reloadData];
        
    } failureBlock:^(NSError *netError) {
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (titleLabel.count == 0) {
        return 10;
    }
    return titleLabel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell = [[[NSBundle mainBundle]loadNibNamed:@"DetTableViewCell" owner:self options:nil]lastObject];
    if (imgURL.count != 0) {
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:imgURL[indexPath.row]] placeholderImage:[[UIImage alloc] init]];

    }
    if (titleLabel.count != 0) {
        cell.titleLabel.text = titleLabel[indexPath.row];
    }
    if (scCount.count != 0) {
        cell.scCountLabel.text = [NSString stringWithFormat:@"%@",scCount[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *vc = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.baseURL = [NSString stringWithFormat:@"http://gf.zlapi.com/collection/view?cid=%@",urlArr[indexPath.row]];
    vc.scCount = [NSString stringWithFormat:@"%@",scCount[indexPath.row]];
    vc.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 217;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
   
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
