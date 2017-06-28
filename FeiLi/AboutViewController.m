//
//  AboutViewController.m
//  FeiLi
//
//  Created by lx on 16/4/12.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutTableViewCell.h"
#import "DataBase.h"
#import "UserModel.h"
@interface AboutViewController ()<UITableViewDelegate,UITableViewDataSource>{

    UITableView *_tableView;
    
    NSMutableArray *dataArr;
}

@end

@implementation AboutViewController



- (void)refreshUI{
    
    dataArr = [[DataBase shareManager] getUser];
    //刷新页面
    [_tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
   [self refreshUI];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"关于非礼";
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, KscreenWidth, 300)];
    _tableView.backgroundColor = [UIColor whiteColor];
    //取消分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    dataArr = [NSMutableArray array];
    
    UIButton *delBut = [UIButton buttonWithType:UIButtonTypeCustom];
    delBut.frame = CGRectMake(100, 80, 44, 44);
    [delBut setTitle:@"delete" forState:UIControlStateNormal];
    [delBut setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:delBut];
    [delBut addTarget:self action:@selector(deleteUser) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *updataNameBut = [UIButton buttonWithType:UIButtonTypeCustom];
    updataNameBut.frame = CGRectMake(200, 80, 44, 44);
    [updataNameBut setTitle:@"updataName" forState:UIControlStateNormal];
    [updataNameBut setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:updataNameBut];
    [updataNameBut addTarget:self action:@selector(updataNameUser) forControlEvents:UIControlEventTouchUpInside];
}

- (void)deleteUser{

    [[DataBase shareManager] deleteUser];
    [self refreshUI];
}

- (void)updataNameUser{

    [[DataBase shareManager] updataNameUser];
    [self refreshUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserModel *model = [dataArr objectAtIndex:indexPath.row];
    AboutTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"AboutFeiLi" owner:self options:nil]lastObject];
    cell.nickName.text = model.nickName;
    cell.pingLun.text = model.pingLun;
    //设置单元格的点击状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10;
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
