Description of the project
==========================

The storyboard contains a navigation controller and a single ``TransformsViewController`` object as its root view controller. ``TransformsViewController`` contains three "showcases", one for each type of transformations applied. Each showcase contains four similar views:

- a pair of gray "base" views, constrained for width, height and by horizontal and vertical center,
- a colored view on the left, constrained for width and height, and also by leading edge and top space to the nearby "base" view,
- a colored view on the right, added in code in ``viewDidLoad`` method of ``TransformsViewController`` and positioned in code to match the nearby "base" view position inside ``viewDidLayoutSubviews`` method of ``TransformsViewController``.

The views in the left column are checked whether they match the views in the right column, and are coloured green or red depending on that.

The object of the project is to show the different effects of transforms on views positioned using constraints and views positioned "manually" in code, and how these effects change depending on iOS SDK version being linked against and iOS version running.

Right side
----------

Views are affected as would be expected.

The top view is translated with tx = -20 and ty = 20:

    CGAffineTransform translationTransform = CGAffineTransformMakeTranslation(-20.0f, 20.0f);
    self.codedTranslateView.transform = translationTransform;
	
The view is moved 20 points left and 20 points down as expected.

The middle view has a rotation of π÷6 (30 degrees) applied:

    CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(30.0f * M_PI / 180.0f);
    self.codedRotateView.transform = rotationTransform;

The view is rotated around its center as expected.

The bottom view is scaled with a factor of 0.5 in both x and y axes:

    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.5f, 0.5f);
    self.codedScaleView.transform = scaleTransform;

The view shrinks in all directions while maintaining its center point, as expected.

Left side
---------

Mixing constraints and transforms produces some unexpected results.

The top view is translated with tx = -20 and ty = 20:

    CGAffineTransform translationTransform = CGAffineTransformMakeTranslation(-20.0f, 20.0f);
    self.constrainedTranslateView.transform = translationTransform;

The view is moved 10 points left and 10 points down.

The middle view has a rotation of π÷6 (30 degrees) applied:

    CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(30.0f * M_PI / 180.0f);
    self.constrainedRotateView.transform = rotationTransform;

The view appears to be rotated to the correct angle but the center of the view has moved.

The bottom view is scaled with a factor of 0.5 in both x and y axes:

    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.5f, 0.5f);
    self.constrainedScaleView.transform = scaleTransform;

The view is scaled correctly but the center of the view has moved.

One theory to explain this behaviour would be that transforms are applied and then constraints are resolved. This explains the position of the Rotated and Scaled views but not the Translated view.

Questions
=========

1. In the case of the top translated view in the left column how is the final translation tx=-10, ty=10 arrived at? This does not satisfy the constraints or the transform.
2. In the case of the bottom scaled view in the left column why do the width and height constraints not override the scale transform?
3. In general will constraints always be resolved after and override effects on view position deriving from a transform on the view's property?

Changes between iOS versions
============================

The behaviour of constraints mixed with transforms seems to have changed in iOS 8 SDK. When linking against iOS 7 SDK **or** running on an iOS 7 device, views in the left column are positioned incorrectly (and thus show up red). When linking against iOS 8 SDK **and** running on an iOS 8 device though, all views in the left column are positioned as expected (and thus show up green).
