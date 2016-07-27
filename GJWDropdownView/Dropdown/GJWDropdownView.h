//
//  GJWDropdownView.h
//  GJWDropdownView
//
//  Created by dfhb@rdd on 16/7/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJWMainCell.h"
#import "GJWSubCell.h"

@class GJWDropdownView;

@protocol GJWDropdownViewDelegate <NSObject>
@optional
- (void)didClickCancel;
- (void)dropdownView:(GJWDropdownView *)dropdownView didSelectRowInMainTable:(NSInteger)row;
- (void)dropdownView:(GJWDropdownView *)dropdownView didSelectRowInSubTable:(NSInteger)subRow inMainTable:(NSInteger)mainRow;
@end

@protocol GJWDropdownViewDataSource <NSObject>

- (NSInteger)numberOfRowsInDropdownView:(GJWDropdownView *)dropdownView;
- (NSInteger)dropdownView:(GJWDropdownView *)dropdownView numberOfRowsInMainTable:(NSInteger)mainRow;

@optional
- (GJWMainCell *)dropdownView:(GJWDropdownView *)dropdownView cellForTableView:(UITableView *)tableView inMainTable:(NSInteger)row;
- (GJWSubCell *)dropdownView:(GJWDropdownView *)dropdownView cellForTableView:(UITableView *)tableView inSubTable:(NSInteger)subRow inMainTable:(NSInteger)mainRow;
/**
 *  返回mainCell标题 （注：实现dropdownView: cellForTableView: inMainTable: 方法后此方法无效）
 *
 *  @param dropdownView <#dropdownView description#>
 *  @param row          行
 */
- (NSString *)dropdownView:(GJWDropdownView *)dropdownView titleForRowInMainTable:(NSInteger)row;
/**
 *  返回subCell标题 （注：实现dropdownView: cellForTableView: inSubTable: inMainTable: 方法后此方法无效）
 *
 *  @param dropdownView <#dropdownView description#>
 *  @param row          行
 */
- (NSString *)dropdownView:(GJWDropdownView *)dropdownView titleForRowInSubTable:(NSInteger)subRow inMainTable:(NSInteger)mainRow;
@end
@interface GJWDropdownView :UIView
/**
 *  设置下拉的高度，默认300
 */
@property (nonatomic, assign) CGFloat dropdownHeight;

@property (nonatomic, weak) id<GJWDropdownViewDelegate> delegate;
@property (nonatomic, weak) id<GJWDropdownViewDataSource> dataSource;
/**
 *  显示视图
 */
- (void)showDropdown;
/**
 *  显示视图
 *
 *  @param duration 动画时间（默认0.25s）
 */
- (void)showDropdownWithDuration:(NSTimeInterval)duration;
/**
 *  隐藏视图
 */
- (void)hiddenDropdown;
/**
 *  隐藏视图
 *
 *  @param duration 动画时间（默认0.25s）
 */
- (void)hiddenDropdownWithDuration:(NSTimeInterval)duration;

@end
