//
//  CQAddTagController.h
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQAddTagController : UIViewController

@property(nonatomic,copy) void(^clickFinishBlock)(NSArray *tagStrArray);
@property(nonatomic,strong)NSArray *tagStrArray;


@end
