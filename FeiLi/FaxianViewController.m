//
//  FaxianViewController.m
//  FeiLi
//
//  Created by lx on 16/4/9.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "FaxianViewController.h"
#import "TableViewCell.h"
#import "subView.h"
#import "MyDataModel.h"
#import "DetViewController.h"
#import "textPushView.h"

@interface FaxianViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSMutableArray *_dataArray;
    NSMutableArray *_arr;
    NSMutableArray *_arr2;
    NSMutableArray *_arr3;
    NSMutableArray *_arr4;
    NSMutableArray *_arr5;
    NSMutableArray *_arr6;
    NSMutableArray *_arr7;
    NSMutableArray *_arr8;
    
     CGFloat lastContentOffset;
}

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) subView *sbView;

@end

@implementation FaxianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(5, 40, KscreenWidth-10, KscreenHeight-40) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    //去掉分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    subView *sbView = [[subView alloc]init];
    _tableView.tableHeaderView = sbView;
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(5, 69, self.view.bounds.size.width-10, 35)];

    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor groupTableViewBackgroundColor];
    textField.placeholder = @"搜索攻略";
    textField.textAlignment = NSTextAlignmentCenter;
    
    [textField addTarget:self action:@selector(textFieldClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:textField];
    
    array = [NSArray array];
    array = @[@"运动健康",@"数码3C",@"服饰箱包",@"美妆个护",@"生活家居",@"美食饮品",@"母婴玩具",@"更多分类"];
    array2 = [NSArray array];
    array2 = @[@"生日",@"结婚",@"圣诞节",@"感谢",@"乔迁"];
    array3 = [NSArray array];
    array3 = @[@"情人节",@"纪念日",@"新年",@"祝贺",@"道歉"];
    
    _arr = [NSMutableArray arrayWithObjects:@"全部",@"运动鞋包",@"运动服饰",@"健身训练",@"骑行运动",@"户外鞋服",@"户外装备",@"游泳用品",@"体育用品", nil];
    _arr2 = [NSMutableArray arrayWithObjects:@"全部",@"摄影摄像",@"数码周边",@"影音娱乐",@"智能设备",@"手机",@"电脑", nil];
    _arr3 = [NSMutableArray arrayWithObjects:@"全部",@"女装",@"女鞋",@"内衣",@"珠宝配饰",@"男装",@"男鞋",@"箱包",@"钟表",@"奢侈品", nil];
    _arr4 = [NSMutableArray arrayWithObjects:@"全部",@"香水彩妆",@"面部护肤",@"洗发护发",@"身体护理",@"男士护理",@"口腔护理", nil];
    _arr5 = [NSMutableArray arrayWithObjects:@"全部",@"家电",@"家具",@"家纺",@"装饰摆设",@"灯饰",@"厨具",@"日用", nil];
    _arr6 = [NSMutableArray arrayWithObjects:@"全部",@"酒类",@"茗茶",@"饮料冲调",@"烘焙甜品",@"健康营养",@"休闲零食",@"蔬果生鲜",@"粮油调味",@"烟类", nil];
    _arr7 = [NSMutableArray arrayWithObjects:@"全部",@"玩具乐器",@"婴儿用品",@"童鞋童装", nil];
    _arr8 = [NSMutableArray arrayWithObjects:@"全部",@"办公",@"汽车用品",@"宠物生活",@"营养保健",@"图书音像", nil];
    
    _dataArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 13; i++) {
        MyDataModel *DataModel = [[MyDataModel alloc]init];
        for (int j = 0; j < _arr.count; j++) {
            [DataModel.array addObject:_arr[j]];
        }
        [_dataArray addObject:DataModel];
    }
    
    

}

