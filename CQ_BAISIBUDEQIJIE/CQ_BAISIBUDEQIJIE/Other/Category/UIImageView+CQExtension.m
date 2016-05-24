//
//  UIImageView+CQExtension.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "UIImageView+CQExtension.h"
#import "UIImage+CQExtension.m"
#import <UIImageView+WebCache.h>

@implementation UIImageView (CQExtension)

-(void)cq_setImageHeader:(NSString *)url{
    UIImage *placeholderImage = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholderImage;
    }];
    
    
}

@end
