//
//  UIImage+Alpha.m
//  YoubanAgent
//
//  Created by asance on 2017/5/10.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "UIImage+Alpha.h"

@implementation UIImage (Alpha)

- (BOOL)hasAlpha{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    if(alpha == kCGImageAlphaFirst) return YES;
    if(alpha == kCGImageAlphaLast) return YES;
    if(alpha == kCGImageAlphaPremultipliedFirst) return YES;
    if(alpha == kCGImageAlphaPremultipliedLast) return YES;
    
    return NO;
}

- (NSData *)compressToLength:(CGFloat)length{
    if (!self) return nil;
    if(0==length) length = 50*1024;
    CGFloat maxFileSize = length;
    CGFloat compression = 0.9f;
    NSData *compressedData = UIImageJPEGRepresentation(self, compression);
    while ([compressedData length] > maxFileSize) {
        compression *= 0.9;
        compressedData = UIImageJPEGRepresentation([self compressToWidth:self.size.width*compression], compression);
    }
    return compressedData;
}

- (UIImage *)compressToWidth:(CGFloat)toWidth{
    if (!self) return nil;
    float imageWidth = self.size.width;
    float imageHeight = self.size.height;
    float width = toWidth;
    float height = self.size.height/(self.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [self drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [self drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)compressToHeight:(CGFloat)toHeight{
    if (!self) return nil;
    float imageWidth = self.size.width;
    float imageHeight = self.size.height;
    float height = toHeight;
    float width = self.size.width/(self.size.height/height);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [self drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [self drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end


@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end

