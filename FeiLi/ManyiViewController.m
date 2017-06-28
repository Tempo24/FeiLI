//
//  ManyiViewController.m
//  FeiLi
//
//  Created by lx on 16/4/11.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "ManyiViewController.h"

@interface ManyiViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_tableView;
    NSInteger currtentIndex;
    UIButton *button;
}

@end

@implementation ManyiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"满意度调查";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    //给尾视图一个没有高度的视图，去掉假格子
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [button addTarget:self action:@selector(ClickAction) forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *_arr = @[@"你在多大程度上愿意向你的朋友推荐非礼ios版？",@"10分（非常满意）",@"9分",@"8分",@"7分",@"6分",@"5（分）",@"4分",@"3分",@"2分",@"1分",@"0分（绝对不会）"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = _arr[indexPath.row];
    if (indexPath.row == 0) {
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return;
    }
    currtentIndex = indexPath.row;
    [_tableView reloadData];
}


- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    if (currtentIndex == indexPath.row && currtentIndex != 0) {
        return UITableViewCellAccessoryCheckmark;
    }else
        return UITableViewCellAccessoryNone;
}

- (void)ClickAction{

    [self.navigationController popViewControllerAnimated:YES];
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
