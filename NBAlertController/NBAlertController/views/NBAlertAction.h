//
//  NBAlertAction.h
//  NBAlertController
//
//  Created by NapoleonBai on 16/7/14.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NBAlertActionStyle) {
    NBAlertActionStyleDefault,
    NBAlertActionStyleCancel,
    NBAlertActionStyleDestructive
};

typedef void(^CallBackHandler)();

@interface NBAlertAction : NSObject
/**
 *  按钮标题
 */
@property (nonatomic, copy)NSString *title;

/**
 *  回执事件
 */
@property (nonatomic, copy)CallBackHandler mCallBack;

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

@end
