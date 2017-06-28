 //
//  DetailViewController.m
//  FeiLi
//
//  Created by lx on 16/4/17.
//  Copyright (c) 2016年 lx. All rights reserved.
//

/*
 这个页面是最后的详情页面，不管是从哪个路径走到这里，
 详情显示的样式风格是一样的，所以最后都push到这个页面，
 只是链接不一样
 */

#import "DetailViewController.h"
#import "DetailTableViewCell.h"
#import "WodeViewController.h"
#import "WXApi.h"
@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UIView *bottomView;
    BOOL isSelected;
    UIImageView *scImgView;
    UILabel *label;
    UITableView *_tableView;
    DetailTableViewCell *cell;
    
    NSArray *topImageViewURL;
    NSString *avatar;
    NSString *nickName;
    NSString *time;
    NSString *title;
    NSString *content;
//--------------------------
    NSMutableArray *subTitle;
    NSMutableArray *summaryContent;
    NSMutableArray *subImageViewURL;
    NSMutableArray *moneyArr;
    
    
}

@end
NSString *const tableViewCellID = @"tableViewCell";
@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, KscreenWidth, KscreenHeight-20) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, KscreenHeight-50, KscreenWidth, 50)];
    bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 5, 40, 40);
    backButton.backgroundColor = [UIColor blackColor];
    backButton.layer.cornerRadius = 20;
    backButton.clipsToBounds = YES;
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [bottomView addSubview:backButton];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(KscreenWidth-100, 5, 40, 40);
    shareButton.backgroundColor = [UIColor blackColor];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    shareButton.layer.cornerRadius = 20;
    shareButton.clipsToBounds = YES;
    [bottomView addSubview:shareButton];
    [shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shouCangButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shouCangButton.frame = CGRectMake(KscreenWidth-50, 5, 40, 40);
    shouCangButton.backgroundColor = [UIColor blackColor];
    shouCangButton.layer.cornerRadius = 20;
    shouCangButton.clipsToBounds = YES;
    [bottomView addSubview:shouCangButton];
    [shouCangButton addTarget:self action:@selector(shouCangAction:) forControlEvents:UIControlEventTouchUpInside];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(5, 25, 30, 10)];
    label.text = _scCount;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    [shouCangButton addSubview:label];
    
    
    scImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    scImgView.backgroundColor = [UIColor clearColor];
    scImgView.image = [UIImage imageNamed:@"sc.jpg"];
    [shouCangButton addSubview:scImgView];
    
    subTitle = [NSMutableArray array];
    summaryContent = [NSMutableArray array];
    subImageViewURL = [NSMutableArray array];
    moneyArr = [NSMutableArray array];
    //网络请求数据
    [self _requstData];
    
}



