//
//  WZFlashButton.m
//  WZRippleButton
//
//  Created by z on 15-1-6.
//  Copyright (c) 2015年 SatanWoo. All rights reserved.
//

#import "WZFlashButton.h"

const CGFloat WZFlashInnerCircleInitialRaius = 20;

@interface WZFlashButton()
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation WZFlashButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    [self addGestureRecognizer:tap];
    
    self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.textLabel.backgroundColor = [UIColor clearColor];
    [self.textLabel setTextColor:[UIColor whiteColor]];
    [self.textLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.textLabel];
    
    self.backgroundColor = [UIColor grayColor];
    self.buttonType = WZFlashButtonTypeInner;
}

#pragma mark - Public
- (void)setText:(NSString *)text
{
    [self setText:text withTextColor:nil];
}

- (void)setTextColor:(UIColor *)textColor
{
    [self setText:nil withTextColor:textColor];
}

- (void)setText:(NSString *)text withTextColor:(UIColor *)textColor
{
    if (textColor) {
        [self.textLabel setTextColor:textColor];
    }
    
    if (text) {
        [self.textLabel setText:text];
    }
}

- (void)setButtonType:(WZFlashButtonType)buttonType
{
    if (buttonType == WZFlashButtonTypeInner) {
        self.clipsToBounds = YES;
    } else {
        self.clipsToBounds = NO;
    }
    
    _buttonType = buttonType;
}

#pragma mark - Private
- (void)didTap:(UITapGestureRecognizer *)tapGestureHandler
{
    CGPoint tapLocation = [tapGestureHandler locationInView:self];
    CAShapeLayer *circleShape = nil;
    CGFloat scale = 1.0f;
    
    CGFloat width = self.bounds.size.width, height = self.bounds.size.height;
    
    if (self.buttonType == WZFlashButtonTypeInner) {
        CGFloat biggerEdge = width > height ? width : height, smallerEdge = width > height ? height : width;
        CGFloat radius = smallerEdge / 2 > WZFlashInnerCircleInitialRaius ? WZFlashInnerCircleInitialRaius : smallerEdge / 2;
        
        scale = biggerEdge / radius + 0.5;
        circleShape = [self createCircleShapeWithPosition:CGPointMake(tapLocation.x - radius, tapLocation.y - radius)
                                                 pathRect:CGRectMake(0, 0, radius * 2, radius * 2)
                                                   radius:radius];
    } else {
        scale = 2.5f;
        circleShape = [self createCircleShapeWithPosition:CGPointMake(width/2, height/2)
                                                 pathRect:CGRectMake(-CGRectGetMidX(self.bounds), -CGRectGetMidY(self.bounds), width, height)
                                                   radius:self.layer.cornerRadius];
    }
    
    [self.layer addSublayer:circleShape];
    
    CAAnimationGroup *groupAnimation = [self createFlashAnimationWithScale:scale duration:0.5f];

    /* Use KVC to remove layer to avoid memory leak */
    [groupAnimation setValue:circleShape forKey:@"circleShaperLayer"];
    
    [circleShape addAnimation:groupAnimation forKey:nil];
    [circleShape setDelegate:self];
    
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (CAShapeLayer *)createCircleShapeWithPosition:(CGPoint)position pathRect:(CGRect)rect radius:(CGFloat)radius
{
    CAShapeLayer *circleShape = [CAShapeLayer layer];
    circleShape.path = [self createCirclePathWithRadius:rect radius:radius];
    circleShape.position = position;
    
    if (self.buttonType == WZFlashButtonTypeInner) {
        circleShape.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
        circleShape.fillColor = self.flashColor ? self.flashColor.CGColor : [UIColor whiteColor].CGColor;
    } else {
        circleShape.fillColor = [UIColor clearColor].CGColor;
        circleShape.strokeColor = self.flashColor ? self.flashColor.CGColor : [UIColor purpleColor].CGColor;
    }
   
    circleShape.opacity = 0;
    circleShape.lineWidth = 1;
    
    return circleShape;
}

- (CAAnimationGroup *)createFlashAnimationWithScale:(CGFloat)scale duration:(CGFloat)duration
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation, alphaAnimation];
    animation.delegate = self;
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    return animation;
}

- (CGPathRef)createCirclePathWithRadius:(CGRect)frame radius:(CGFloat)radius
{
    return [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:radius].CGPath;
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CALayer *layer = [anim valueForKey:@"circleShaperLayer"];
    if (layer) {
        [layer removeFromSuperlayer];
    }
}

@end
