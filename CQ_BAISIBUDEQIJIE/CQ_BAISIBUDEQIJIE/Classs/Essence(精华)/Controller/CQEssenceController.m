//
//  CQEssenceController.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by 廖启旋 on 16/4/30.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQEssenceController.h"
#import "CQTextController.h"
#import "CQRecommendTagsController.h"
#import "CQTopicController.h"


@interface CQEssenceController ()<UIScrollViewDelegate>
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 记录选中的button */
@property (weak, nonatomic)UIButton *tempBtn;
/** 顶部title */
@property (weak, nonatomic)UIView *titleView;

@property (weak, nonatomic)UIScrollView *contentScroView;


@end

@implementation CQEssenceController

#pragma mark - 懒加载
-(UIScrollView *)contentScroView{
    if (_contentScroView == nil) {
        UIScrollView *scro = [[UIScrollView alloc]init];
        scro.backgroundColor = [UIColor clearColor];
        scro.frame = [UIScreen mainScreen].bounds;
        scro.delegate = self;
        scro.pagingEnabled = YES;
        [self.view addSubview:scro];
        _contentScroView = scro;
    }
    return _contentScroView;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNav];
    [self setupContentView];
    [self setupTitlesView];
}

-(void)setupNav{
    self.view.backgroundColor = CQGlobalBg;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self sel:@selector(leftClick) imageName:@"MainTagSubIcon" highImageName:@"MainTagSubIconClick"];
    
}

-(void)setupContentView{
    CQTopicController *allVc = [[CQTopicController alloc]init];
    allVc.title = @"全部";
    allVc.topicType = CQTopicControllerTypeAll;
    [self addChildViewController:allVc];
    
    CQTopicController *videoVc = [[CQTopicController alloc]init];
    videoVc.title = @"视频";
    videoVc.topicType = CQTopicControllerTypeVideo;
    [self addChildViewController:videoVc];
    
    CQTopicController *soundVc = [[CQTopicController alloc]init];
    soundVc.title = @"声音";
    soundVc.topicType = CQTopicControllerTypeVoice;
    [self addChildViewController:soundVc];
    
    CQTopicController *pictureVc = [[CQTopicController alloc]init];
    pictureVc.title = @"图片";
    pictureVc.topicType = CQTopicControllerTypePicture;
    [self addChildViewController:pictureVc];

    CQTopicController *wordVc = [[CQTopicController alloc]init];
    wordVc.title = @"段子";
    wordVc.topicType = CQTopicControllerTypeWord;
    [self addChildViewController:wordVc];
    self.contentScroView.contentSize = CGSizeMake(self.childViewControllers.count * SCREEN_WIDTH , 0);
   

}

-(void)setupTitlesView{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, CQTitleViewsY, self.view.width,CQTitleViewsHeight)];
    titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    NSInteger count = self.childViewControllers.count;
    CGFloat width = self.view.width / count;
    CGFloat height = titleView.height;

    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    self.indicatorView = indicatorView;

    for (NSInteger i = 0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [btn setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        btn.x = i * width;
        btn.y = 0;
        btn.width = width;
        btn.height = height - 2;
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleView addSubview:btn];
        if (i == 0) {
            [btn.titleLabel sizeToFit];
            self.tempBtn = btn;
            btn.enabled = NO;
            indicatorView.width = btn.titleLabel.width;
            indicatorView.y = height - 2;
            indicatorView.centerX = btn.centerX;
            [self scrollViewDidEndScrollingAnimation:self.contentScroView];
        }
    }
    [titleView addSubview:indicatorView];
}


#pragma mark - 事件处理
#pragma mark 点击顶部标题
-(void)titleClick:(UIButton *)btn{
    self.tempBtn.enabled = YES;
    btn.enabled = NO;
    self.tempBtn = btn;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = btn.titleLabel.width;
        self.indicatorView.centerX = btn.centerX;
    }];
    CGPoint offset = CGPointMake(btn.tag * SCREEN_WIDTH, 0);
    [self.contentScroView setContentOffset:offset animated:YES];

}

-(void)leftClick{
    CQRecommendTagsController *vc = [[CQRecommendTagsController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 代理
#pragma mark scrollview代理
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    NSInteger index = offset.x / SCREEN_WIDTH;
    UIViewController *vc = self.childViewControllers[index];
    if (vc.isViewLoaded) return;
    vc.view.frame = CGRectMake(offset.x, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.contentScroView addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    CGPoint offset = scrollView.contentOffset;
    NSInteger index = offset.x / SCREEN_WIDTH;
    [self titleClick:self.titleView.subviews[index]];

}

@end
