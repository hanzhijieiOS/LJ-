

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WIMOscillatoryAnimationType) {
    WIMOscillatoryAnimationToBigger = 0,
    WIMOscillatoryAnimationToSmaller,
};

@interface UIView (XYMExtension)

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat xym_view_top;

/**
 * Shortcut for frame.origin.x
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat xym_view_left;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat xym_view_bottom;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat xym_view_right;


/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat xym_view_centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat xym_view_centerY;


/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat xym_view_width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat xym_view_height;


/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint xym_view_origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize xym_view_size;


/**
 *  shortcut for bottom to superview
 *  set frame.origin.y = superview.height - bottomToSuper - frame.size.height
 */
@property (nonatomic) CGFloat xym_view_bottomToSuper;

/**
 *  Shortcut for right to superview
 *  Sets frame.origin.x = superview.width - rightToSuper -frame.size.width
 */
@property (nonatomic) CGFloat xym_view_rightToSuper;


/**
 *  find view`s first View Controller
 */
- (UIViewController *)viewController;

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(WIMOscillatoryAnimationType)type;
@end


@interface UIScrollView (WRTCExtension)
@property (assign, nonatomic) CGFloat xym_view_insetTop;

@end
