//
//  GJWDropdownView.m
//  GJWDropdownView
//
//  Created by dfhb@rdd on 16/7/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "GJWDropdownView.h"
#import "UIView+AutoLayout.h"
#import "GJWMainCell.h"
#import "GJWSubCell.h"

@interface GJWDropdownView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UITableView *subTableView;
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, assign) NSInteger selectedMainRow;

@end

@implementation GJWDropdownView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = [UIColor grayColor];
        [self addSubview:backView];
        self.backView = backView;
        
        self.mainTableView = [self tableView];
        [self addSubview:self.mainTableView];
        
        self.subTableView = [self tableView];
        [self addSubview:self.subTableView];
        
        self.mainTableView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
        self.subTableView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        
        
//        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        [self.backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
        
        self.hidden = YES;
//        self.hideDropdown = YES;
        self.dropdownHeight = 300.0f;
    }
    return self;
}

- (void)setDropdownHeight:(CGFloat)dropdownHeight {
    _dropdownHeight = dropdownHeight;
    [self updateConstraints];
}

- (void)updateConstraints {
//    NSLog(@"height:%.2f",CGRectGetHeight(self.frame));
    float height = _dropdownHeight <= 0 ? 200.0f:_dropdownHeight;
    [self.mainTableView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self];
    [self.mainTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:-height];
    [self.mainTableView autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.subTableView];
    [self.mainTableView autoSetDimension:ALDimensionHeight toSize:height];
    [self.mainTableView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.subTableView];
    
    [self.subTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.mainTableView];
    [self.subTableView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self];
    [self.subTableView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.mainTableView];

    [self.backView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    [super updateConstraints];
}

- (UITableView *)tableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 44;
    tableView.tableFooterView = [UIView new];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (tableView == self.mainTableView) {
        
        if ([self.dataSource respondsToSelector:@selector(dropdownView:cellForTableView:inMainTable:)]) {
            cell = [self.dataSource dropdownView:self cellForTableView:tableView inMainTable:indexPath.row];
            
        } else {
            cell = [GJWMainCell cellForTableView:tableView];
            if ([self.dataSource respondsToSelector:@selector(dropdownView:titleForRowInMainTable:)]) {
                cell.textLabel.text = [self.dataSource dropdownView:self titleForRowInMainTable:indexPath.row];
            }
            
        }
        
    } else {
        
        if ([self.dataSource respondsToSelector:@selector(dropdownView:cellForTableView:inSubTable:inMainTable:)]) {
            cell = [self.dataSource dropdownView:self cellForTableView:tableView inSubTable:indexPath.row inMainTable:self.selectedMainRow];
        } else {
            cell = [GJWSubCell cellForTableView:tableView];
            if ([self.dataSource respondsToSelector:@selector(dropdownView:titleForRowInSubTable:inMainTable:)]) {
                cell.textLabel.text = [self.dataSource dropdownView:self titleForRowInSubTable:indexPath.row inMainTable:self.selectedMainRow];
            }
        }
    }
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.mainTableView) {
        return [self.dataSource numberOfRowsInDropdownView:self];
    } else if (tableView == self.subTableView) {
        return [self.dataSource dropdownView:self numberOfRowsInMainTable:self.selectedMainRow];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.mainTableView) {
        self.selectedMainRow = indexPath.row;
        [self.subTableView reloadData];
        if ([self.delegate respondsToSelector:@selector(dropdownView:didSelectRowInMainTable:)]) {
            [self.delegate dropdownView:self didSelectRowInMainTable:indexPath.row];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(dropdownView:didSelectRowInSubTable:inMainTable:)]) {
            [self.delegate dropdownView:self didSelectRowInSubTable:indexPath.row inMainTable:self.selectedMainRow];
        }
    }
}

#pragma mark - 点击空白区域
- (void)tapClick {
    
    [self hiddenDropdown];
    
    if ([self.delegate respondsToSelector:@selector(didClickCancel)]) {
        [self.delegate didClickCancel];
    }
}

- (void)showDropdown {
    [self showDropdownWithDuration:0.25];
}
- (void)showDropdownWithDuration:(NSTimeInterval)duration {
    [self setHideDropdown:NO duration:duration];
}
- (void)hiddenDropdown {
    [self hiddenDropdownWithDuration:0.25];
}
- (void)hiddenDropdownWithDuration:(NSTimeInterval)duration {
    [self setHideDropdown:YES duration:duration];
}
- (void)setHideDropdown:(BOOL)hideDropdown duration:(NSTimeInterval)duration {
    
    if (hideDropdown == NO) {
        self.hidden = hideDropdown;
    }
    float height = CGRectGetHeight(self.mainTableView.frame);
    
    CGAffineTransform transform = hideDropdown ? CGAffineTransformIdentity:CGAffineTransformMakeTranslation(0, height);
    UIColor *backColor = hideDropdown ? [UIColor clearColor]:[UIColor colorWithWhite:0 alpha:0.5];
    [UIView animateWithDuration:duration animations:^{
        self.mainTableView.transform = transform;
        self.subTableView.transform = transform;
        self.backView.backgroundColor = backColor;
    } completion:^(BOOL finished) {
        if (hideDropdown) {
            self.hidden = hideDropdown;
        }
    }];
    
}

@end
