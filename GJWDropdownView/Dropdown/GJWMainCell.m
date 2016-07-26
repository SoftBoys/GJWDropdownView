//
//  GJWMainCell.m
//  GJWDropdownView
//
//  Created by dfhb@rdd on 16/7/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "GJWMainCell.h"

@implementation GJWMainCell

+ (instancetype)cellForTableView:(UITableView *)tableView {
    static NSString *identifier = @"maincell";
    GJWMainCell *mainCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (mainCell == nil) {
        mainCell = [[GJWMainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return mainCell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *bg = [[UIImageView alloc] init];
        bg.image = [[UIImage imageNamed:@"bg_dropdown_leftpart"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
        self.backgroundView = bg;
        
        UIImageView *selectedBg = [[UIImageView alloc] init];
        selectedBg.image = [[UIImage imageNamed:@"bg_dropdown_left_selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
        self.selectedBackgroundView = selectedBg;
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
