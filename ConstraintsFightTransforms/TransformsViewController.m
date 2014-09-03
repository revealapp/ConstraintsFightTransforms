//
//  Copyright (c) 2014 Itty Bitty Apps. All rights reserved.
//

#import "TransformsViewController.h"
#import "GradientView.h"
#import "UIColor+Theme.h"

static NSString * IBAEffectiveSDKMajorVersionString();

@interface TransformsViewController ()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;
@property (nonatomic, weak) IBOutlet UILabel *versionLabel;

@property (nonatomic, weak) IBOutlet GradientView *leftBaseTranslateView;
@property (nonatomic, weak) IBOutlet GradientView *constrainedTranlateView;
@property (nonatomic, weak) IBOutlet GradientView *rightBaseTranslateView;
@property (nonatomic, weak) GradientView *codedTranlateView;

@property (nonatomic, weak) IBOutlet GradientView *leftBaseRotateView;
@property (nonatomic, weak) IBOutlet GradientView *constrainedRotateView;
@property (nonatomic, weak) IBOutlet GradientView *rightBaseRotateView;
@property (nonatomic, weak) GradientView *codedRotateView;

@property (nonatomic, weak) IBOutlet GradientView *leftBaseScaleView;
@property (nonatomic, weak) IBOutlet GradientView *constrainedScaleView;
@property (nonatomic, weak) IBOutlet GradientView *rightBaseScaleView;
@property (nonatomic, weak) GradientView *codedScaleView;

@end

@implementation TransformsViewController

- (void)viewDidLoad
{
    static const CGFloat kGradientViewsCornerRadius = 2.0f;
    static const CGFloat kTransformedViewAlpha = 0.8f;
    
    [super viewDidLoad];

    // set the version label to the SDK version linked against
    self.versionLabel.text = [NSString stringWithFormat:@"iOS %@ SDK", IBAEffectiveSDKMajorVersionString()];
    
    // setup all views laid out in code
    self.codedTranlateView = [self.class codedViewInsertedAboveBaseView:self.rightBaseTranslateView];
    self.codedRotateView = [self.class codedViewInsertedAboveBaseView:self.rightBaseRotateView];
    self.codedScaleView = [self.class codedViewInsertedAboveBaseView:self.rightBaseScaleView];
    
    // setup base views appearance
    UIColor *baseViewStartColor = [UIColor iba_baseFrameGradientStartColor];
    UIColor *baseViewEndColor = [UIColor iba_baseFrameGradientEndColor];
    NSArray *baseViews = @[ self.leftBaseTranslateView, self.rightBaseTranslateView, self.leftBaseRotateView, self.rightBaseRotateView, self.leftBaseScaleView, self.rightBaseScaleView ];
    for (GradientView *view in baseViews) {
        view.startColor = baseViewStartColor;
        view.endColor = baseViewEndColor;
        view.layer.cornerRadius = kGradientViewsCornerRadius;
    }
    
    // setup transformed views appearance
    NSArray *transformedViews = @[ self.constrainedTranlateView, self.codedTranlateView, self.constrainedRotateView, self.codedRotateView, self.constrainedScaleView, self.codedScaleView ];
    for (GradientView *view in transformedViews) {
        view.alpha = kTransformedViewAlpha;
        view.layer.cornerRadius = kGradientViewsCornerRadius;
    }
    
    // finally, setup transforms for each case
    CGAffineTransform translationTransform = CGAffineTransformMakeTranslation(-20.0f, 20.0f);
    self.constrainedTranlateView.transform = translationTransform;
    self.codedTranlateView.transform = translationTransform;
    
    CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(30.0f * M_PI / 180.0f);
    self.constrainedRotateView.transform = rotationTransform;
    self.codedRotateView.transform = rotationTransform;
    
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.5f, 0.5f);
    self.constrainedScaleView.transform = scaleTransform;
    self.codedScaleView.transform = scaleTransform;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // update content view width constraint so that it fills the superview
    self.contentViewWidthConstraint.constant = self.view.frame.size.width;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // layout all coded views
    [self.class layoutCodedView:self.codedTranlateView againstBaseView:self.rightBaseTranslateView];
    [self.class layoutCodedView:self.codedRotateView againstBaseView:self.rightBaseRotateView];
    [self.class layoutCodedView:self.codedScaleView againstBaseView:self.rightBaseScaleView];
    
    // validate frames of constrainted views a bit later, when the whole subview tree is laid out
    dispatch_async(dispatch_get_main_queue(), ^{
        [self validateConstrainedViews];
    });
}

