//
//  CQTopicPictureView.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by 廖启旋 on 16/5/7.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQTopicPictureView.h"
#import "CQTopic.h"
#import "CQProgressView.h"
#import "CQShowPictureController.h"
#import <UIImageView+WebCache.h>


@interface CQTopicPictureView ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@property (weak, nonatomic) IBOutlet CQProgressView *progressView;


@end

@implementation CQTopicPictureView

#pragma mark - 初始化
+(instancetype)topicPictureView{
    
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [self.imageView addGestureRecognizer:tap];
    
}

-(void)setTopic:(CQTopic *)topic{
    _topic = topic;
    self.frame = topic.pictureF;
    NSString *extion = [topic.large_image pathExtension];
    self.gifView.hidden = ![extion.lowercaseString isEqualToString:@"gif"];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
        CGFloat progress = (CGFloat)receivedSize / expectedSize;
        [self.progressView setProgress:progress  animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        if (!topic.isBigImage) return ;
        //开启图形上下文,范围为需要显示的范围
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0);
        
        CGFloat imageWidth = topic.pictureF.size.width;
        CGFloat imageHeight = imageWidth * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, imageWidth, imageHeight)];
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }];
    self.seeBigButton.hidden = !topic.isBigImage;
    
}



#pragma mark - 事件处理
-(void)tapClick:(UITapGestureRecognizer *)tap{
    CQShowPictureController *vc = [[CQShowPictureController alloc]init];
//    vc.view.backgroundColor = [UIColor grayColor];
    vc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:NO completion:nil];
   
    
}













@end
