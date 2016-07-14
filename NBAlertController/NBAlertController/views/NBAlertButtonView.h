//
//  NBAlertButtonView.h
//  NBAlertController
//
//  Created by NapoleonBai on 16/7/14.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NBAlertAction;
@interface NBAlertButtonView : UITableView

+ (instancetype)initWithActions:(NSArray<NBAlertAction *>*)actions;

@end
