//
//  NBAlertButton.h
//  NBAlertController
//
//  Created by NapoleonBai on 16/7/14.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NBAlertAction;

@interface NBAlertButton : UIButton

/**
 *  通过Action创建Button
 *
 *  @param alertAction 指定的Action
 *
 *  @return 创建的Button实例
 */
+ (instancetype)buttonWithAction:(NBAlertAction *)alertAction;

@end
