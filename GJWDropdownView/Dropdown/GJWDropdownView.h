//
//  GJWDropdownView.h
//  GJWDropdownView
//
//  Created by dfhb@rdd on 16/7/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>
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

- (NSString *)dropdownView:(GJWDropdownView *)dropdownView titleForRowInMainTable:(NSInteger)row;
- (NSString *)dropdownView:(GJWDropdownView *)dropdownView titleForRowInSubTable:(NSInteger)subRow inMainTable:(NSInteger)mainRow;
@end
@interface GJWDropdownView :UIView
/**
 *  设置下拉的高度，默认300
 */
@property (nonatomic, assign) CGFloat dropdownHeight;

@property (nonatomic, weak) id<GJWDropdownViewDelegate> delegate;
@property (nonatomic, weak) id<GJWDropdownViewDataSource> dataSource;


@property (nonatomic, assign, getter=isHideDropdown) BOOL hideDropdown;

@end
