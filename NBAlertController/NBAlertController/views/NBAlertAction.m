//
//  NBAlertAction.m
//  NBAlertController
//
//  Created by NapoleonBai on 16/7/14.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import "NBAlertAction.h"

@implementation NBAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(NBAlertActionStyle)style handler:(CallBackHandler)callBack{
    return [NBAlertAction actionWithTitle:title color:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1 alpha:1] style:style autoDismiss:nil handler:callBack];
}

+ (instancetype)actionWithTitle:(NSString *)title color:(UIColor *)tintColor style:(NBAlertActionStyle)style handler:(CallBackHandler)callBack{
    
    return [NBAlertAction actionWithTitle:title color:tintColor style:style autoDismiss:nil handler:callBack];
}

+ (instancetype)actionWithTitle:(NSString *)title style:(NBAlertActionStyle)style autoDimiss:(AutoDismiss)autoDismiss handler:(CallBackHandler)callBack{
   return [NBAlertAction actionWithTitle:title color:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1 alpha:1] style:style autoDismiss:autoDismiss handler:callBack];
}


+ (instancetype)actionWithTitle:(NSString *)title color:(UIColor *)tintColor style:(NBAlertActionStyle)style autoDismiss:(AutoDismiss)autoDismiss handler:(CallBackHandler)callBack{
    NBAlertAction *action = [NBAlertAction new];
    action.title = title;
    action.mCallBack = callBack;
    action.style = style;
    action.tintColor = tintColor;
    action.mAutoDismiss = autoDismiss;
    return action;
}

@end
