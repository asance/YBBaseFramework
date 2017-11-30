//
//  UIImage+Alpha.h
//  YoubanAgent
//
//  Created by asance on 2017/5/10.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Alpha)
/**
 * Whether to include alpha channel
 */
- (BOOL)hasAlpha;

/**
 *  Scale the image according to the specified size ratio,
 *  only supports conversion jpeg.
 *  @param length image size after scaling (in bytes)
 *  @return data
 */
- (NSData *)compressToLength:(CGFloat)length;

/**
 *  Scale the image according to the specified width,
 *  only supports conversion jpeg.
 *  @param toWidth image width after scaling (in pixels)
 *  @return self-->(image)
 */
- (UIImage *)compressToWidth:(CGFloat)toWidth;

/**
 *  Scale the image according to the specified height,
 *  only supports conversion jpeg.
 *  @param toHeight image height after scaling (in pixels)
 *  @return self-->(image)
 */
- (UIImage *)compressToHeight:(CGFloat)toHeight;

@end


@interface UIImage (Color)
/**
 *  According to the coloring, get colored background picture
 *  @param color color
 *  @return self-->(image)
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
