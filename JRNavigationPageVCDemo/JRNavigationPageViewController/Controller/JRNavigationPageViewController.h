//
//  JRNavigationPageViewController.h
//  ksh3
//
//  Created by JerryFans on 2017/7/11.
//  Copyright © 2017年 JerryFans. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NSArray<NSString *>*(^titlesReturn)();
typedef NSArray<UIViewController *>*(^viewControllersReturn)();



@protocol JRNavigationPageDelegate <NSObject>
@optional

- (void)viewControllerDidAppear:(UIViewController *)vc withTitle:(NSString *)title index:(NSInteger)index;


@end

@interface JRNavigationPageViewController : UIViewController

@property(nonatomic,weak) id<JRNavigationPageDelegate>  delegate;




- (instancetype)initWithViewControlers:(viewControllersReturn)viewControllers andTitles:(titlesReturn)titles;


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
