//
//  CQAddTagController.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQAddTagController.h"
#import "CQTagButton.h"
#import "CQTagTextField.h"
#import <SVProgressHUD.h>

@interface CQAddTagController ()<UITextFieldDelegate>

@property (weak, nonatomic)UIView *contentView;

@property (weak, nonatomic)CQTagTextField *textField;

@property (weak, nonatomic)UIButton *addTagBtn;

@property (strong, nonatomic)NSMutableArray *tagsBtnArray;

@property (assign, nonatomic)CGFloat placeholderWidth;


@end

@implementation CQAddTagController

#pragma mark - 懒加载
-(UIButton *)addTagBtn{
    if (_addTagBtn == nil) {
        UIButton *btn = [[UIButton alloc]init];
        btn.height = CQTagHeight;
        btn.width = self.contentView.width;
        btn.titleLabel.font = self.textField.font;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, CQTagMargin, 0, 0);
        btn.x = 0;
        btn.backgroundColor = CQTagBg ;
        [btn addTarget:self action:@selector(addTagClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        _addTagBtn = btn;
    }
    return _addTagBtn;
}

-(NSMutableArray *)tagsBtnArray{
    if (_tagsBtnArray == nil) {
        _tagsBtnArray = [NSMutableArray array];
    }
    return _tagsBtnArray;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CQGlobalBg;
    [self setupNav];
    [self setupContentView];
    
    for (NSInteger i = 0; i < self.tagStrArray.count; i++) {
        self.textField.text = self.tagStrArray[i];
        [self addTagClick:self.addTagBtn];
        
    }
    
    
}

-(void)setupNav{
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishClick)];
    
}

-(void)setupContentView{
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(CQTagMargin, 64 + CQTagMargin , SCREEN_WIDTH - 2 * CQTagMargin, SCREEN_HEIGHT)];
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    CQTagTextField *textField = [[CQTagTextField alloc]init];
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    textField.font = [UIFont systemFontOfSize:15];
    textField.height = CQTagHeight;
    textField.width = self.contentView.width;
    __weak typeof(self) weakSelf = self;
    textField.deleteTagBlock = ^{
        [weakSelf deleteTag:[weakSelf.tagsBtnArray lastObject]];

    };
    self.placeholderWidth =  [textField.placeholder sizeWithAttributes:@{NSFontAttributeName : textField.font}].width;
    textField.delegate = self;
    [textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:textField];
    self.textField = textField;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];

}


#pragma mark - 事件处理
-(void)finishClick{
    
    NSArray *tagsStrArray = [self.tagsBtnArray valueForKeyPath:@"currentTitle"];
    
    self.clickFinishBlock ? self.clickFinishBlock(tagsStrArray) : nil;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}



