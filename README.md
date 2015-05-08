Constraints & Transforms
========================

This project demonstrates the difference in behaviour of Auto Layout between iOS 7 and iOS 8 when used together with transformations applied to views. It shows how the effects of these transformations are different for views positioned using constraints and views positioned "manually" in code, when running on iOS 7.

The main storyboard contains a navigation controller and a single `TransformsViewController` object as its root view controller. `TransformsViewController` contains three "showcases", one for each type of transformations applied. Each showcase contains four similar views:

- a pair of grey "anchor" views, constrained for width, height and by horizontal and vertical centre,
- a coloured view on the left, constrained for width and height, and also by leading edge and top space to the nearby "anchor" view,
- a coloured view on the right, added in code in `viewDidLoad` method of `TransformsViewController` and positioned in code to match the nearby "anchor" view position inside `viewDidLayoutSubviews` method of `TransformsViewController`.

The views in the left column are checked whether they match the views in the right column, and are coloured green or red depending on that.

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

The view is rotated around its centre as expected.

The bottom view is scaled with a factor of 0.5 in both x and y axes:

    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.5f, 0.5f);
    self.codedScaleView.transform = scaleTransform;

The view shrinks in all directions while maintaining its centre point, as expected.

Left side
---------

Mixing constraints and transforms produces some unexpected results when running on iOS 7.

The top view is translated with tx = -20 and ty = 20:

    CGAffineTransform translationTransform = CGAffineTransformMakeTranslation(-20.0f, 20.0f);
    self.constrainedTranslateView.transform = translationTransform;

The view is moved 10 points left and 10 points down.

The middle view has a rotation of π÷6 (30 degrees) applied:

    CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(30.0f * M_PI / 180.0f);
    self.constrainedRotateView.transform = rotationTransform;

The view appears to be rotated to the correct angle but the centre of the view has moved, as if the view's post-transformation bounding box is constrained by its top and left edges now.

The bottom view is scaled with a factor of 0.5 in both x and y axes:

    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.5f, 0.5f);
    self.constrainedScaleView.transform = scaleTransform;

The view is scaled correctly but the centre of the view has moved, as if, again, the post-transformation frame of the view is constrained.

Changes between iOS versions
----------------------------

The behaviour of constraints mixed with transforms have been changed in iOS 8 SDK. Views in the left column are positioned incorrectly (and thus show up red) when linking against iOS 7 SDK **or** running on an iOS 7 device. When linking against iOS 8 SDK **and** running on an iOS 8 device though, all views in the left column are positioned as expected (and thus show up green).

[This blog post](http://revealapp.com/blog/constraints-and-transforms.html) covers an investigation of these observed changes.
