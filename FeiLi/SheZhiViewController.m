//
//  SheZhiViewController.m
//  FeiLi
//
//  Created by lx on 16/4/11.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "SheZhiViewController.h"
#import "ManyiViewController.h"
#import "WentiViewController.h"
#import "AboutViewController.h"
#import "LoginViewController.h"

@interface SheZhiViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>{

    UITableView *_tableView;
    UIActionSheet *sheet;
}

@end

@implementation SheZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        
        return 3;
    }else{
    
        return 1;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = @[@"满意度调查",@"问题反馈",@"关于非礼"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"清理缓存";
    }else if (indexPath.section == 1){
        cell.textLabel.text = arr[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
    }
    //设置点击样式为None
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要清除所有缓存吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ManyiViewController *vc = [[ManyiViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
           
        }else if (indexPath.row == 1){
            WentiViewController *vc1 = [[WentiViewController alloc]init];
            [self.navigationController pushViewController:vc1 animated:YES];
            
        }else{
            AboutViewController *vc2 = [[AboutViewController alloc]init];
            [self.navigationController pushViewController:vc2 animated:YES];
            
        }
    }else if (indexPath.section == 2){
        
       sheet = [[UIActionSheet alloc]initWithTitle:@"真的要退出吗" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出" otherButtonTitles:nil, nil];
            [sheet showInView:self.view];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        
        LoginViewController *vc = [[LoginViewController alloc]init];
        
        [self presentViewController:vc animated:YES completion:^{
            //在模态到LoginVC页面时，后台同时执行这两句代码
            self.tabBarController.selectedIndex = 0;//回到标签栏索引为0的控制器
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }];
    }else{
        
        return;
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
