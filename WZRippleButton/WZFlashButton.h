//
//  WZFlashButton.h
//  WZRippleButton
//
//  Created by z on 15-1-6.
//  Copyright (c) 2015年 SatanWoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WZFlashButtonDidClickBlock)(void);

typedef NS_ENUM(NSUInteger, WZFlashButtonType) {
    WZFlashButtonTypeInner = 0,
    WZFlashButtonTypeOuter = 1
};

@interface WZFlashButton : UIView

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, assign) WZFlashButtonType buttonType;
@property (nonatomic, copy) WZFlashButtonDidClickBlock clickBlock;

@property (nonatomic, strong) UIColor *flashColor;

- (void)setText:(NSString *)text;
- (void)setTextColor:(UIColor *)textColor;
- (void)setText:(NSString *)text withTextColor:(UIColor *)textColor;
@end