- (void)textFieldClick{
    textPushView *textVC = [[textPushView alloc]init];
    [self showDetailViewController:textVC sender:nil];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    MyDataModel *dataModel = [_dataArray objectAtIndex:section];
    if ([dataModel isShow]) {
        if (section == 0) {
            return 9;
        }else if(section == 1){
            return 7;
        }else if(section == 2){
            return 10;
        }else if (section == 3){
            return 7;
        }else if (section == 4){
            return 8;
        }else if (section == 5){
            return 10;
        }else if (section == 6){
            return 4;
        }else if (section == 7){
            return 6;
        }else{
            return 1;
        }

    }else{
        if (section > 7) {
            return 1;
        }
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

    }
    
    if (indexPath.section < 8) {
        
        cell.lable.hidden = NO;
        cell.leftButton.hidden = YES;
        cell.rightButton.hidden = YES;
        if (indexPath.section == 0) {
            cell.lable.text = _arr[indexPath.row];
        }else if (indexPath.section == 1){
            cell.lable.text = _arr2[indexPath.row];
        }else if (indexPath.section == 2){
            cell.lable.text = _arr3[indexPath.row];
        }else if (indexPath.section == 3){
            cell.lable.text = _arr4[indexPath.row];
        }else if (indexPath.section == 4){
            cell.lable.text = _arr5[indexPath.row];
        }else if (indexPath.section == 5){
            cell.lable.text = _arr6[indexPath.row];
        }else if (indexPath.section == 6){
            cell.lable.text = _arr7[indexPath.row];
        }else if (indexPath.section == 7){
            cell.lable.text = _arr8[indexPath.row];
        }
 
    }else{
        cell.lable.hidden = YES;
        cell.leftButton.hidden = NO;
        cell.rightButton.hidden = NO;
        cell.leftButLabel.text = array2[indexPath.section-8];
        [cell.leftButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",indexPath.section-8+4001]] forState:UIControlStateNormal];
        cell.rightButLabel.text = array3[indexPath.section-8];
        [cell.rightButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",indexPath.section-8+40001]] forState:UIControlStateNormal];
    }
    //设置点击状态为none
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.leftButton.tag = indexPath.section;
    cell.rightButton.tag = indexPath.section;

    [cell.leftButton addTarget:self action:@selector(leftButClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.rightButton addTarget:self action:@selector(rightButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    DetViewController *VC = [[DetViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
    VC.tabBarController.tabBar.hidden = YES;
    if (indexPath.section == 0) {
        VC.title = _arr[indexPath.row];
    }else if(indexPath.section == 1){
        VC.title = _arr2[indexPath.row];
    }else if(indexPath.section == 2){
        VC.title = _arr3[indexPath.row];
    }else if (indexPath.section == 3){
        VC.title = _arr4[indexPath.row];
    }else if (indexPath.section == 4){
        VC.title = _arr5[indexPath.row];
    }else if (indexPath.section == 5){
        VC.title = _arr6[indexPath.row];
    }else if (indexPath.section == 6){
        VC.title = _arr7[indexPath.row];
    }else if (indexPath.section == 7){
        VC.title = _arr8[indexPath.row];
    }
    

}


//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < 8) {
        return 40;
    }else{
        return 100;
    }
    
}

//头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
        
    if (section < 8) {
        _sbView = [[[NSBundle mainBundle]loadNibNamed:@"headView" owner:self options:nil]lastObject];
        [tableView.tableHeaderView addSubview:_sbView];
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(0, 0, _sbView.frame.size.width, _sbView.frame.size.height);
        _btn.backgroundColor = [UIColor clearColor];
        _btn.tag = section;
        _sbView.nameLabel.text = array[section];
        
        NSString *imgName = [NSString stringWithFormat:@"%d",11001+section];
        UIImage *image = [UIImage imageNamed:imgName];
        _sbView.imgView.image = image;
        
    }
    
    [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_sbView addSubview:_btn];
    
    return _sbView;
}

//开始拖拽视图
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.tabBarController.tabBar.hidden = YES;
   
    NSLog(@"又拽");
}

//完成拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.tabBarController.tabBar.hidden = NO;
    
}
//将开始降速时
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    self.tabBarController.tabBar.hidden = YES;
}
//减速停止了执行，手触摸时执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.tabBarController.tabBar.hidden = NO;
    
}




- (void)btnClick:(UIButton *)btn{

    MyDataModel *data = [_dataArray objectAtIndex:btn.tag];
    // 改变组的显示状态
    if ([data isShow]) {
        [data setIsShow:NO];
    }else{
        [data setIsShow:YES];
    }
    // 刷新点击的组标题，动画使用卡片
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationFade];
}

//头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section < 8) {
        return kcellHeight;
    }else{
        return 0;
    }
    
}

- (void)leftButClick:(UIButton *)button{
    DetViewController *detailVC = [[DetViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
    detailVC.title = array2[button.tag-8];
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)rightButClick:(UIButton *)button{
     DetViewController *detailVC = [[DetViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
    detailVC.title = array3[button.tag-8];
    self.tabBarController.tabBar.hidden = YES;
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