- (void)_requstData{
    
    [LXNetWorkManager requestWithURL:_baseURL LXGETNetWorkType:LXGETNetWorkTypeWithGET pramas:nil target:nil action:nil showHUD:YES currentView:self.view successBlock:^(id respondeData) {
        
        NSDictionary *dic1 = respondeData[@"data"];
        
        NSDictionary *dic2 = dic1[@"author"];
        
        avatar = dic2[@"avatar"];
        nickName = dic2[@"nickName"];
        
        
        
        long long times = [dic1[@"time"] longLongValue]/1000;//秒
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:times];
        
        NSDateFormatter *form = [[NSDateFormatter alloc] init];
        
        form.dateFormat = @"yyyy-MM-dd";
        
       NSString *sj = [form stringFromDate:date];
        
//        int minutes = (int)times / 60;//分
//        int hours = minutes / 60;//小时
//        int days = hours / 24;//天
//        int year = days / 365 + 1970;//年
//        int month = (days % 365) / 30;//月
//        int day = ((days % 365) % 30 );//日
//        NSLog(@"%04d/%02d/%02d",year,month,day);
//        time = [NSString stringWithFormat:@"%04d/%02d/%02d",year,month,day];
        time = sj;
        topImageViewURL = dic1[@"imgs"];
        title = dic1[@"title"];
        NSArray *arr = dic1[@"intro"];
        NSDictionary *dic4 = arr[0];
        content = dic4[@"content"];
        
        //--------------------下面部分----------------
        
        NSArray *arr1 = dic1[@"gifts"];
        for (NSDictionary *dict in arr1) {
            [subTitle addObject:dict[@"name"]];
            [moneyArr addObject:dict[@"price"]];
            NSArray *arr2 = dict[@"summary"];
            
            for (NSDictionary *dic in arr2) {
                if ([dic[@"type"] intValue] == 0 ) {
                    [summaryContent addObject:dic[@"content"]];
                } else {
                    [subImageViewURL addObject:dic[@"content"]];
                    if (summaryContent.count == 0) {
                        break;
                    }
                    
                }
            }
            
        }
//        NSLog(@"-----------%ld", subTitle.count);
//        NSLog(@"---------%ld",summaryContent.count);
        [_tableView reloadData];

    } failureBlock:^(NSError *netError) {
        
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (subTitle.count == 0) {
        return 10;
    }
    return subTitle.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"tableViewHeadView" owner:self options:nil]lastObject];
        if (topImageViewURL != nil) {
            [cell.topImageView sd_setImageWithURL:[NSURL URLWithString:[topImageViewURL lastObject]]];
        }
        if (avatar != nil) {
            [cell.avatar sd_setImageWithURL:[NSURL URLWithString:avatar]];
            cell.avatar.layer.cornerRadius = 20;
            cell.avatar.clipsToBounds = YES;
        }
        if (nickName != nil) {
            cell.nickName.text = nickName;
        }
        if (time != nil) {
            cell.time.text = time;
        }
        if (title != nil) {
            cell.title.text = title;
        }
        if (content != nil) {
            cell.introContent.text = content;
        }
        
        
    }else{
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DetailTableViewCell" owner:self options:nil]lastObject];
        cell.numLabel.text = [NSString stringWithFormat:@"0%ld",(long)indexPath.row];
        
        if (summaryContent.count != 0) {
            NSLog(@"%ld", (long)indexPath.row);
                cell.summaryContent.text = summaryContent[indexPath.row-1];
            
        }
        if (subTitle.count != 0) {
            cell.subTitle.text = subTitle[indexPath.row-1];
        }
        if (subImageViewURL.count != 0) {
            [cell.subImageView sd_setImageWithURL:[NSURL URLWithString:subImageViewURL[indexPath.row-1]] placeholderImage:[[UIImage alloc]init]];
        }
        if (moneyArr.count != 0) {
            cell.moneyLabel.text = [NSString stringWithFormat:@"%@",moneyArr[indexPath.row-1]];
        }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 550;
    }
    return 600;
}


- (void)backAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareAction:(UIButton *)button{

//    UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:NULL applicationActivities:nil];
//    [self presentViewController:vc animated:YES completion:nil];
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
//    req.text = @"这是非礼";
//    req.bText = YES;
//    req.scene = WXSceneSession;
//    [WXApi sendReq:req];
    
    //-----可用直接传图片，也可以通过filePath来获取
    WXMediaMessage *message = [WXMediaMessage message];
   
//    [message setThumbImage:[UIImage imageNamed:@"test.png"]];
    
    WXImageObject *ext = [WXImageObject object];
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"png"];
//    
//    ext.imageData = [NSData dataWithContentsOfFile:filePath];
    
//    UIImage* image = [UIImage imageWithData:ext.imageData];
    UIImage *image = [UIImage imageNamed:@"test.png"];
    ext.imageData = UIImagePNGRepresentation(image);
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
    
    
//    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//    req.text = @"文本内容";
//    req.bText = YES;
//    req.scene = WXSceneSession;
//    
//    [WXApi sendReq:req];
    [WXApi registerApp:@"wx96c53aa75a09b1d3"];
}

- (void)shouCangAction:(UIButton *)button{
    isSelected = !isSelected;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if (isSelected) {
        scImgView.image = [UIImage imageNamed:@"sc-hight.jpg"];
        int num = [label.text intValue];
        num += 1;
        label.text = [NSString stringWithFormat:@"%d",num];
        
    }else{
       scImgView.image = [UIImage imageNamed:@"sc.jpg"];
        int num = [label.text intValue];
        num -= 1;
        label.text = [NSString stringWithFormat:@"%d",num];
    }
    
    
    [user synchronize];
}
//开始拖拽视图
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    bottomView.hidden = YES;
    [self _bottomViewDisappear];
}

//完成拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    bottomView.hidden = NO;
    [self _bottomViewAppear];
}
//将开始降速时
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    bottomView.hidden = YES;
    [self _bottomViewDisappear];
}
//减速停止了执行，手触摸时执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    bottomView.hidden = NO;
    [self _bottomViewAppear];
}

//视图出现动画
- (void)_bottomViewAppear{

    CATransition *transition = [CATransition animation];
    transition.type = @"push";
    transition.subtype = @"fromTop";
    [bottomView.layer addAnimation:transition forKey:nil];
}
//视图消失动画
- (void)_bottomViewDisappear{
    CATransition *transition = [CATransition animation];
    transition.type = @"push";
    transition.subtype = @"fromBottom";
    [bottomView.layer addAnimation:transition forKey:nil];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
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
