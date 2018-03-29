//
//  OCViewController.m
//  JRNavigationPageVCDemo
//
//  Created by JerryFans on 2017/7/13.
//  Copyright © 2017年 JerryFans. All rights reserved.
//

#import "OCViewController.h"
#import <Masonry.h>
#import "JRNavigationPageViewController.h"


@interface OCViewController ()

@end

@implementation OCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor yellowColor]];
    UILabel* customTitleView = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 200, 44)];
    customTitleView.textColor = [UIColor blackColor];
    customTitleView.font = [UIFont systemFontOfSize:15];
    customTitleView.text = @"iPhone X";
    customTitleView.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = customTitleView;

    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    } else {
        // Fallback on earlier versions
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Push" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(0);
    }];
    
    [button addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:bottomButton];
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(-self.view.safeAreaInsets.bottom);
        } else {
            make.bottom.mas_equalTo(0);
        }
    }];
    [bottomButton setBackgroundColor:[UIColor whiteColor]];
    [bottomButton setTitle:@"Next" forState:UIControlStateNormal];
    bottomButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [bottomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view.
}

- (void)pushAction {
    
//    JRMenuClassItem *ocItem = [[JRMenuClassItem alloc]init];
//    ocItem.className = @"OCViewController";
//
//    JRMenuClassItem *swiftItem = [[JRMenuClassItem alloc]init];
//    swiftItem.className = @"OCViewController";
//
//    JRNavigationPageViewController *pageVC = [[JRNavigationPageViewController alloc]initWithClassItems:^NSArray<JRMenuClassItem *> *{
//        return @[ocItem,swiftItem];
//    } andTitles:^NSArray<NSString *> *{
//        return @[@"精选",@"主题"];
//    }];
    OCViewController *pageVC = [[OCViewController alloc] init];
    pageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pageVC animated:YES];
    pageVC.hidesBottomBarWhenPushed = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
