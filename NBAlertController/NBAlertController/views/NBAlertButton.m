//
//  NBAlertButton.m
//  NBAlertController
//
//  Created by NapoleonBai on 16/7/14.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import "NBAlertButton.h"

#import "NBAlertAction.h"

@implementation NBAlertButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
+*/

+ (instancetype)buttonWithAction:(NBAlertAction *)alertAction{
    NBAlertButton *actionButton = [NBAlertButton buttonWithType:UIButtonTypeCustom];
    [actionButton setTitle:alertAction.title forState:UIControlStateNormal];
    [actionButton setTitleColor:alertAction.tintColor forState:UIControlStateNormal];
    [actionButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [actionButton setBackgroundImage:[NBAlertButton createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [actionButton setBackgroundImage:[NBAlertButton createImageWithColor:[[UIColor lightGrayColor] colorWithAlphaComponent:.3]] forState:UIControlStateHighlighted];
    if (alertAction.style == NBAlertActionStyleDestructive) {
        [actionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    } else if (alertAction.style == NBAlertActionStyleCancel) {
        actionButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    }

    return actionButton;
}

/**
 *  生成指定颜色的Image
 *
 *  @param color 指定颜色
 *
 *  @return 生成的Image对象
 */
+ (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
