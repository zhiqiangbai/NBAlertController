//
//  NBAlertAction.h
//  NBAlertController
//
//  Created by NapoleonBai on 16/7/14.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NBAlertActionStyle) {
    NBAlertActionStyleDefault,
    NBAlertActionStyleCancel,
    NBAlertActionStyleDestructive
};

typedef void(^CallBackHandler)();
typedef BOOL(^AutoDismiss)();

@interface NBAlertAction : NSObject
/**
 *  按钮标题
 */
@property (nonatomic, copy)NSString *title;

/**
 *  Alert dismiss执行回调事件
 */
@property (nonatomic, copy)CallBackHandler mCallBack;
/**
 *  点击按钮是否自动dismiss<不设置则自动>
 */
@property (nonatomic, copy)AutoDismiss mAutoDismiss;



/**
 *  文字颜色
 */
@property (nonatomic, copy)UIColor *tintColor;

/**
 *  按钮风格
 */
@property (nonatomic, assign)NBAlertActionStyle style;

/**
 *    创建一个 action
 *    @param title   标题
 *    @param style   风格
 *    @param callBack 回调事件
 *
 */
+ (instancetype)actionWithTitle:(NSString *)title style:(NBAlertActionStyle)style handler:(CallBackHandler)callBack;
/**
 *    创建一个 action
 *    @param title   标题
 *    @param tintColor 文字颜色
 *    @param style   风格
 *    @param callBack 回调事件
 *
 */
+ (instancetype)actionWithTitle:(NSString *)title color:(UIColor *)tintColor style:(NBAlertActionStyle)style handler:(CallBackHandler)callBack;
/**
 *  如果需要手动控制Alert的dismiss,则调用这个
 *
 *    @param title   标题
 *    @param style   风格
 *    @param autoDismiss  这个block返回YES,则视为自动dismiss
 *    @param callBack 回调事件
 *
 *  @return
 */
+ (instancetype)actionWithTitle:(NSString *)title style:(NBAlertActionStyle)style autoDimiss:(AutoDismiss)autoDismiss handler:(CallBackHandler)callBack;
/**
 *  如果需要手动控制Alert的dismiss,则调用这个
 *
 *    @param title   标题
 *    @param tintColor 文字颜色
 *    @param style   风格
 *    @param autoDismiss  这个block返回YES,则视为自动dismiss
 *    @param callBack 回调事件
 *
 *  @return
 */
+ (instancetype)actionWithTitle:(NSString *)title color:(UIColor *)tintColor style:(NBAlertActionStyle)style autoDismiss:(AutoDismiss)autoDismiss handler:(CallBackHandler)callBack;


@end