-(void)addTagClick:(UIButton *)btn{
    
    
    if (self.tagsBtnArray.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多只能添加5个" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    //创建按钮
    CQTagButton *tagBtn = [CQTagButton buttonWithType:UIButtonTypeCustom];
    [tagBtn setTitle:self.textField.text forState:UIControlStateNormal];
    [tagBtn addTarget:self action:@selector(deleteTag:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:tagBtn];
    [self.tagsBtnArray addObject:tagBtn];
    [self updateAddBtnFrame];
    [self updateTextFieldFrame];
    self.addTagBtn.hidden = YES;
    self.textField.text = nil;

}

#pragma mark 点击删除文字
-(void)deleteTag:(CQTagButton *)btn{
    [self.tagsBtnArray removeObject:btn];
    [btn removeFromSuperview];
    [UIView animateWithDuration:0.25 animations:^{
        [self updateAllTagBtnFrame];
        [self updateTextFieldFrame];
    }];
  
}



#pragma mark 文字发送改变
-(void)textDidChange:(CQTagTextField *)textField{
    self.addTagBtn.hidden = !textField.hasText;
    if (self.addTagBtn.isHidden) return;
    
    NSInteger textLength = textField.text.length;
    NSString *lastStr = [textField.text substringFromIndex:textLength - 1];
    if ([lastStr isEqualToString:@","]) {
        if (textLength == 1) {
            self.addTagBtn.y = CGRectGetMaxY(textField.frame) + CQTagMargin;

            return;
        }
        self.textField.text = [self.textField.text substringToIndex:textLength - 1];
        [self addTagClick:nil];
        return;
        
    }

    [self updateTextFieldFrame];
    self.addTagBtn.y = CGRectGetMaxY(textField.frame) + CQTagMargin;
    NSString *showMessage = [NSString stringWithFormat:@"添加标签 :%@",textField.text];
    [self.addTagBtn setTitle:showMessage forState:UIControlStateNormal];
}

#pragma mark - 私有方法
#pragma mark 更新btn的Frame
-(void)updateAddBtnFrame{
    NSInteger count = self.tagsBtnArray.count;
//    for (NSInteger i = 0; i < count ; i++) {
//        CQTagButton *tagBtn = self.tagsBtnArray[i];
//        if (i == 0) {//第一个
//            tagBtn.x = 0;
//            tagBtn.y = 0;
//        }else{
//            CQTagButton *lastTagBtn = self.tagsBtnArray[i - 1];
//            CGFloat useWidth = CGRectGetMaxX(lastTagBtn.frame);
//            CGFloat leftWidth = self.contentView.width - useWidth;
//            if (tagBtn.width + 2 * CQTagMargin > leftWidth ) {
//                tagBtn.x = 0;
//                tagBtn.y = CGRectGetMaxY(lastTagBtn.frame) + CQTagMargin;
//            }else{
//                tagBtn.x = useWidth + CQTagMargin;
//                tagBtn.y = lastTagBtn.y;
//            }
//
//        }
//    }
    if (count == 0) return;
    CQTagButton *lastTagBtn = [self.tagsBtnArray lastObject];
    if (count == 1) {
        lastTagBtn.x = 0;
        lastTagBtn.y = 0;
    }else{
        CQTagButton *preTagBtn = self.tagsBtnArray[count - 2];
        CGFloat useWidth = CGRectGetMaxX(preTagBtn.frame);
        CGFloat leftWidth = self.contentView.width - useWidth;
        if (lastTagBtn.width + 2 * CQTagMargin > leftWidth ) {
            lastTagBtn.x = 0;
            lastTagBtn.y = CGRectGetMaxY(preTagBtn.frame) + CQTagMargin;
        }else{
            lastTagBtn.x = useWidth + CQTagMargin;
            lastTagBtn.y = lastTagBtn.y;
        }
        
    }

}

#pragma mark 更新所有按钮Frame
-(void)updateAllTagBtnFrame{
    
    NSInteger count = self.tagsBtnArray.count;
    for (NSInteger i = 0; i < count ; i++) {
        CQTagButton *tagBtn = self.tagsBtnArray[i];
        if (i == 0) {//第一个
            tagBtn.x = 0;
            tagBtn.y = 0;
        }else{
            CQTagButton *lastTagBtn = self.tagsBtnArray[i - 1];
            CGFloat useWidth = CGRectGetMaxX(lastTagBtn.frame);
            CGFloat leftWidth = self.contentView.width - useWidth;
            if (tagBtn.width + 2 * CQTagMargin > leftWidth ) {
                tagBtn.x = 0;
                tagBtn.y = CGRectGetMaxY(lastTagBtn.frame) + CQTagMargin;
            }else{
                tagBtn.x = useWidth + CQTagMargin;
                tagBtn.y = lastTagBtn.y;
            }

        }
    }
}



-(void)updateTextFieldFrame{
    CQTagButton *lastTagBtn = [self.tagsBtnArray lastObject];
    CGFloat useWidth = CGRectGetMaxX(lastTagBtn.frame);
    CGFloat leftWidth = self.contentView.width - useWidth;
    
    if (_placeholderWidth + 2 * CQTagMargin > leftWidth || [self textFieldWidth] + 2 * CQTagMargin > leftWidth ) {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagBtn.frame) + CQTagMargin;
    }else{
        self.textField.x = useWidth + CQTagMargin;
        self.textField.y = lastTagBtn.y;
    }
    

}

-(CGFloat)textFieldWidth{
    return [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;

}



#pragma mark - 测试方法
-(void)dealloc{
    CQLogFunc;
}




@end
