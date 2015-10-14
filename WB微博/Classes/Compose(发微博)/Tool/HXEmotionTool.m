//
//  HXEmotionTool.m
//  WB微博
//
//  Created by 黄欣 on 15/10/2.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HXEmotionTool.h"
#import "HXEmotion.h"
@implementation HXEmotionTool

static NSMutableArray *_emotions;
//第一次调用类的时候会调用, 只会调用一次
+(void)initialize
{
    // 加载沙盒中的表情数据
    _emotions = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]];
    if (_emotions == nil) {
        _emotions = [NSMutableArray array];
    }
}
+(void)addRecentEmotion:(HXEmotion *)emotion
{
    //删除重复表情
    for (int i = 0; i < _emotions.count; i++) {
        HXEmotion * e = _emotions[i];
        if ([e.chs isEqualToString:emotion.chs] ||[e.code isEqualToString:emotion.code]) {
            [_emotions removeObject:e];
            break;
        }
    }
    // 将表情放到数组的最前面
    [_emotions insertObject:emotion atIndex:0];
    
    //限制”最近“里的表情数量
    if (_emotions.count > 80) {
        [_emotions removeLastObject];
    }
    //沙盒路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"emotions.archive"];
    //自定义对象的存储必须使用NSKeyedArchiver
    [NSKeyedArchiver archiveRootObject:_emotions toFile:path];
}
/**
 *  返回装着HXEmotion的数组
 */
+(NSMutableArray *)recentEmotion
{
    return _emotions;
}

@end
