//
//  NBAlertController.h
//  NBAlertController
//
//  Created by NapoleonBai on 16/7/14.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NBAlertAction.h"


/** 灰色背景透明度 */
static const CGFloat nb_backgroundAlpha = 0.4;


@interface NBAlertController : UIViewController
/** alert 视图 */
@property (nonnull, nonatomic, strong)UIView *alertView;

/** 半透明背景 */
@property (nonnull, nonatomic, strong)UIView *backgroundView;

- (void)setAlertViewCornerRadius:(CGFloat)cornerRadius;

/**
 *    添加 action
 *
 *    @param action action
 */
- (void)addAction:(NBAlertAction * _Nonnull)action;

/**
 *    直接添加一个数组的 action
 *
 *    @param actions 放有 action 的数组
 */
- (void)addActions:(NSArray<NBAlertAction *> * _Nonnull)actions;

/**
 *    默认转场初始化方法
 *
 *    @param title   标题
 *    @param message 消息
 *
 *    @return alert控制器
 */
+ (_Nonnull instancetype)alertWithTitle:(NSString * _Nullable)title
                                message:(NSString * _Nullable)message;

+ (_Nonnull instancetype)alertWithTitle:(NSString * _Nullable)title
                             customView:(UIView *)view ;

@end
