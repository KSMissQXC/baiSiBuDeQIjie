//
//  CQTopicPictureView.h
//  CQ_BAISIBUDEQIJIE
//
//  Created by 廖启旋 on 16/5/7.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CQTopic;

@interface CQTopicPictureView : UIView

+(instancetype)topicPictureView;

@property(nonatomic,strong)CQTopic *topic;


@end
