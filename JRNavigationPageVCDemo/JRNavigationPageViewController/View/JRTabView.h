//
//  JRTabView.h
//  ksh3
//
//  Created by JerryFans on 2017/7/11.
//  Copyright © 2017年 JerryFans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRTabView : UIView

@property(nonatomic,copy) void (^itemChangeHandle)(NSInteger index);

- (void)chanageTagWithIndex:(NSInteger)index;


- (instancetype)initWithTitles:(NSArray *)titles;

- (instancetype)initWithTitles:(NSArray *)titles WithItemSpacing:(CGFloat)itemSpacing;



/**
 在某个item右上角显示红点提示 一般用户新消息新内容
 
 @param index 数组下标
 */
- (void)showRedTipsWithIndex:(NSInteger)index;



/**
 移除某个item右上角红点
 
 @param index 数组下标
 */
- (void)removeRedTipsWithIndex:(NSInteger)index;


 
- (void)setupNormalColor:(UIColor *)color selectColor:(UIColor *)selectColor font:(UIFont *)font;

@end
