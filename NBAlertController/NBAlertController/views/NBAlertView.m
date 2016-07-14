//
//  NBAlertView.m
//  NBAlertController
//
//  Created by NapoleonBai on 16/7/14.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import "NBAlertView.h"
#import "NBAlertAction.h"
#import "NBalertButton.h"

/**
 *  间距
 */
const static CGFloat padding = 15.0;
/**
 *  弹窗总宽度
 */
const static CGFloat alertWidth = 280;
/**
 *  内容视图
 */
const static CGFloat containerWidth = alertWidth - 2 * padding;

const static CGFloat scrollViewWidth = containerWidth - 2*padding;

/**
 *  按钮高度
 */
const static CGFloat buttonHeight = 44.0;

@interface NBAlertView ()
/**
 *  保存事件的数组
 */
@property (nonatomic, strong)NSMutableArray<NBAlertAction *> *actions;

/**
 *  保存按钮的数组
 */
@property (nonatomic, strong)NSMutableArray<NBAlertButton *> *buttons;
/**
 *  scrollView 外层容器视图
 */
@property (nonatomic, strong)UIView *containerView;
/**
 *  滚动视图
 */
@property (nonatomic, strong)UIScrollView *scrollView;
/**
 *  标题
 */
@property (nonatomic, strong)UILabel *titleLabel;
/**
 *  消息内容
 */
@property (nonatomic, strong)UILabel *messageLabel;

@end


@implementation NBAlertView

- (NSMutableArray<NBAlertButton *> *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSMutableArray<NBAlertAction *> *)actions {
    if (!_actions) {
        _actions = [NSMutableArray array];
    }
    return _actions;
}

- (_Nonnull instancetype)initWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message {
    self = [super init];
    if (!self) { return nil; };
    
    self.layer.cornerRadius = 6;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    // 初始化
    _containerView = [[UIView alloc] init];
    _scrollView = [[UIScrollView alloc] init];
    _titleLabel = [[UILabel alloc] init];
    _messageLabel = [[UILabel alloc] init];
    
    // 添加到父视图
    [self addSubview:_containerView];
    [_containerView addSubview:_scrollView];
    [_scrollView addSubview:_titleLabel];
    [_scrollView addSubview:_messageLabel];
    
    // 设置 containerView
    _containerView.backgroundColor = [UIColor whiteColor];
    
    // 设置 titleLabel
    _titleLabel.text = title;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    
    // 设置 messageLabel
    _messageLabel.text = message;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.numberOfLines = 0;
    _messageLabel.font = [UIFont systemFontOfSize:13.0];
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *viewDicts = NSDictionaryOfVariableBindings(_titleLabel,_messageLabel,_scrollView,_containerView);
    
    CGFloat titleHeight = [_titleLabel sizeThatFits:CGSizeMake(scrollViewWidth, 0)].height;
    CGFloat messageHeight = [_messageLabel sizeThatFits:CGSizeMake(scrollViewWidth, 0)].height;
    
    CGFloat scrollViewHeight = titleHeight + messageHeight +padding*2;
    
    [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_titleLabel(scrollViewWidth)]-15-|" options:NSLayoutFormatAlignAllCenterX metrics:@{@"scrollViewWidth":@(scrollViewWidth)} views:viewDicts]];
    [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_messageLabel(scrollViewWidth)]-15-|" options:NSLayoutFormatAlignAllCenterX metrics:@{@"scrollViewWidth":@(scrollViewWidth)} views:viewDicts]];
    [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_titleLabel(titleHeight)]-5-[_messageLabel(messageHeight)]-15-|" options:0 metrics:@{@"titleHeight":@(titleHeight),@"messageHeight":@(messageHeight)} views:viewDicts]];
    
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_scrollView(containerWidth)]-|" options:0 metrics:@{@"containerWidth":@(containerWidth)} views:viewDicts]];
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_scrollView(scrollViewHeight)]-|" options:0 metrics:@{@"scrollViewHeight":@(scrollViewHeight)} views:viewDicts]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_containerView]-0-|" options:0 metrics:nil views:viewDicts]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_containerView]-0-|" options:0 metrics:nil views:viewDicts]];
    
    // 添加约束 self
    CGFloat maxHeight = [UIScreen mainScreen].bounds.size.height - 100.0;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationLessThanOrEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:maxHeight].active = YES;
    
    return self;
}

/** 添加 action */
- (void)addAction:(NBAlertAction * _Nonnull)action {
    
    // 添加到 action 数组
    [self.actions addObject:action];
    
    // 创建 button，设置它的属性
    NBAlertButton *actionButton = [NBAlertButton buttonWithAction:action];
    [actionButton setTag:[self.actions indexOfObject:action]];
    [actionButton addTarget:self action:@selector(actionButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到父视图
    [self addSubview:actionButton];
    
    // 添加到 button数组
    [self.buttons addObject:actionButton];
    
    // 因为可能添加多个 button，所以只要标记为需要更新，这样即使添加了多次也只会更新一次
    [self setNeedsUpdateConstraints];
    
}

/** 点击按钮事件 */
- (void)actionButtonDidClicked:(UIButton *)sender {
    
    // 根据 tag 取到 handler
    void (^handler) () = self.actions[sender.tag].mCallBack;
    if (handler) {
        handler();
    }
    
    // 点击button后自动dismiss
    if (_controller) {
        [_controller dismissViewControllerAnimated:YES completion:nil];
    }
    
}

/** 更新约束 */
- (void)updateConstraints {
    
    // 根据当前button的数量来布局
    switch (self.buttons.count) {
        case 2:
            [self layoutButtonsHorizontal];
            break;
        default:
            [self layoutButtonsVertical];
            break;
    }
    [super updateConstraints];
    
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

/** 两个 button 时的水平布局 */
- (void)layoutButtonsHorizontal {
    
    UIButton *leftButton = self.buttons[0];
    UIButton *rightButton = self.buttons[1];
    
    // 左边按钮
    leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:leftButton
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:buttonHeight].active = YES;
    [NSLayoutConstraint constraintWithItem:leftButton
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:leftButton
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_containerView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0.5].active = YES;
    
    // 右边按钮
    rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:rightButton
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:buttonHeight].active = YES;
    [NSLayoutConstraint constraintWithItem:rightButton
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:rightButton
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_containerView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0.5].active = YES;
    [NSLayoutConstraint constraintWithItem:rightButton
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:leftButton
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0 constant:0.5].active = YES;
    [NSLayoutConstraint constraintWithItem:rightButton
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:leftButton
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0.0].active = YES;
    
    // 设置 alert 底部约束
    [NSLayoutConstraint constraintWithItem:self
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:rightButton
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0.0].active = YES;
    
    
}

/** 垂直布局 */
- (void)layoutButtonsVertical {
    
    // 记录最下面的一个view
    UIView *lastView;
    
    // 遍历在数组中的button，添加到alert上
    for(UIButton *button in self.buttons) {
        
        if(!lastView) {
            lastView = _containerView;
        }
        
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint constraintWithItem:button
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeft
                                    multiplier:1.0
                                      constant:0.0].active = YES;
        [NSLayoutConstraint constraintWithItem:button
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeRight
                                    multiplier:1.0
                                      constant:0.0].active = YES;
        [NSLayoutConstraint constraintWithItem:button
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:buttonHeight].active = YES;
        [NSLayoutConstraint constraintWithItem:button
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:lastView
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:0.5].active = YES;
        
        lastView = button;
        
    }
    
    // 设置 alert 底部约束
    [NSLayoutConstraint constraintWithItem:self
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:lastView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0.0].active = YES;
}


@end
