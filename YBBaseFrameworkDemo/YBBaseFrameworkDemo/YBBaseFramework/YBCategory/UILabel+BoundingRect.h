//
//  UILabel+BoundingRect.h
//  YoubanAgent
//
//  Created by asance on 2017/6/3.
//  Copyright © 2017年 asance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (BoundingRect)
/**Return the most appropriate size for the text*/
- (CGSize)textBoundingSize;
/**Return the most appropriate rect for the text*/
- (CGRect)textBoundingRect;
/**According to the max size, returns the most appropriate size of the text*/
- (CGSize)textBoundingSizeWithMaxSize:(CGSize)maxSize;

@end
