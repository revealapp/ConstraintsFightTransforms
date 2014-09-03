//
//  Copyright (c) 2014 Itty Bitty Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GradientViewType) {
    GradientViewTypeVertical = 0,
    GradientViewTypeHorizontal
};

@interface GradientView : UIView

@property (nonatomic, strong) UIColor *startColor;
@property (nonatomic, strong) UIColor *endColor;
@property (nonatomic, assign) GradientViewType gradientType;

@end
