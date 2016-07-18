//
//  ViewController.m
//  NBAlertController
//
//  Created by NapoleonBai on 16/7/14.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import "ViewController.h"
#import "NBAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  自定义视图
 *
 *  @return
 */
- (UIView *)customView{
    UIView *bgView = [UIView new];//[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 64)];
    bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UITextField *textField = [UITextField new];
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [UIColor redColor].CGColor;
    
    textField.placeholder = @"输入验证码";
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"code_image"];
    
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [bgView addSubview:textField];
    [bgView addSubview:imageView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(textField,imageView);
    
    [bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[textField]-10-[imageView]-5-|" options:0 metrics:nil views:views]];
    [bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[textField(44)]-10-|" options:0 metrics:nil views:views]];
    [bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[imageView(44)]-10-|" options:0 metrics:nil views:views]];

    [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeHeight multiplier:2.5 constant:0];
    
    return bgView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // 创建 action
    NBAlertAction *defaultAction = [NBAlertAction actionWithTitle:@"确定" style:NBAlertActionStyleDefault handler:^{ NSLog(@"Default"); }];
    NBAlertAction *destructiveAction = [NBAlertAction actionWithTitle:@"重要提醒" style:NBAlertActionStyleDestructive handler:^{ NSLog(@"Destructive"); }];
    NBAlertAction *cancelAction = [NBAlertAction actionWithTitle:@"取消" style:NBAlertActionStyleCancel handler:^{ NSLog(@"Cancel"); }];
    
    NSArray *actionArrays;
    

    if (indexPath.row == 5) {
        NBAlertController *cusAlert = [NBAlertController alertWithTitle:@"温馨提示" customView:[self customView]];
        
        NBAlertAction *sureAction = [NBAlertAction actionWithTitle:@"确定" color:[UIColor redColor] style:NBAlertActionStyleDefault autoDismiss:^BOOL{
            return arc4random()%2==1;
        } handler:^{
            NSLog(@"点击===>>>");
        }];
        
        [cusAlert addActions:@[sureAction,cancelAction]];

        // 可以设置 alertView 的圆角半径，默认为6
        cusAlert.alertViewCornerRadius = 10;
        // 一次性添加
        [cusAlert addActions:actionArrays];
        
        [self presentViewController:cusAlert animated:YES completion:nil];

        return;
    }
    
    NSString *message;

    switch (indexPath.row) {
        case 0:
            message = @"这是展示的两个按钮的Alert!";
            actionArrays = @[defaultAction,cancelAction];
            break;
        case 1:
            message = @"这里展示的是三个按钮的Alert";
            actionArrays = @[defaultAction,destructiveAction,cancelAction];
            break;
        case 2:
            message = @"这里展示的是多个按钮的Alert";
            actionArrays = @[defaultAction,destructiveAction,destructiveAction,destructiveAction,destructiveAction,destructiveAction,destructiveAction,destructiveAction,destructiveAction,cancelAction];
            break;
        case 3:
            message = @"这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert这里展示的是长文字信息和多个按钮的Alert";
            actionArrays = @[defaultAction,destructiveAction,destructiveAction,destructiveAction,destructiveAction,destructiveAction,destructiveAction,destructiveAction,destructiveAction,cancelAction];
            break;
        case 4:
        {
            message = @"自定义Default按钮和Cancel按钮文字颜色";
            NBAlertAction *defaultAction1 = [NBAlertAction actionWithTitle:@"确定" color:[UIColor yellowColor] style:NBAlertActionStyleDefault handler:^{
            
            }];
            NBAlertAction *cancelAction1 = [NBAlertAction actionWithTitle:@"取消" color:[UIColor greenColor] style:NBAlertActionStyleCancel handler:^{
                
            }];
            actionArrays = @[defaultAction1,destructiveAction,cancelAction1];
        }
            break;

            
        default:
            break;
    }
    //创建Alert对象,并传入标题和提示消息内容
    NBAlertController *alert = [NBAlertController alertWithTitle:@"温馨提示"
                                                         message:message];
    
    // 可以设置 alertView 的圆角半径，默认为6
    alert.alertViewCornerRadius = 10;
    // 一次性添加action,同时也提供了  addAction 添加单个
    [alert addActions:actionArrays];

    [self presentViewController:alert animated:YES completion:nil];

}

@end
