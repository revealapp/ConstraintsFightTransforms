//
//  Copyright (c) 2014 Itty Bitty Apps. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [self updateGradient];
}

- (void)setGradientType:(GradientViewType)gradientType
{
    _gradientType = gradientType;

    [self setNeedsLayout];
}

- (void)setStartColor:(UIColor *)startColor
{
    _startColor = startColor;

    [self setNeedsLayout];
}

- (void)setEndColor:(UIColor *)endColor
{
    _endColor = endColor;

    [self setNeedsLayout];
}

- (void)updateGradient
{
    NSAssert([self.layer isKindOfClass:[CAGradientLayer class]], @"Expected own layer to be a CAGradientLayer.");
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;

    UIColor *fallbackColor = [UIColor blackColor];
    layer.colors = @[ (id)self.startColor.CGColor ?: (id)fallbackColor.CGColor, (id)self.endColor.CGColor ?: (id)fallbackColor.CGColor ];

    switch (self.gradientType)
    {
        case GradientViewTypeVertical:
            layer.startPoint = CGPointMake(0.5f, 0.0f);
            layer.endPoint = CGPointMake(0.5f, 1.0f);
            break;

        case GradientViewTypeHorizontal:
            layer.startPoint = CGPointMake(0.0f, 0.5f);
            layer.endPoint = CGPointMake(1.0f, 0.5f);
            break;

        default:
            NSAssert1(NO, @"Unsupported gradient type: %lu.", (unsigned long)self.gradientType);
            break;
    }
}

@end
