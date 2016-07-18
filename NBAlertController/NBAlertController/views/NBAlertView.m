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

#define NB_NSIGNLE_PX (1 / [UIScreen mainScreen].scale)

/**
 *  间距
 */
const static CGFloat padding = 15.0f;

const static CGFloat alertViewWidth = 270.0f;

const static CGFloat containerWidth = alertViewWidth - 2 * padding;

/**
 *  按钮高度
 */
const static CGFloat buttonHeight = 44.0f;

const static NSUInteger maxButtonCount = 6;

const static CGFloat bottomViewMaxHeight = maxButtonCount * (buttonHeight+1) + padding;

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
 *  顶部滚动视图<title,message>
 */
@property (nonatomic, strong)UIScrollView *topScrollView;
/**
 *  底部滚动视图<button>
 */
@property (nonatomic, strong)UIScrollView *bottomScrollView;
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
    return [self initWithTitle:title message:message customView:nil];
}


- (_Nonnull instancetype)initWithTitle:(NSString * _Nullable)title customView:(UIView * _Nullable)cusView{
    return [self initWithTitle:title message:nil customView:cusView];
}

- (_Nonnull instancetype)initWithTitle:(NSString * _Nullable)title message:(NSString *_Nullable)message customView:(UIView * _Nullable)cusView{
    self = [super init];
    if (!self) { return nil; };
    
    self.layer.cornerRadius = 6;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    self.topScrollView = [UIScrollView new];
    self.bottomScrollView = [UIScrollView new];
    self.titleLabel = [UILabel new];
    
    [self.bottomScrollView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    self.bottomScrollView.bounces = NO;
    
    
    // 添加到父视图
    [self addSubview:self.topScrollView];
    [self addSubview:self.bottomScrollView];
    [self.topScrollView addSubview:self.titleLabel];
    
    // 设置 titleLabel
    _titleLabel.text = title;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.topScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    NSDictionary *viewDicts;
    
    CGFloat titleHeight = [_titleLabel sizeThatFits:CGSizeMake(containerWidth, 0)].height;
    
    CGFloat contentHeight;

    if (cusView) {
        //自定义视图
        [self.topScrollView addSubview:cusView];
        cusView.translatesAutoresizingMaskIntoConstraints = NO;
        
        viewDicts = @{@"_titleLabel":_titleLabel,@"contentView":cusView,@"_topScrollView":_topScrollView,@"_bottomScrollView":_bottomScrollView};//  NSDictionaryOfVariableBindings(_titleLabel,cusView,_topScrollView,_bottomScrollView);

        contentHeight = [cusView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    }else{
        self.messageLabel = [UILabel new];
        
        [self.topScrollView addSubview:self.messageLabel];
        // 设置 messageLabel
        _messageLabel.text = message;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = [UIFont systemFontOfSize:13.0];
        
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        viewDicts = @{@"_titleLabel":_titleLabel,@"contentView":_messageLabel,@"_topScrollView":_topScrollView,@"_bottomScrollView":_bottomScrollView};// NSDictionaryOfVariableBindings(_titleLabel,_messageLabel,_topScrollView,_bottomScrollView);
        
        contentHeight = [_messageLabel sizeThatFits:CGSizeMake(containerWidth, 0)].height;

    }
    
    CGFloat scrollViewHeight = titleHeight + contentHeight +padding*2;
    NSDictionary *metrics = @{@"containerWidth":@(containerWidth),@"padding":@(padding),@"titleHeight":@(titleHeight),@"contentHeight":@(contentHeight),@"bottomViewMaxHeight":@(bottomViewMaxHeight),@"alertWidth":@(alertViewWidth),@"scrollViewHeight":@(scrollViewHeight)};
    
    [self.topScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleLabel(containerWidth)]" options:0 metrics:metrics views:viewDicts]];
    [self.topScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView(containerWidth)]" options:0 metrics:metrics views:viewDicts]];
    [self.topScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_titleLabel(titleHeight)]-padding-[contentView(contentHeight)]|" options:0 metrics:metrics views:viewDicts]];
    
    //self.topScrollView.height = screen.height-50- self.bottomScrollView.height
    //self.bottomScrollView.height <= count*button.height + 15
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[_topScrollView]-padding-|" options:0 metrics:metrics views:viewDicts]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bottomScrollView]|" options:0 metrics:metrics views:viewDicts]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_topScrollView(scrollViewHeight@100)]-padding-[_bottomScrollView]|" options:0 metrics:metrics views:viewDicts]];

    
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
    [self.bottomScrollView addSubview:actionButton];
    
    // 添加到 button数组
    [self.buttons addObject:actionButton];
    
    // 因为可能添加多个 button，所以只要标记为需要更新，这样即使添加了多次也只会更新一次
    [self setNeedsUpdateConstraints];
    
}

