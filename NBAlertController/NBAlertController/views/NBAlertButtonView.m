//
//  NBAlertButtonView.m
//  NBAlertController
//
//  Created by NapoleonBai on 16/7/14.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import "NBAlertButtonView.h"
#import "NBAlertAction.h"

static NSString * const s_nb_alert_button_view_cell = @"NBAlertButtonViewCell";


@interface NBAlertButtonView()<UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray<NSMutableArray<NBAlertAction *>*>*actions;

@end

@implementation NBAlertButtonView

- (NSMutableArray<NSMutableArray<NBAlertAction *> *> *)actions{
    if (!_actions) {
        _actions = @[].mutableCopy;
    }
    return _actions;
}

+ (instancetype)initWithActions:(NSArray<NBAlertAction *> *)actions{
    NBAlertButtonView *view = [NBAlertButtonView new];

    NSMutableArray *defaultActions = @[].mutableCopy;
    NSMutableArray *cancelActions = @[].mutableCopy;
    NSMutableArray *destructivetActions = @[].mutableCopy;

    for (NBAlertAction *action in actions) {
        switch (action.style) {
            case NBAlertActionStyleCancel:
                [cancelActions addObject:action];
                break;
            case NBAlertActionStyleDefault:
                [defaultActions addObject:action];
                break;
            case NBAlertActionStyleDestructive:
                [destructivetActions addObject:action];
                break;
        }
    }
    if (defaultActions.count) {
        [view.actions addObject:defaultActions];
    }
    if (destructivetActions.count) {
        [view.actions addObject:destructivetActions];
    }
    if (cancelActions.count) {
        [view.actions addObject:cancelActions];
    }
    return view;
}

- (instancetype)init{
    if (self = [super init]) {
        self.dataSource = self;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.actions.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.actions[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:s_nb_alert_button_view_cell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:s_nb_alert_button_view_cell];
    }
    return cell;
}


@end
