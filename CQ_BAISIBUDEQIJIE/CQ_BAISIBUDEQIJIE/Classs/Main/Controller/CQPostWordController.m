//
//  CQPostWordController.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQPostWordController.h"
#import "CQPlaceholderTextView.h"
#import "CQAddTagToolbar.h"

@interface CQPostWordController ()<UITextViewDelegate>

@property (weak, nonatomic)CQPlaceholderTextView *textView;
@property (weak, nonatomic)CQAddTagToolbar *tagToolbar;



@end

@implementation CQPostWordController


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = CQGlobalBg;

    [self setupNav];
    
    [self setupTextView];
    
}

-(void)setupNav{
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cacelClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(postWord)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationController.navigationBar layoutIfNeeded];
}

-(void)setupTextView{
    CQPlaceholderTextView *textView = [[CQPlaceholderTextView alloc]initWithFrame:self.view.bounds];
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    [self.view addSubview:textView];
    textView.delegate = self;
    self.textView = textView;
    [CQNotificationCenter addObserver:self selector:@selector(textDidFinishChange) name:UITextViewTextDidChangeNotification object:self.textView];
    
    CQAddTagToolbar *tagToolbar = [CQAddTagToolbar viewFromXib];
    tagToolbar.frame = CGRectMake(0, SCREEN_HEIGHT - tagToolbar.height, SCREEN_WIDTH, tagToolbar.height);
    self.tagToolbar = tagToolbar;
    [self.view addSubview:tagToolbar];
    
    [CQNotificationCenter addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];

}

-(void)viewWillDisappear:(BOOL)animated{
    [self.view endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [super viewWillDisappear:animated];
    });
}




#pragma mark - 事件处理
#pragma mark 点击返回
-(void)cacelClick{
    [self.view endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];

    });
}

#pragma mark 点击发布
-(void)postWord{

}

#pragma mark 监听到文字发送改变
-(void)textDidFinishChange{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

#pragma mark - 监听键盘Frame发生改变
-(void)keyboardChangeFrame:(NSNotification *)noti{
    
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect endFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        self.tagToolbar.transform = CGAffineTransformMakeTranslation(0,endFrame.origin.y - SCREEN_HEIGHT);
    }];

}


#pragma mark - 代理方法
#pragma mark scrollview代理
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}




#pragma mark - 测试方法
-(void)dealloc{
    CQLogFunc;
}












@end
