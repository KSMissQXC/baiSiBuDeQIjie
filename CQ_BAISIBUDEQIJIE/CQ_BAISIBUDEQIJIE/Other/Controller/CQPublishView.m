//
//  CQPublishView.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQPublishView.h"
#import "CQVerticalBtn.h"
#import <POP.h>

static CGFloat const CQAnimationDelay = 0.1;
static CGFloat const CQSpringFactor = 10;

@interface CQPublishView ()

@property (weak, nonatomic)UIImageView *sloganView;


@end

@implementation CQPublishView


static UIWindow *window_;

+(instancetype)publishView{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

-(void)awakeFromNib{
    [self setupView];
}





+(void)show{
    window_ = [[UIWindow alloc]init];
    window_.frame = [UIScreen mainScreen].bounds;
    window_.windowLevel = UIWindowLevelStatusBar;
    window_.userInteractionEnabled = NO;
    window_.hidden = NO;
    CQPublishView *v = [self publishView];
    v.frame = window_.bounds;
    [window_ addSubview:v];

}



-(void)setupView{
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    //添加6个按钮
    int maxCols = 3;
    CGFloat btnW = 72;
    CGFloat btnH = btnW + 30;
    CGFloat btnStartY = (SCREEN_HEIGHT - 2 * btnH) * 0.5;
    CGFloat btnStartX = 20;
    CGFloat xMargin = (SCREEN_WIDTH - 2 * btnStartX - maxCols * btnW) / (maxCols - 1);
    for (NSInteger i = 0; i < images.count; i++) {
        CQVerticalBtn *btn = [[CQVerticalBtn alloc]init];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(typeClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat btnEndX = btnStartX + i % 3 * (btnW + xMargin);
        CGFloat btnEndY = btnStartY + i / 3 * (btnH + xMargin);
//        CGFloat btnAnimationStartX = btnEndX - SCREEN_HEIGHT;
        CGFloat btnAnimationStartY = btnEndY - SCREEN_HEIGHT;
        
        // 图片动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(btnEndX, btnAnimationStartY, btnW, btnH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(btnEndX, btnEndY, btnW, btnH)];
        anim.beginTime = CACurrentMediaTime() + i * CQAnimationDelay;
        anim.springBounciness = CQSpringFactor;
        anim.springSpeed = CQSpringFactor;
        
//        if (i == images.count - 1) {
//            [anim setCompletionBlock:^(POPAnimation *ani, BOOL finish) {
//                self.sloganView.hidden = NO;
//            }];
//        }
       
        [btn pop_addAnimation:anim forKey:nil];
        [self addSubview:btn];
    }
    
    
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    //    sloganView.y = SCREEN_HEIGHT * 0.2;
    //    sloganView.centerX = SCREEN_WIDTH * 0.5;
    self.sloganView = sloganView;
    CGFloat sloganViewEndCenterY = SCREEN_HEIGHT * 0.2;
    CGFloat sloganViewStartCenterY = sloganViewEndCenterY - SCREEN_HEIGHT;
    CGFloat sloganViewCenterX = SCREEN_WIDTH * 0.5;
    sloganView.x = -300;
    
    // 标语动画
    POPSpringAnimation *anime = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anime.fromValue = [NSValue valueWithCGPoint:CGPointMake(sloganViewCenterX, sloganViewStartCenterY)];
    anime.toValue = [NSValue valueWithCGPoint:CGPointMake(sloganViewCenterX, sloganViewEndCenterY)];
    [anime setCompletionBlock:^(POPAnimation * ani, BOOL finish) {
        window_.userInteractionEnabled = YES;
        
        
    }];
    anime.beginTime = CACurrentMediaTime() + images.count  * CQAnimationDelay;
    anime.springBounciness = CQSpringFactor;
    anime.springSpeed = CQSpringFactor;
    [sloganView pop_addAnimation:anime forKey:nil];
    [self addSubview:sloganView];
 
}



- (IBAction)cancelClick:(UIButton *)sender {
    
    [self cacelClickWithFinishBlock:nil];
}


-(void)cacelClickWithFinishBlock:(void (^)())finishBlock{
    int beginIndex = 2;
    for (int i = beginIndex; i < self.subviews.count; i++) {
        UIView *subView = self.subviews[i];
        //基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subView.centerY + SCREEN_HEIGHT;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * CQAnimationDelay;
        [subView pop_addAnimation:anim forKey:nil];
        if (i == self.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *ani, BOOL finish) {
                window_.hidden = YES;
                window_ = nil;
                
            }];
            
            
        }
        
    }
}


-(void)typeClick:(CQVerticalBtn *)btn{
    [self cacelClickWithFinishBlock:^{
        NSLog(@"%s",__func__);
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cacelClickWithFinishBlock:nil];
}







@end

