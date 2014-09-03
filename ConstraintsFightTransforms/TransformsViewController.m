//
//  Copyright (c) 2014 Itty Bitty Apps. All rights reserved.
//

#import "TransformsViewController.h"

@interface TransformsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *translatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *rotatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *scaledLabel;
@end

@implementation TransformsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // rects for the views positioned by frame rather than constraint
    CGFloat leftColumnWidth = self.translatedLabel.frame.size.width + 20;
    CGRect codeTranslatedViewRect = CGRectMake(self.translatedLabel.frame.origin.x + leftColumnWidth,
                                               self.translatedLabel.frame.origin.y,
                                               self.translatedLabel.frame.size.width,
                                               self.translatedLabel.frame.size.height);
    CGRect codeRotatedViewRect = CGRectMake(self.rotatedLabel.frame.origin.x + leftColumnWidth,
                                            self.rotatedLabel.frame.origin.y,
                                            self.rotatedLabel.frame.size.width,
                                            self.rotatedLabel.frame.size.height);
    CGRect codeScaledViewRect = CGRectMake(self.scaledLabel.frame.origin.x + leftColumnWidth,
                                           self.scaledLabel.frame.origin.y,
                                           self.scaledLabel.frame.size.width,
                                           self.scaledLabel.frame.size.height);
    
    self.translatedLabel.transform = CGAffineTransformMakeTranslation(-20.0f, 20.0f);
    self.rotatedLabel.transform = CGAffineTransformMakeRotation(0.66f*M_PI_2);
    self.scaledLabel.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
    
    UILabel *codeTranslatedOriginalView = [[UILabel alloc] initWithFrame:codeTranslatedViewRect];
    codeTranslatedOriginalView.backgroundColor = [UIColor lightGrayColor];
    codeTranslatedOriginalView.textAlignment = NSTextAlignmentCenter;
    codeTranslatedOriginalView.text = @"Pretranslation";
    [self.view addSubview:codeTranslatedOriginalView];
    
    UILabel *codeTranslatedView = [[UILabel alloc] initWithFrame:codeTranslatedViewRect];
    codeTranslatedView.backgroundColor = [UIColor redColor];
    codeTranslatedView.font = [UIFont systemFontOfSize:16];
    codeTranslatedView.textAlignment = NSTextAlignmentCenter;
    codeTranslatedView.text = @"Translated";
    codeTranslatedView.transform = CGAffineTransformMakeTranslation(-20.0f, 20.0f);
    [self.view addSubview:codeTranslatedView];
    
    UILabel *codeRotatedOriginalView = [[UILabel alloc] initWithFrame:codeRotatedViewRect];
    codeRotatedOriginalView.backgroundColor = [UIColor lightGrayColor];
    codeRotatedOriginalView.textAlignment = NSTextAlignmentCenter;
    codeRotatedOriginalView.text = @"Prerotation";
    [self.view addSubview:codeRotatedOriginalView];
    
    UILabel *codeRotatedView = [[UILabel alloc] initWithFrame:codeRotatedViewRect];
    codeRotatedView.backgroundColor = [UIColor yellowColor];
    codeRotatedView.textAlignment = NSTextAlignmentCenter;
    codeRotatedView.text = @"Rotated";
    codeRotatedView.transform = CGAffineTransformMakeRotation(0.66f*M_PI_2);
    [self.view addSubview:codeRotatedView];
    
    UILabel *codeScaledOriginalView = [[UILabel alloc] initWithFrame:codeScaledViewRect];
    codeScaledOriginalView.backgroundColor = [UIColor lightGrayColor];
    codeScaledOriginalView.font = [UIFont systemFontOfSize:13];
    codeScaledOriginalView.textAlignment = NSTextAlignmentCenter;
    codeScaledOriginalView.text = @"Prescale";
    [self.view addSubview:codeScaledOriginalView];
    
    UILabel *codeScaledView = [[UILabel alloc] initWithFrame:codeScaledViewRect];
    codeScaledView.backgroundColor = [UIColor greenColor];
    codeScaledView.font = [UIFont systemFontOfSize:13];
    codeScaledView.textAlignment = NSTextAlignmentCenter;
    codeScaledView.text = @"Scaled";
    codeScaledView.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
    [self.view addSubview:codeScaledView];
}

@end
