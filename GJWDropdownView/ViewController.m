//
//  ViewController.m
//  GJWDropdownView
//
//  Created by dfhb@rdd on 16/7/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "ViewController.h"
#import "GJWDropdownView.h"
#import "UIView+AutoLayout.h"
#import "User.h"

@interface ViewController ()<GJWDropdownViewDelegate, GJWDropdownViewDataSource>
@property (nonatomic, strong) GJWDropdownView *dropdown;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"点击测试" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button autoSetDimension:ALDimensionHeight toSize:64];
    [button autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view];
    [button autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view];
    [button autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    GJWDropdownView *dropdown = [[GJWDropdownView alloc] init];
    dropdown.delegate = self;
    dropdown.dataSource = self;
    [self.view insertSubview:dropdown atIndex:0];
    self.dropdown = dropdown;
    
    
    
    float height = 500;
    [self.dropdown autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:button withOffset:0];
    [self.dropdown autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view];
    [self.dropdown autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view];
    [self.dropdown autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view];
//    [self.dropdown autoSetDimension:ALDimensionHeight toSize:height];
//    self.dropdown.dropdownHeight = 300;
    
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        NSMutableArray *books = [NSMutableArray array];
        int count = 10;
        if (i == 5) {
            count = 0;
        }
        for (int j = 0; j < count; j++) {
            NSString *bookname = [NSString stringWithFormat:@"book%@ in %@", @(j), @(i)];
            [books addObject:bookname];
        }
        User *user = [User new];
        user.name = [NSString stringWithFormat:@"name%@", @(i)];
        user.books = books;
        [self.dataArray addObject:user];
    }
    
}

- (void)buttonClick {
    
    self.dropdown.hideDropdown = NO;
}
#pragma mark - GJWDropdownViewDataSource
- (NSInteger)numberOfRowsInDropdownView:(GJWDropdownView *)dropdownView {
    return self.dataArray.count;
}
- (NSInteger)dropdownView:(GJWDropdownView *)dropdownView numberOfRowsInMainTable:(NSInteger)mainRow {
    User *user = self.dataArray[mainRow];
    return user.books.count;
}
- (NSString *)dropdownView:(GJWDropdownView *)dropdownView titleForRowInMainTable:(NSInteger)row {
    User *user = self.dataArray[row];
    return user.name;
}
- (NSString *)dropdownView:(GJWDropdownView *)dropdownView titleForRowInSubTable:(NSInteger)subRow inMainTable:(NSInteger)mainRow {
    User *user = self.dataArray[mainRow];
    return user.books[subRow];
}
#pragma mark - GJWDropdownViewDelegate
- (void)didClickCancel {
//    [self setDropdownHidden:YES];
    
}
- (void)dropdownView:(GJWDropdownView *)dropdownView didSelectRowInMainTable:(NSInteger)row {
    
}
- (void)dropdownView:(GJWDropdownView *)dropdownView didSelectRowInSubTable:(NSInteger)subRow inMainTable:(NSInteger)mainRow {
    self.dropdown.hideDropdown = YES;
    
    NSLog(@"点击了第%@行，第%@列", @(mainRow), @(subRow));
}


@end
