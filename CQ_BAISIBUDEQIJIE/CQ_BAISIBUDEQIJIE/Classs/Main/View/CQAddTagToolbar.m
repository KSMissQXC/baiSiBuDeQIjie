//
//  CQAddTagToolbar.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQAddTagToolbar.h"
#import "CQAddTagController.h"


@interface CQAddTagToolbar ()

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic)UIButton *addBtn;
@property(nonatomic,strong)NSMutableArray *labelsArray;
@property (assign, nonatomic)CGFloat oldHeight;








@end

@implementation CQAddTagToolbar

#pragma mark - 懒加载
-(NSMutableArray *)labelsArray{
    if (_labelsArray == nil) {
        _labelsArray = [NSMutableArray array];
    }
    return _labelsArray;
    
}

#pragma mark - 初始化
-(void)awakeFromNib{
    
    UIButton *addBtn = [[UIButton alloc]init];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addBtn.size = addBtn.currentBackgroundImage.size;
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    addBtn.x = CQTagMargin;
    addBtn.y = CQTagMargin;
    self.addBtn = addBtn;
    [self addSubview:addBtn];
    [self addTagWithArray:@[@"幽默",@"搞笑"]];

}

#pragma mark - 点击事件
-(void)addBtnClick{
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController;
    __weak typeof(self) weakSelf = self;
    CQAddTagController *vc = [[CQAddTagController alloc]init];
    [vc setClickFinishBlock:^(NSArray *tagsArray) {
        
        [weakSelf addTagWithArray:tagsArray];
    }];
    vc.tagStrArray =[self.labelsArray valueForKeyPath:@"text"];
    [nav pushViewController:vc animated:YES];

}

-(void)addTagWithArray:(NSArray *)tagsArray{
    
    [self.labelsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.labelsArray removeAllObjects];
    NSInteger count = tagsArray.count;
    NSLog(@"%zd",count);
    for (NSInteger i = 0; i < count; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.text = tagsArray[i];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        label.width += 2 * CQTagMargin;
        label.height += 2 * CQTagMargin;
        label.backgroundColor = CQTagBg;
        [self.labelsArray addObject:label];
        [self.topView addSubview:label];
        if (i == 0) {
            label.x = CQTagMargin;
            label.y = CQTagMargin;
        }else{
            UILabel *lastLabel = self.labelsArray[i - 1];
            CGFloat useWidth = CGRectGetMaxX(lastLabel.frame);
            CGFloat leftWidth = self.topView.width - useWidth;
            if (label.width + 2 * CQTagMargin > leftWidth) {
                label.x = CQTagMargin;
                label.y = CGRectGetMaxY(lastLabel.frame) + CQTagMargin;
            }else{
                label.x = useWidth + CQTagMargin;
                label.y = lastLabel.y;
            }
            
        }
    }
    UILabel *lastLabel = [self.labelsArray lastObject];
    CGFloat useWidth = CGRectGetMaxX(lastLabel.frame);
    CGFloat leftWidth = CGRectGetMaxX(lastLabel.frame);
    if (self.addBtn.width + 2 * CQTagMargin > leftWidth) {
        self.addBtn.x = CQTagMargin;
        self.addBtn.y = CGRectGetMaxY(lastLabel.frame) + CQTagMargin;
    }else{
        self.addBtn.x = useWidth + CQTagMargin;
        self.addBtn.y = lastLabel.y;
    }
    
    self.oldHeight = self.height;
    self.height = MAX(CGRectGetMaxY(lastLabel.frame), CGRectGetMaxY(self.addBtn.frame))+ CQTagMargin + 35;
    self.y -= self.height - self.oldHeight;
    [self setNeedsLayout];

}





@end
