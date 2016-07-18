//
//  NBAlertController.m
//  NBAlertController
//
//  Created by NapoleonBai on 16/7/14.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import "NBAlertController.h"
#import "NBAlertView.h"

#import "NBAlertPresentSystem.h"
#import "NBAlertDismissFadeOut.h"


@interface NBAlertController ()<UIViewControllerTransitioningDelegate>

@end

@implementation NBAlertController


- (instancetype)init {
    if (self = [super init]) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;    // 自定义转场模式

        // 灰色半透明背景
        _backgroundView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = nb_backgroundAlpha;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 背景透明
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_backgroundView];
    [self.view addSubview:_alertView];
    
    NSDictionary *metrics = @{@"viewHeight":@([UIScreen mainScreen].bounds.size.height-50),@"viewWidth":@270};
    _alertView.translatesAutoresizingMaskIntoConstraints = NO;
    //设置alert大小
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_alertView(viewWidth)]" options:0 metrics:metrics views:@{@"_alertView":_alertView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_alertView(<=viewHeight)]" options:0 metrics:metrics views:@{@"_alertView":_alertView}]];

    // 设置 alertView 在屏幕中心
    //垂直居中
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_alertView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    //水平居中
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_alertView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    
}

/** 添加 action */
- (void)addAction:(NBAlertAction * _Nonnull)action {
    if ([_alertView isMemberOfClass:[NBAlertView class]]) {
        [(NBAlertView *)_alertView addAction: action];
    }
}

/** 直接添加一个数组的 action */
- (void)addActions:(NSArray<NBAlertAction *> * _Nonnull)actions {
    for (NBAlertAction *action in actions) {
        [self addAction:action];
    }
}

/** 设置 alertView 的圆角半径 */
- (void)setAlertViewCornerRadius:(CGFloat)cornerRadius {
    _alertView.layer.cornerRadius = cornerRadius;
}

#pragma mark - 类方法返回实例

/** 默认转场初始化 */
+ (_Nonnull instancetype)alertWithTitle:(NSString * _Nullable)title
                                message:(NSString * _Nullable)message {
    
    NBAlertController *alertController = [[NBAlertController alloc] init];
    alertController.alertView = [[NBAlertView alloc] initWithTitle:title message:message];
    ((NBAlertView *)(alertController.alertView)).controller = alertController;
    return alertController;
}

/** 默认转场初始化 */
+ (_Nonnull instancetype)alertWithTitle:(NSString * _Nullable)title
                             customView:(UIView *)view {
    
    NBAlertController *alertController = [[NBAlertController alloc] init];
    alertController.alertView = [[NBAlertView alloc] initWithTitle:title customView:view];
    ((NBAlertView *)(alertController.alertView)).controller = alertController;
    return alertController;
}

#pragma UIViewControllerTransitioningDelegate
/** 返回Present动画 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[NBAlertPresentSystem alloc] init];
}

/** 返回Dismiss动画 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[NBAlertDismissFadeOut alloc] init];
}

@end
