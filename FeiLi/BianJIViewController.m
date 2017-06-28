//
//  BianJIViewController.m
//  FeiLi
//
//  Created by lx on 16/4/13.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "BianJIViewController.h"

@interface BianJIViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

    UITextField *textField;
    UIActionSheet *Sheet;
    UIButton *imgButton;
    BOOL isSelected;
    UIButton *button;
}

@end

@implementation BianJIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Sheet.delegate = self;
    textField.delegate = self;
    self.title = @"编辑资料";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    imgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imgButton.frame = CGRectMake((KscreenWidth-70)/2, 100, 70, 70);
    [imgButton setImage:_UserImage forState:UIControlStateNormal];
    imgButton.layer.cornerRadius = 35;
    imgButton.clipsToBounds = YES;
    [self.view addSubview:imgButton];
    [imgButton addTarget:self action:@selector(imgButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [path objectAtIndex:0];
    NSString *imgDocumentPath = [documentPath stringByAppendingPathComponent:@"imgFile"];
    [[NSFileManager defaultManager]createDirectoryAtPath:imgDocumentPath withIntermediateDirectories:YES attributes:nil error:nil];
    _imgName = [imgDocumentPath stringByAppendingPathComponent:@"image.png"];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 200, KscreenWidth, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    label.text = @"昵称";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:16];
    [view addSubview:label];
    
    textField = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, KscreenWidth-170, 40)];
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.text = _userName;
    textField.placeholder = @"2-8个汉字或4-16个英文";
    textField.textAlignment = NSTextAlignmentCenter;
    textField.borderStyle = UITextBorderStyleNone;
    [view addSubview:textField];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonItem;
    [button addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;

    
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [textField resignFirstResponder];
    
}


- (void)ClickButton:(UIButton *)but{
    _block(textField.text);
    _block1(_imgName);
    [self.navigationController popViewControllerAnimated:YES];
   
}

- (void)imgButtonAction:(UIButton *)button{

    Sheet = [[UIActionSheet alloc]initWithTitle:@"选择头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"选择已有照片", nil];
    [Sheet showInView:self.view];

    
}



- (void)willPresentActionSheet:(UIActionSheet *)actionSheet{
    


    for (UIView *subView in actionSheet.subviews) {

        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *but = (UIButton *)subView;
            [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [but setBackgroundColor:[UIColor yellowColor]];
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{

    switch (buttonIndex) {
        case 0:
            //拍照
            [self takePhoto];
            break;
        case 1:
            //从相册选择
            [self localPhoto];
            break;
            
        default:
            break;
    }

}

- (void)takePhoto{

    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        //[self presentModalViewController:picker animated:YES];
        [self presentViewController:picker animated:YES completion:nil];
    }else
        NSLog(@"该设备没有摄像头");
    
    
}

- (void)localPhoto{

    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    //[self presentModalViewController:picker animated:YES];
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    
    if (image != nil) {
        [imgButton setImage:image forState:UIControlStateNormal];
        NSData *data;
        if (UIImagePNGRepresentation(image)) {
            data = UIImagePNGRepresentation(image);
        }else{
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        
        [[NSFileManager defaultManager]createFileAtPath:_imgName contents:data attributes:nil];
        
    }
    
    //[picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
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
