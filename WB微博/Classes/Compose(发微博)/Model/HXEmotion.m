//
//  HXEmotion.m
//  WB微博
//
//  Created by 黄欣 on 15/9/27.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HXEmotion.h"
#import "MJExtension.h"
@interface HXEmotion() <NSCoding>//存储协议

@end
@implementation HXEmotion

//这一句就代替了下面所有
MJCodingImplementation
/**
 *  从文件中解析文件时调用
 */
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super init];
//    if (self) {
//        self.chs = [aDecoder decodeObjectForKey:@"chs"];
//        self.png = [aDecoder decodeObjectForKey:@"png"];
//        self.code = [aDecoder decodeObjectForKey:@"code"];
//    }
//    return self;
//}
///**
// *  将对象写入文件的时候调用
// */
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:self.png forKey:@"png"];
//    [aCoder encodeObject:self.chs forKey:@"chs"];
//    [aCoder encodeObject:self.code forKey:@"code"];
//}
@end
