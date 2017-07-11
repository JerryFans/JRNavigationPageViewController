//
//  JRTabView.m
//  ksh3
//
//  Created by JerryFans on 2017/7/11.
//  Copyright © 2017年 JerryFans. All rights reserved.
//

#import "JRTabView.h"
#import "Masonry.h"



@interface JRTabView()


@property(nonatomic,strong) NSMutableArray  *buttonArray;
@property(nonatomic,strong) NSArray  *infoArray;
@property(nonatomic,strong) NSMutableArray  *widthArrays;
@property(nonatomic,strong) UIView  *lineView;
@property(nonatomic,strong) NSMutableArray  *redTipsArrays;


@end

@implementation JRTabView


- (NSMutableArray *)redTipsArrays{
    if (!_redTipsArrays) {
        _redTipsArrays = [NSMutableArray array];
    }
    return _redTipsArrays;
}

- (NSMutableArray *)widthArrays{
    if (!_widthArrays) {
        _widthArrays = [NSMutableArray array];
    }
    return _widthArrays;
}

- (instancetype)initWithTitles:(NSArray *)titles{
    
    if (self = [super init]) {
        
        CGFloat width = 0;
        for (NSString *title in titles) {
            NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
            CGSize size = [title sizeWithAttributes:dict];
            CGFloat buttonWidth = size.width;
            [self.widthArrays addObject:@(buttonWidth)];
            width += buttonWidth;
            if (![title isEqualToString:[titles lastObject]]) {
                width += 15;
            }
        }
        self.frame = CGRectMake(0, 0, width, 44);
        _infoArray = titles;
        [self configSubView];
        
        
    }
    
    return self;
    
}


- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:[UIColor colorWithRed:42 green:187 blue:180 alpha:1.0]];
    }
    return _lineView;
}


- (NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (void)configSubView{
    
    for (int i = 0; i < self.infoArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.infoArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:51 green:51 blue:51 alpha:1.0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:42 green:187 blue:180 alpha:1.0] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor colorWithRed:42 green:187 blue:180 alpha:1.0] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(itemChanageAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            button.selected = YES;
        }
        
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(44);
            make.left.mas_equalTo(i * ([self.widthArrays[i] intValue] + 15));
            if (i == (self.infoArray.count - 1)) {
                make.right.mas_equalTo(0);
            }
        }];
        
        UIView *redView = [[UIView alloc]init];
        [redView setBackgroundColor:[UIColor redColor]];
        redView.layer.cornerRadius = 2;
        [self addSubview:redView];
        [redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(button.titleLabel.mas_right).offset(0);
            make.bottom.equalTo(button.titleLabel.mas_top).offset(0);
            make.width.height.mas_equalTo(4);
        }];
        redView.hidden = YES;
        [self.redTipsArrays addObject:redView];
        [self.buttonArray addObject:button];
        
    }
    
    [self addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.mas_equalTo(0);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo([self.widthArrays[0] intValue]);
    }];
    
}

- (void)chanageTagWithIndex:(CGFloat)index{
    
    for (UIButton *button in self.buttonArray) {
        button.selected = NO;
    }
    
    UIButton *button = [self.buttonArray objectAtIndex:index];
    button.selected = YES;
    
    CGFloat padding = index * ([self.widthArrays[(int)index] intValue] + 15);
    
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([self.widthArrays[(int)index] intValue]);
        make.left.mas_equalTo(padding);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
    
}

- (void)itemChanageAction:(UIButton *)sender{
    
    NSInteger index = [self.buttonArray indexOfObject:sender];
    
    if (self.itemChangeHandle) {
        self.itemChangeHandle(index);
    }
    
}

- (void)showRedTipsWithIndex:(NSInteger)index{
    
    UIView *redTips = (UIView *)[self.redTipsArrays objectAtIndex:index];
    
    if (redTips) {
        redTips.hidden = NO;
    }
    
    
}

- (void)removeRedTipsWithIndex:(NSInteger)index{
    
    UIView *redTips = (UIView *)[self.redTipsArrays objectAtIndex:index];
    
    if (redTips) {
        redTips.hidden = YES;
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
