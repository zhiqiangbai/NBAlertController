//
//  NBAlertView.h
//  NBAlertController
//
//  Created by NapoleonBai on 16/7/14.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NBAlertAction;

@interface NBAlertView : UIView

/**
 *  保存当前的视图控制器，dismiss时用
 */
@property (nonatomic, weak, nullable)UIViewController *controller;

/**
 *    初始化 AlertView
 *
 *    @param title   标题
 *    @param message 提示文字内容
 */
- (_Nonnull instancetype)initWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message;

/**
 *    添加一个 action
 *
 *    @param action action
 */
- (void)addAction:(NBAlertAction * _Nonnull)action;


@end
