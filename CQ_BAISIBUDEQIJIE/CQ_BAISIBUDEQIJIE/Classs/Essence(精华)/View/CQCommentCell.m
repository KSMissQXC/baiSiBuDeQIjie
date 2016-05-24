//
//  CQCommentCell.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by 廖启旋 on 16/5/15.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQCommentCell.h"
#import "CQComment.h"
#import "CQUser.h"
#import <UIImageView+WebCache.h>


@interface CQCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation CQCommentCell

#pragma mark - 初始化
+(instancetype)commentCellWithTabelView:(UITableView *)tableView{
    static NSString *ID = @"comment";
    CQCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [self viewFromXib];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

-(void)setComment:(CQComment *)comment{
    _comment = comment;
    [self.profileImageView cq_setImageHeader:comment.user.profile_image];
    self.sexView.image = [comment.user.sex isEqualToString:CQUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
        
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
        if (comment.cellHeight == 0)  {
            [self layoutIfNeeded];
            comment.cellHeight = CGRectGetMaxY(self.voiceButton.frame) + CQTopicCellMargin;
        }
       
    } else {
        self.voiceButton.hidden = YES;
       
        if (comment.cellHeight == 0) {
            [self layoutIfNeeded];
            comment.cellHeight = CGRectGetMaxY(self.contentLabel.frame) + CQTopicCellMargin;

        }
    }
}


-(void)setFrame:(CGRect)frame{
    frame.origin.x = 10;
    frame.size.width -= 2 * frame.origin.x;
    [super setFrame:frame];

}

#pragma mark - 其它
-(BOOL)canBecomeFirstResponder{
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}













@end
