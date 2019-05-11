
#import "UIView+XYMExtension.h"


@implementation UIView (XYMExtension)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xym_view_top {
    return self.frame.origin.y;
}

- (void)setXym_view_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (CGFloat)xym_view_left {
    return self.frame.origin.x;
}

- (void)setXym_view_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xym_view_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setXym_view_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xym_view_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setXym_view_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xym_view_centerX {
    return self.center.x;
}

- (void)setXym_view_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xym_view_centerY {
    return self.center.y;
}

- (void)setXym_view_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xym_view_width {
    return self.frame.size.width;
}

- (void)setXym_view_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xym_view_height {
    return self.frame.size.height;
}

- (void)setXym_view_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)xym_view_origin {
    return self.frame.origin;
}

- (void)setXym_view_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)xym_view_size {
    return self.frame.size;
}

- (void)setXym_view_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xym_view_rightToSuper
{
    return self.superview.bounds.size.width - self.frame.size.width - self.frame.origin.x;
}

- (void)setXym_view_rightToSuper:(CGFloat)rightToSuper {
    CGRect frame = self.frame;
    frame.origin.x =  self.superview.bounds.size.width - self.frame.size.width - rightToSuper;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)xym_view_bottomToSuper {
    return self.superview.bounds.size.height - self.frame.size.height - self.frame.origin.y;
}

- (void)setXym_view_bottomToSuper:(CGFloat)bottomToSuper {
    CGRect frame = self.frame;
    frame.origin.y =  self.superview.bounds.size.height - self.frame.size.height  - bottomToSuper;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (UIViewController *)viewController{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(WIMOscillatoryAnimationType)type{
    NSNumber *animationScale1 = type == WIMOscillatoryAnimationToBigger ? @(1.15) : @(0.5);
    NSNumber *animationScale2 = type == WIMOscillatoryAnimationToBigger ? @(0.92) : @(1.15);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:animationScale1 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:animationScale2 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
}

@end



@implementation UIScrollView (XYMExtension)

- (void)setXym_view_insetTop:(CGFloat)xym_view_insetTop{
    UIEdgeInsets inset = self.contentInset;
    inset.top = xym_view_insetTop;
    self.contentInset = inset;
}

- (CGFloat)xym_view_insetTop{
    return self.contentInset.top;
}

@end
