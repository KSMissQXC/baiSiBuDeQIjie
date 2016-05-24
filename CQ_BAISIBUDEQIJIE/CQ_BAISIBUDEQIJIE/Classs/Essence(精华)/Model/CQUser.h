//
//  CQUser.h
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/15.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CQUser : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

@end
