//
//  Copyright (c) 2014 Itty Bitty Apps. All rights reserved.
//

#import "UIColor+Theme.h"

@implementation UIColor (Theme)

+ (instancetype)iba_colorWithByteRed:(Byte)red green:(Byte)green blue:(Byte)blue alpha:(Byte)alpha
{
    return [self colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha / 255.0f];
}

+ (instancetype)iba_windowColor
{
    return [self colorWithWhite:0.2f alpha:1.0f];
}

+ (instancetype)iba_baseFrameGradientStartColor
{
    return [UIColor colorWithWhite:0.67f alpha:1.0f];
}

+ (instancetype)iba_baseFrameGradientEndColor
{
    return [UIColor iba_colorWithByteRed:225 green:225 blue:230 alpha:255];
}

+ (instancetype)iba_correctFrameGradientStartColor
{
    return [self iba_colorWithByteRed:135 green:252 blue:112 alpha:255];
}

+ (instancetype)iba_correctFrameGradientEndColor
{
    return [self iba_colorWithByteRed:76 green:217 blue:100 alpha:255];
}

+ (instancetype)iba_incorrectFrameGradientStartColor
{
    return [self iba_colorWithByteRed:255 green:41 blue:105 alpha:255];
}

+ (instancetype)iba_incorrectFrameGradientEndColor
{
    return [self iba_colorWithByteRed:223 green:38 blue:60 alpha:255];
}

@end
