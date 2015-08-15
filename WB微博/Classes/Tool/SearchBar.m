//
//  SearchBar.m
//  WB微博
//
//  Created by 黄欣 on 15/7/20.
//  Copyright (c) 2015年 黄欣. All rights reserved.
/*
 
  封装好的搜索框
 使用方法
 SearchBar *searchBar = [SearchBar searchBar];//添加搜索栏 #import"SearchBar.h"
 searchBar.height = 30;
 searchBar.width = 300;
 self.navigationItem.titleView = searchBar; 将它放在哪里
 
 */

#import "SearchBar.h"
#import "UIView+Extension.h"
@implementation SearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        self.font = [UIFont systemFontOfSize:13];
        self.placeholder = @"请输入搜索内容";
        
        self.keyboardType = UIKeyboardTypeDefault;//清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        //self.navigationItem.titleView = self;
        // 添加搜索栏内的问号（就一图片）
        UIImageView *searchIcon = [[UIImageView alloc]init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        //将问号（图片） 居中显示在 searchIcon 的框里
        searchIcon.contentMode = UIViewContentModeCenter;
        //    searchIcon.backgroundColor = [UIColor orangeColor];
        
        //将searchIcon放在searchBar 的左边 输入的字符从searchIcon后面开始
        //👇这两句话要一起写 不一起写 问号图片不会实现
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}


+(instancetype)searchBar
{
    return [[self alloc]init ];
}
//    searchBar.background = [UIImage imageNamed:@"searchbar_textfield_background"];
//    searchBar.font = [UIFont systemFontOfSize:13];
//    searchBar.placeholder = @"请输入搜索内容";
//    searchBar.keyboardType = UIKeyboardTypeDefault;//清除按钮
//    searchBar.clearButtonMode = UITextFieldViewModeAlways;
//    searchBar.height = 30;
//    searchBar.width = 300;
//
//    self.navigationItem.titleView = searchBar;
//
//    // 添加搜索栏内的问号（就一图片）
//    UIImageView *searchIcon = [[UIImageView alloc]init];
//    searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
//    searchIcon.width = 30;
//    searchIcon.height = 30;
//
//    searchIcon.contentMode = UIViewContentModeCenter;//将问号（图片） 居中显示在 searchIcon 的框里
//    //searchIcon.backgroundColor = [UIColor orangeColor];
//
//    //将searchIcon放在searchBar 的左边 输入的字符从searchIcon后面开始
//    //👇这两句话要一起写 不一起写 问号图片不会实现
//    searchBar.leftView = searchIcon;
//    searchBar.leftViewMode = UITextFieldViewModeAlways;
@end