/**
 *  按钮点击事件
 *
 *  @param sender 被点击的按钮
 */
- (void)actionButtonDidClicked:(NBAlertButton *)sender {
    
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

/**
 *  水平布局<只有两个Button时调用>
 */
- (void)layoutButtonsHorizontal {
    
    UIButton *leftButton = self.buttons[0];
    UIButton *rightButton = self.buttons[1];
    leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(leftButton,rightButton);
    NSDictionary *metrics = @{@"buttonHeight":@(buttonHeight),@"buttonWidth":@((alertViewWidth-NB_NSIGNLE_PX)/2.0),@"bottomViewHeight":@(buttonHeight+NB_NSIGNLE_PX),@"signleWidth":@(NB_NSIGNLE_PX)};
    
    [self.bottomScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[leftButton(buttonWidth)]-signleWidth-[rightButton(leftButton)]|" options:0 metrics:metrics views:views]];
    [self.bottomScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-signleWidth-[leftButton(buttonHeight)]|" options:0 metrics:metrics views:views]];
    [self.bottomScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-signleWidth-[rightButton(buttonHeight)]|" options:0 metrics:metrics views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomScrollView(bottomViewHeight)]" options:0 metrics:metrics views:@{@"_bottomScrollView":_bottomScrollView}]];
}

/**
 *  垂直布局<只要不是两个按钮,都会进入>
 */
- (void)layoutButtonsVertical {
    
    // 记录最下面的一个view
    UIView *lastView;
    
    NSDictionary *metrics = @{@"buttonHeight":@(buttonHeight),@"alertWidth":@(alertViewWidth),@"bottomViewHeight":@(self.buttons.count * (buttonHeight+NB_NSIGNLE_PX) + padding),@"bottomViewMaxHeight":@(bottomViewMaxHeight),@"padding":@(padding+NB_NSIGNLE_PX),@"signleWidth":@(NB_NSIGNLE_PX)};
    
    // 遍历在数组中的button，重新调整位置
    for(int i = 0;i<self.buttons.count;i++) {
        UIButton *button = self.buttons[i];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        
        if(!lastView) {
            //如果是第一个Button
            [self.bottomScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[button(==alertWidth)]|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(button)]];
            //当只有一个button时会进入
            if (i == self.buttons.count-1) {
                [self.bottomScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button(==buttonHeight)]|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(button)]];
            }else{
                [self.bottomScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button(==buttonHeight)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(button)]];
            }
        }else{
            [self.bottomScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[button(==alertWidth)]|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(button,lastView)]];
            //最后一个button时进入
            if (i == self.buttons.count-1) {
                [self.bottomScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastView]-padding-[button(==buttonHeight)]|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(button,lastView)]];
            }else{
                [self.bottomScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastView]-signleWidth-[button(==buttonHeight)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(button,lastView)]];
            }
        }
        lastView = button;
    }
    //更新bottomScrollView的高度
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomScrollView(bottomViewHeight@750,<=bottomViewMaxHeight@1000)]" options:0 metrics:metrics views:@{@"_bottomScrollView":_bottomScrollView}]];
    
    
}



@end
