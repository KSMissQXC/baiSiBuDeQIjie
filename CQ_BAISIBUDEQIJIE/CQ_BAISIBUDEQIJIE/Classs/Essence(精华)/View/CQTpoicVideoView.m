//
//  CQTpoicVideoView.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQTpoicVideoView.h"
#import "CQTopic.h"
#import "CQShowPictureController.h"
#import <UIImageView+WebCache.h>


@interface CQTpoicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;

@end

@implementation CQTpoicVideoView

#pragma mark - 初始化
+(instancetype)tpoicVideoView{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [self.imageView addGestureRecognizer:tap];
    
}

-(void)setTopic:(CQTopic *)topic{
    _topic = topic;
    self.frame = topic.videoF;
    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    // 播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    // 时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}


#pragma mark - 事件处理
-(void)tapClick:(UITapGestureRecognizer *)tap{
    CQShowPictureController *vc = [[CQShowPictureController alloc]init];
    //    vc.view.backgroundColor = [UIColor grayColor];
    vc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:NO completion:nil];
    
    
}



@end
