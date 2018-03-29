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

#define JRiOS11    ( [[UIDevice currentDevice].systemVersion floatValue] >= 11.0 ) ? YES : NO

@interface JRNavigationPageViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong) JRTabScrollView  *scrollView;
@property(nonatomic,strong) JRTabView  *tabView;
@property(nonatomic,assign) NSInteger  selectIndex;
@property(nonatomic,strong) NSArray<UIViewController *>  *viewControllers;
@property(nonatomic,strong) NSArray<JRMenuClassItem *>  *menuClassItems;
@property(nonatomic,strong) NSArray<NSString *>  *titles;
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

- (instancetype)initWithClassItems:(menuClassItemReturn)menuClassItems andTitles:(titlesReturn)titles{
    if (self = [super init]) {
        if (menuClassItems) {
            _menuClassItems = menuClassItems();
        }
        if (titles) {
            _titles  = titles();
        }
        
        if (self.menuClassItems.count == 0 || self.titles.count == 0 || self.menuClassItems.count != self.titles.count)
        {
            //不符合
            NSAssert(NO, @"请查看menuClassItems和titles数量,请保持一致");
            return nil;
        }
        
    }
    
    return self;
}


- (JRTabView *)tabView{
    if (!_tabView) {
        JRWS(weakSelf);
        _tabView = [[JRTabView alloc]initWithTitles:self.titles];
        if (!JRiOS11) {
            _tabView.center = self.view.center;
        }
        [_tabView setItemChangeHandle:^(NSInteger index){
            [weakSelf.scrollView setContentOffset:CGPointMake(index * JRScreenWidth, -64) animated:YES];
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
        _scrollView.contentSize = CGSizeMake(JRScreenWidth * self.menuClassItems.count, 0);
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (!self.childViewControllers.count) [self setupViewContrllerAtIndex:self.selectIndex];
    
    self.currentViewController = self.menuClassItems[self.selectIndex].getInstance;

    [self viewControllerDidAppear:self.currentViewController withIndex:self.selectIndex];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = self.tabView;
    
    if (JRiOS11) {
        [self.navigationController.navigationBar addSubview:self.tabView];
        [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
    }
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.scrollView.contentSize = CGSizeMake(JRScreenWidth * self.menuClassItems.count, 0);
    
}


- (void)setupViewContrllerAtIndex:(NSInteger)index{
    
    JRMenuClassItem *classItem = [self.menuClassItems objectAtIndex:index];
    UIViewController *vc  = classItem.getInstance;
    if (![self.childViewControllers containsObject:vc]) {
        
            [self addChildViewController:vc];
            [self.scrollView addSubview:vc.view];
            [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.width.mas_equalTo(JRScreenWidth);
                    make.bottom.equalTo(self.view.mas_bottom);
                    make.left.mas_equalTo(index * JRScreenWidth);
                }];
        
        
    }
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (![scrollView isEqual:self.scrollView]) {
        return;
    }
    
    
    CGPoint offset = scrollView.contentOffset;
    
    NSInteger index = offset.x / JRScreenWidth;
    
    
    CGFloat setupPage = ((index == self.menuClassItems.count - 1) || (offset.x == 0)) ? index : index + 1;
    
    [self setupViewContrllerAtIndex:setupPage];
    
    [self.tabView chanageTagWithIndex:index];
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (![scrollView isEqual:self.scrollView]) {
        return;
    }
    
    CGPoint offset = scrollView.contentOffset;
    CGFloat index = offset.x / JRScreenWidth;
    self.selectIndex = index;
    
    self.currentViewController = self.menuClassItems[self.selectIndex].getInstance;
    [self viewControllerDidAppear:self.currentViewController withIndex:self.selectIndex];
    
}



- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if (![scrollView isEqual:self.scrollView]) {
        return;
    }
    
    self.currentViewController = self.menuClassItems[self.selectIndex].getInstance;
    [self viewControllerDidAppear:self.currentViewController withIndex:self.selectIndex];
    
}


- (void)viewControllerDidAppear:(UIViewController *)vc withIndex:(NSInteger)index{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewControllerDidAppear:withTitle:index:)]) {
        
        [self.delegate viewControllerDidAppear:self.currentViewController withTitle:self.titles[index] index:self.selectIndex];
        
    }
    
    [self.tabView removeRedTipsWithIndex:index];
    
}


#pragma mark 设置UI

- (void)setupTitleNormalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor{
    [self.tabView setupNormalColor:normalColor selectColor:selectColor font:nil];
}

- (void)setupTitleFont:(UIFont *)font{
    [self.tabView setupNormalColor:nil selectColor:nil font:font];
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
