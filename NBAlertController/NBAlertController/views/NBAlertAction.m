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
    NBAlertAction *action = [NBAlertAction new];
    action.title = title;
    action.mCallBack = callBack;
    action.style = style;
    return action;
}

@end
