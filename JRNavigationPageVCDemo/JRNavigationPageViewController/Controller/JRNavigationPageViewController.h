//
//  JRNavigationPageViewController.h
//  ksh3
//
//  Created by JerryFans on 2017/7/11.
//  Copyright © 2017年 JerryFans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRMenuClassItem.h"



typedef NSArray<NSString *>*(^titlesReturn)(void);
typedef NSArray<UIViewController *>*(^viewControllersReturn)(void);
typedef NSArray<JRMenuClassItem *>*(^menuClassItemReturn)(void);


@protocol JRNavigationPageDelegate <NSObject>
@optional

- (void)viewControllerDidAppear:(UIViewController *)vc withTitle:(NSString *)title index:(NSInteger)index;


@end

@interface JRNavigationPageViewController : UIViewController

@property(nonatomic,weak) id<JRNavigationPageDelegate>  delegate;



/**
 初始化方法
 
 @param menuClassItems  classItem数组
 @param titles 标题数组
 @return 返回实例
 */
- (instancetype)initWithClassItems:(menuClassItemReturn)menuClassItems andTitles:(titlesReturn)titles;




/**
 设置标题初始颜色，以及选中颜色
 
 @param normalColor 初始颜色
 @param selectColor 选中颜色
 */
- (void)setupTitleNormalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor;


/**
 设置标题字体
 
 @param font 字体
 */
- (void)setupTitleFont:(UIFont *)font;



/**
 is muted scroll
 
 @param muted  if YES : scrollEnable = NO  , default is NO .
 */
- (void)muteScrollViewScroll:(BOOL)muted;


/**
 显示红点提示

 @param index 某个item的index
 */
- (void)showRedTipsWithIndex:(NSInteger)index;


@end
