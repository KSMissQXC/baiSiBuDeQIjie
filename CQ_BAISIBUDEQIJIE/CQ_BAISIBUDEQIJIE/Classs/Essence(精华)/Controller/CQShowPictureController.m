//
//  CQShowPictureController.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/9.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQShowPictureController.h"
#import "CQTopic.h"
#import "CQProgressView.h"
#import <UIImageView+WebCache.h>

@interface CQShowPictureController ()


@property (weak, nonatomic) IBOutlet UIImageView *showBigImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showImageHeight;
@property (weak, nonatomic) IBOutlet CQProgressView *progressView;



@end

@implementation CQShowPictureController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.showBigImage sd_setImageWithURL:[NSURL URLWithString:_topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        [self.progressView setProgress:(CGFloat)receivedSize / expectedSize  animated:YES];
    
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    CGFloat pictureH = SCREEN_WIDTH * _topic.height / _topic.width;
    self.showImageHeight.constant = pictureH;
    if (pictureH < SCREEN_HEIGHT) {
        [self.view layoutIfNeeded];//强制刷新
        self.showBigImage.y = (SCREEN_HEIGHT - pictureH) * 0.5;;
    }
}

#pragma mark - 事件处理
- (IBAction)backClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveClick:(UIButton *)sender {
    
    UIImageWriteToSavedPhotosAlbum(self.showBigImage.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

#pragma mark - 其它
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (!error) {
    }

}



@end
