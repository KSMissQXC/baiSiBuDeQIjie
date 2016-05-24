//
//  CQFooterView.h
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^setHeightBlock)(CGFloat height);

@interface CQFooterView : UIView


@property (copy, nonatomic)setHeightBlock block;


@end
