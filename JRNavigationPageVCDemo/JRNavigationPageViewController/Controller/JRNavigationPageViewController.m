//
//  JRNavigationPageViewController.m
//  ksh3
//
//  Created by JerryFans on 2017/7/11.
//  Copyright © 2017年 JerryFans. All rights reserved.
//

#import "JRNavigationPageViewController.h"
#import "JRTabView.h"
#import "JRTabScrollView.h"
#import "Masonry.h"

#if __has_feature(objc_arc)
#define JRWS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#else
#define JRWS(weakSelf)  __block __typeof(&*self)weakSelf = self;
#endif

#define JRScreenHeight  [UIScreen mainScreen].bounds.size.height
#define JRScreenWidth   [UIScreen mainScreen].bounds.size.width

@interface JRNavigationPageViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong) JRTabScrollView  *scrollView;
@property(nonatomic,strong) JRTabView  *tabView;

@property(nonatomic,assign) NSInteger  selectIndex;
@property(nonatomic,strong) NSArray<NSString *>  *titles;
@property(nonatomic,strong) NSArray<UIViewController *>  *viewControllers;
@property(nonatomic,strong) UIViewController  *currentViewController;

@property(nonatomic,assign) BOOL  isMuteScroll;/**< 是否禁止滑动 */


@end

@implementation JRNavigationPageViewController


- (void)showRedTipsWithIndex:(NSInteger)index{
    [self.tabView showRedTipsWithIndex:index];
}

- (void)muteScrollViewScroll:(BOOL)muted{
    self.isMuteScroll = muted;
}


- (void)setIsMuteScroll:(BOOL)isMuteScroll{
    _isMuteScroll = isMuteScroll;
    self.scrollView.scrollEnabled = !isMuteScroll;
}

- (instancetype)initWithViewControlers:(viewControllersReturn)viewControllers andTitles:(titlesReturn)titles{
    if (self = [super init]) {
        if (viewControllers) {
            _viewControllers = viewControllers();
        }
        if (titles) {
            _titles = titles();
        }
        
        if (self.viewControllers.count == 0 || self.titles.count == 0 || self.viewControllers.count != self.titles.count)
        {
            //不符合
            NSAssert(NO, @"请查看viewControllers和titles数量,请保持一致");
            return nil;
        }
        
    }
    
    return self;
}

- (JRTabView *)tabView{
    if (!_tabView) {
        JRWS(weakSelf);
        _tabView = [[JRTabView alloc]initWithTitles:self.titles];
        _tabView.center = self.view.center;
        [_tabView setItemChangeHandle:^(NSInteger index){
            [weakSelf.scrollView setContentOffset:CGPointMake(index * JRScreenWidth, 0) animated:YES];
            weakSelf.selectIndex = index;
            
        }];
    }
    return _tabView;
}

- (JRTabScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[JRTabScrollView alloc]init];
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [_scrollView setBackgroundColor:[UIColor clearColor]];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(JRScreenWidth * self.viewControllers.count, 0);
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (!self.childViewControllers.count) return;
    
    [self viewControllerDidAppear:self.currentViewController withIndex:self.selectIndex];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc]init]];
    self.navigationItem.titleView = self.tabView;
    
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    for (int i = 0; i < self.viewControllers.count; i++) {
        
        UIViewController *vc = self.viewControllers[i];
        [self addChildViewController:vc];
        [self.scrollView addSubview:vc.view];
        [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(JRScreenWidth);
            make.bottom.equalTo(self.view.mas_bottom);
            make.left.mas_equalTo(i * JRScreenWidth);
        }];
        
        
    }
    
    self.currentViewController = self.viewControllers[self.selectIndex];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (![scrollView isEqual:self.scrollView]) {
        return;
    }
    
    
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    CGFloat index = offset.x / bounds.size.width;
    
    [self.tabView chanageTagWithIndex:index];
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (![scrollView isEqual:self.scrollView]) {
        return;
    }
    
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    CGFloat index = offset.x / bounds.size.width;
    self.selectIndex = index;
    self.currentViewController = self.viewControllers[self.selectIndex];
    [self viewControllerDidAppear:self.currentViewController withIndex:self.selectIndex];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if (![scrollView isEqual:self.scrollView]) {
        return;
    }
    
    self.currentViewController = self.viewControllers[self.selectIndex];
    
    [self viewControllerDidAppear:self.currentViewController withIndex:self.selectIndex];
    
}


- (void)viewControllerDidAppear:(UIViewController *)vc withIndex:(NSInteger)index{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewControllerDidAppear:withTitle:index:)]) {
        
        [self.delegate viewControllerDidAppear:self.currentViewController withTitle:self.titles[index] index:self.selectIndex];
        
    }
    
    [self.tabView removeRedTipsWithIndex:index];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
