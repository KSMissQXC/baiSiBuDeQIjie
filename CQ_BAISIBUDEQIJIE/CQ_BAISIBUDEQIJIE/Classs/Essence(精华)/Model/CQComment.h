//
//  CQComment.h
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/15.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CQUser;

@interface CQComment : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) CQUser *user;

@property (assign, nonatomic)CGFloat cellHeight;


@end
