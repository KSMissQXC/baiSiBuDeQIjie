//
//  UIImage+CQExtension.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "UIImage+CQExtension.h"

@implementation UIImage (CQExtension)

-(instancetype)circleImage{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.width);
    CGContextAddEllipseInRect(ref, rect);
    CGContextClip(ref);
    [self drawInRect:rect];
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return circleImage;

}

@end
