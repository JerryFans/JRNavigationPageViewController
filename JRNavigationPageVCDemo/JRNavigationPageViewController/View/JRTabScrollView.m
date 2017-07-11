//
//  JRTabScrollView.m
//  ksh3
//
//  Created by JerryFans on 2017/7/11.
//  Copyright © 2017年 JerryFans. All rights reserved.
//

#import "JRTabScrollView.h"

@implementation JRTabScrollView


/**< 重写手势，防止scrollView 嵌套 tableView || collectionView 测滑滑动失效 */

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return [otherGestureRecognizer.view.superview isKindOfClass:[UITableView class]] || [otherGestureRecognizer.view.superview isKindOfClass:[UICollectionView class]];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
