//
//  UILabel+BoundingRect.m
//  YoubanAgent
//
//  Created by asance on 2017/6/3.
//  Copyright © 2017年 asance. All rights reserved.
//

#import "UILabel+BoundingRect.h"

@implementation UILabel (BoundingRect)

- (CGSize)textBoundingSize{
    
    if(0==self.text.length) return CGSizeZero;
    
    CGRect rect = [self textBoundingRect];
    
    CGSize size = CGSizeMake(rect.size.width, rect.size.height);
    
    return size;
}

- (CGRect)textBoundingRect{
    
    if(0==self.text.length) return CGRectZero;
    
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), 300)
                                                  options:(NSStringDrawingOptions)(NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin)
                                               attributes:@{NSFontAttributeName:self.font}
                                                  context:nil];
    
    CGRect newrect = CGRectMake(0, 0, rect.size.width, rect.size.height+5);
    
    return newrect;
}

- (CGSize)textBoundingSizeWithMaxSize:(CGSize)maxSize{
    if(0==self.text.length) return CGSizeZero;
    
    CGRect rect = [self.text boundingRectWithSize:maxSize
                                          options:(NSStringDrawingOptions)(NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin)
                                       attributes:@{NSFontAttributeName:self.font}
                                          context:nil];
    
    CGSize newrect = CGSizeMake(rect.size.width+5, rect.size.height+5);
    
    return newrect;
}

@end
