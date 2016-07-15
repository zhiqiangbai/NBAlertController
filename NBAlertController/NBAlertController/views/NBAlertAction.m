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
    return [NBAlertAction actionWithTitle:title color:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1 alpha:1] style:style handler:callBack];
}

+ (instancetype)actionWithTitle:(NSString *)title color:(UIColor *)tintColor style:(NBAlertActionStyle)style handler:(CallBackHandler)callBack{
    NBAlertAction *action = [NBAlertAction new];
    action.title = title;
    action.mCallBack = callBack;
    action.style = style;
    action.tintColor = tintColor;
    return action;

}

@end
