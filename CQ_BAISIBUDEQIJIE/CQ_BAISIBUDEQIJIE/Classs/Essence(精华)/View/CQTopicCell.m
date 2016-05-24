//
//  CQTopicCell.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQTopicCell.h"
#import "CQTopic.h"
#import "CQTopicPictureView.h"
#import "CQTopicVoiceView.h"
#import "CQTpoicVideoView.h"
#import "CQComment.h"
#import "CQUser.h"
#import <objc/runtime.h>
#import <UIImageView+WebCache.h>

@interface CQTopicCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;

@property (weak, nonatomic) IBOutlet UILabel *text_label;

/** 图片帖子中间的内容 */
@property (nonatomic, weak) CQTopicPictureView *pictureView;

@property (weak, nonatomic)CQTopicVoiceView *voiceView;

@property (weak, nonatomic)CQTpoicVideoView *videoView;

@property (weak, nonatomic) IBOutlet UIView *hotView;

@property (weak, nonatomic) IBOutlet UILabel *hotContentLabel;


@end


@implementation CQTopicCell



#pragma mark - 懒加载
-(CQTopicPictureView *)pictureView{
    if (_pictureView == nil) {
        CQTopicPictureView *pv = [CQTopicPictureView topicPictureView];
        _pictureView = pv;
        [self.contentView addSubview:pv];
    }
    return _pictureView;
}

-(CQTopicVoiceView *)voiceView{
    if (_voiceView == nil) {
        CQTopicVoiceView *voiceView = [CQTopicVoiceView topicVoiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

-(CQTpoicVideoView *)videoView{
    if (_videoView == nil) {
        CQTpoicVideoView *videoView = [CQTpoicVideoView tpoicVideoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

#pragma mark - 初始化
- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

-(void)setTopic:(CQTopic *)topic{
    
    _topic = topic;
    self.sinaVView.hidden = !topic.isSina_v;
    // 设置头像
    [self.profileImageView cq_setImageHeader:topic.profile_image];
    
    // 设置名字
    self.nameLabel.text = topic.name;
    
    // 设置帖子的创建时间
    self.createTimeLabel.text =[topic showRightTime];
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    if (topic.type == CQTopicControllerTypePicture) {//图片
        self.pictureView.topic = topic;
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (topic.type == CQTopicControllerTypeVoice){//声音
        self.voiceView.topic = topic;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
    }else if (topic.type == CQTopicControllerTypeVideo){//视频
        self.videoView.topic = topic;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
    }else if(topic.type == CQTopicControllerTypeWord){//段子
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    CQComment *comment = [self.topic.top_cmt firstObject];
    if (comment) {
        self.hotView.hidden = NO;
          NSString *content = [NSString stringWithFormat:@"%@ :%@",comment.user.username,comment.content];
        self.hotContentLabel.text = content;
    }else{
        self.hotView.hidden = YES;
    }
    self.text_label.text = topic.text;
}

-(void)setFrame:(CGRect)frame{
    
    frame.origin.x = CQTopicCellMargin;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= CQTopicCellMargin;
    frame.origin.y += CQTopicCellMargin;
    [super setFrame:frame];
    
}


#pragma mark - 私有方法
-(void)setupButtonTitle:(UIButton *)btn count:(NSInteger)count placeholder:(NSString *)placeholder{
    if (count > 10000) {
        placeholder =  [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    }else if (count >0){
        placeholder =  [NSString stringWithFormat:@"%zd",count];
    }
    [btn setTitle:placeholder forState:UIControlStateNormal];
}



#pragma mark - 事件处理
- (IBAction)btnClikc:(UIButton *)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *likeAction = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
   //
//    UILabel *label = nil;
//    label.textAlignment = NSTextAlignmentLeft
//    
    
    
//    unsigned int count = 0;
//    Ivar *ivars = class_copyIvarList([UIImage class], &count);
//    for (int i = 0; i < count; i++) {
//        ivar_getName(ivars[i]);
//        NSLog(@"%s",ivar_getName(ivars[i]));
//        NSLog(@"%s",ivar_getTypeEncoding(ivars[i]));
//        
//        NSLog(@"\n");
//        
//    }
    [likeAction setValue:[UIColor grayColor] forKeyPath:@"_titleTextColor"];
    [likeAction setValue:[UIImage imageNamed:@"login_close_icon"] forKeyPath:@"_image"];

    UIAlertAction *reportAction = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:likeAction];
    [alert addAction:reportAction];
    [alert addAction:cancelAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];

}

@end
