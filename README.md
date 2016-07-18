# NBAlertController
#效果展示图
![AlertController展示图](https://github.com/NapoleonBaiAndroid/NBAlertController/blob/master/NBAlertController/Resource/test.gif "AlertController展示图")

#使用方法
```Objective-c
    //创建Alert对象,并传入标题和提示消息内容
    NBAlertController *alert = [NBAlertController alertWithTitle:@"温馨提示"
                                                         message:message];
    
    // 可以设置 alertView 的圆角半径，默认为6
    alert.alertViewCornerRadius = 10;
    // 一次性添加action,同时也提供了  addAction 添加单个
    [alert addActions:actionArrays];

    [self presentViewController:alert animated:YES completion:nil];
    
    其中,actionsArrays为action数组
    // 创建 action
    NBAlertAction *defaultAction = [NBAlertAction actionWithTitle:@"确定" style:NBAlertActionStyleDefault handler:^{ NSLog(@"Default"); }];
    NBAlertAction *destructiveAction = [NBAlertAction actionWithTitle:@"重要提醒" style:NBAlertActionStyleDestructive handler:^{ NSLog(@"Destructive"); }];
    NBAlertAction *cancelAction = [NBAlertAction actionWithTitle:@"取消" style:NBAlertActionStyleCancel handler:^{ NSLog(@"Cancel"); }];
    
    提供三种action供创建,可添加多次,通过block进行点击事件回传
    
    
    当然,如果是自定义显示内容,则
    NBAlertController *cusAlert = [NBAlertController alertWithTitle:@"温馨提示" customView:[self customView]];
    其中的 [self customView];即为自定义视图的函数.可在demo中查看
    
```
#其他
目前即可这样简单使用,可替代UIAlertView和UIAlertController的Alert模式,暂未支持UIActionSheet模式的对话框,后期再加入.
反正就是使用简单,操作方便,想改就改,就是这么任性
