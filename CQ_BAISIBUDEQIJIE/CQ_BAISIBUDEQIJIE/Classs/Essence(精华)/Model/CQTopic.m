//
//  CQTopic.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQTopic.h"
#import "CQComment.h"
#import "CQUser.h"
#import <MJExtension.h>

@implementation CQTopic

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id"
             };
}

+ (NSDictionary *)objectClassInArray
{
    return @{@"top_cmt" : @"CQComment"};
}



-(NSString *)showRightTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *creat_time = [formatter dateFromString:_create_time];
    
    NSDateComponents *coms = [creat_time cq_componentsToNowDate];
    NSString *returnStr = nil;
    
    if ([creat_time cq_isThisYear]) {//今年
        if ([creat_time cq_isToday]) {//今天
            if (coms.hour >= 1) {//几小时前
                returnStr = [NSString stringWithFormat:@"%zd小时前",coms.hour];
            }else if (coms.minute >= 1){//几分钟前
                returnStr = [NSString stringWithFormat:@"%zd分钟前",coms.minute];
            }else if (coms.second < 60){
                returnStr = @"刚刚";
            }
        }else if ([creat_time cq_isYesterday]){//昨天
            formatter.dateFormat = @"昨天HH:mm:ss";
            returnStr = [formatter stringFromDate:creat_time];
        }else{
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            returnStr = [formatter stringFromDate:creat_time];
        }
    }else{//非今年
        returnStr = _create_time;
        
    }
    return returnStr;
}


-(CGFloat)cellHeight{
    if (!_cellHeight) {
        CGSize maxSize = CGSizeMake(SCREEN_WIDTH - 40, MAXFLOAT);
        CGFloat textHeight = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil].size.height;
        //cell的高度 文字部分
        _cellHeight = CQTopicCellTextY + textHeight + CQTopicCellMargin;
        if (self.type == CQTopicControllerTypePicture) {//图片
            CGFloat pictureW = maxSize.width;
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH > CQTopicCellPictureMaxH) {
                pictureH = CQTopicCellPictureBreakH;
                self.bigImage = YES;
            }
            self.pictureF = CGRectMake(CQTopicCellMargin, _cellHeight, pictureW, pictureH);
            _cellHeight += pictureH + CQTopicCellMargin;
        }else if (self.type == CQTopicControllerTypeVoice){//声音
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            self.voiceF = CGRectMake(CQTopicCellMargin, _cellHeight, voiceW, voiceH);
            _cellHeight += voiceH + CQTopicCellMargin;
        }else if (self.type == CQTopicControllerTypeVideo){//视频
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            self.videoF = CGRectMake(CQTopicCellMargin, _cellHeight, videoW, videoH);
            _cellHeight += videoH + CQTopicCellMargin;
        }
        
        CQComment *comment = [self.top_cmt firstObject];
        if (comment) {
            NSString *content = [NSString stringWithFormat:@"%@ :%@",comment.user.username,comment.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13]} context:nil].size.height;
            
            _cellHeight += CQTopicCellTopCmtTitleH + contentH + CQTopicCellMargin;
        }
        

        //加上底部工具条
        _cellHeight += CQTopicCellBottomBarH + CQTopicCellMargin;
        
    }
    return _cellHeight;
}

- (id)copyWithZone:(nullable NSZone *)zone{
    
    NSMutableDictionary *dict = [self mj_keyValues];
    CQTopic *topic = [CQTopic mj_objectWithKeyValues:dict];
    return topic;
}





@end
