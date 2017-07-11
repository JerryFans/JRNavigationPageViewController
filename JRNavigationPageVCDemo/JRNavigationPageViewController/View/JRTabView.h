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

- (void)chanageTagWithIndex:(CGFloat)index;


- (instancetype)initWithTitles:(NSArray *)titles;


- (void)showRedTipsWithIndex:(NSInteger)index;

- (void)removeRedTipsWithIndex:(NSInteger)index;

@end