- (void)validateConstrainedViews
{
    [self.class validateConstrainedView:self.constrainedTranlateView withBaseView:self.leftBaseTranslateView againstCodedView:self.codedTranlateView withBaseView:self.rightBaseTranslateView];
    [self.class validateConstrainedView:self.constrainedRotateView withBaseView:self.leftBaseRotateView againstCodedView:self.codedRotateView withBaseView:self.rightBaseRotateView];
    [self.class validateConstrainedView:self.constrainedScaleView withBaseView:self.leftBaseScaleView againstCodedView:self.codedScaleView withBaseView:self.rightBaseScaleView];
}

+ (GradientView *)codedViewInsertedAboveBaseView:(UIView *)baseView
{
    static const CGSize kCodedViewsSize = { .width = 100.0f, .height = 50.0f };
    
    GradientView *view = [[GradientView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kCodedViewsSize.width, kCodedViewsSize.height)];
    view.autoresizingMask = UIViewAutoresizingNone;
    view.startColor = [UIColor iba_correctFrameGradientStartColor];
    view.endColor = [UIColor iba_correctFrameGradientEndColor];
    
    [baseView.superview insertSubview:view aboveSubview:baseView];
    
    return view;
}

+ (void)layoutCodedView:(GradientView *)codedView againstBaseView:(UIView *)baseView
{
    // make sure that base view is already laid out before synchronising with it
    [baseView.superview layoutIfNeeded];
    
    codedView.center = baseView.center;
}

+ (void)validateConstrainedView:(GradientView *)constrainedView withBaseView:(UIView *)constrainedBaseView againstCodedView:(GradientView *)codedView withBaseView:(UIView *)codedBaseView
{
    // the threshold is 1/2 pixel, which corresponds to a visible difference
    const CGFloat kValidationThreshold = 0.5f / [UIScreen mainScreen].scale;
    
    CGPoint constrainedViewOriginInWindow = [constrainedView convertPoint:CGPointZero toView:nil];
    CGPoint constrainedBaseViewOriginInWindow = [constrainedBaseView convertPoint:CGPointZero toView:nil];
    CGPoint codedViewOriginInWindow = [codedView convertPoint:CGPointZero toView:nil];
    CGPoint codedBaseViewOriginInWindow = [codedBaseView convertPoint:CGPointZero toView:nil];
    
    CGPoint referenceDeltaOrigin = CGPointMake(codedViewOriginInWindow.x - codedBaseViewOriginInWindow.x, codedViewOriginInWindow.y - codedBaseViewOriginInWindow.y);
    CGPoint constrainedDeltaOrigin = CGPointMake(constrainedViewOriginInWindow.x - constrainedBaseViewOriginInWindow.x, constrainedViewOriginInWindow.y - constrainedBaseViewOriginInWindow.y);
    
    BOOL isConstrainedCorrectly = (fabsf(constrainedDeltaOrigin.x - referenceDeltaOrigin.x) <= kValidationThreshold && fabsf(constrainedDeltaOrigin.y - referenceDeltaOrigin.y) <= kValidationThreshold);
    
    if (isConstrainedCorrectly)
    {
        constrainedView.startColor = [UIColor iba_correctFrameGradientStartColor];
        constrainedView.endColor = [UIColor iba_correctFrameGradientEndColor];
    }
    else
    {
        constrainedView.startColor = [UIColor iba_incorrectFrameGradientStartColor];
        constrainedView.endColor =[UIColor iba_incorrectFrameGradientEndColor];
    }
}

@end

static NSString * IBAEffectiveSDKMajorVersionString()
{
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    NSString *linkedSDKVersionString = nil;
#if __IPHONE_8_0
    linkedSDKVersionString = @"8.0";
#elif __IPHONE_7_1
    linkedSDKVersionString = @"7.1";
#elif __IPHONE_7_0
    linkedSDKVersionString = @"7.0";
#endif
    
    if (linkedSDKVersionString != nil)
    {
        NSString *effectiveSDKVersion;
        if ([systemVersion compare:linkedSDKVersionString] == NSOrderedAscending)
        {
            effectiveSDKVersion = systemVersion;
        }
        else
        {
            effectiveSDKVersion = linkedSDKVersionString;
        }
        
        NSRange firstPointRange = [effectiveSDKVersion rangeOfString:@"."];
        if (firstPointRange.location != NSNotFound)
        {
            return [effectiveSDKVersion substringToIndex:firstPointRange.location];
        }
    }
    
    return @"???";
}
