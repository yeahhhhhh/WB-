//
//  statusModle(微博模型).m
//  WB微博
//
//  Created by 黄欣 on 15/9/1.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "statusModle(微博模型).h"
#import "userModle.h"
@implementation statusModle______
+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[statusPhotoModle class]};//使 pic_urls数组中存放 statusPhotoModle的数据模型
}

- (NSString *)created_at
{
    //日期格式化类
    NSDateFormatter *f = [[NSDateFormatter alloc]init];
    f.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];

    //设置日期格式
    //Wed Sep 16 12:37:09 +0800 2015
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
    //EEE MMM 16 HH:mm:ss z     yyyy
    
    
    
    f.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createdDate = [f dateFromString:_created_at];
    //当前时间
    NSDate *now = [NSDate date];
    
    //日历对象（方便比较两个日期间的差距）
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    //NSCalendarUnit 枚举代表想获取哪些值 比年月日时分秒
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    //比较两个时间差
   NSDateComponents *components = [calender components:unit fromDate:createdDate toDate:now options:0];
    
//    //获得某个时间的年月日时分秒
//    NSDateComponents *createdComponents = [calender components:unit fromDate:createdDate];
//    NSDateComponents *nowComponents = [calender components:unit fromDate:now];
    
    
    
    if ([createdDate isThisYear]) {
        if ([createdDate isYesterday]) {
            f.dateFormat = @"昨天 HH:mm";
            return [f stringFromDate:createdDate];
        }else if ([createdDate isToday]){
            if (components.hour >= 1){
                return [NSString stringWithFormat:@"%ld小时前", (long)components.hour];
            }
            else if (components.minute >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前", (long)components.minute];
            }else {
                return  @"刚刚";
            }
            
        }
        else {//今年的其他日子
            f.dateFormat = @"MM-dd HH:mm";
            return [f stringFromDate:createdDate];
        }
        
    }else{
        f.dateFormat = @"yyyy-MM-dd HH:mm";
        return [f stringFromDate:createdDate];
    }
}
/**
 *  重写source的set方法 截取来源
 */
- (void)setSource:(NSString *)source
{
    _source = source;

    if (source.length > 0) {
        NSRange range ;
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString: @"</"].location - range.location;
        _source = [NSString stringWithFormat:@"来自:%@",[source substringWithRange:range]];
        
    }
    
    
    
}





@end
