//
//  GJWSubCell.m
//  GJWDropdownView
//
//  Created by dfhb@rdd on 16/7/25.
//  Copyright © 2016年 guojunwei. All rights reserved.
//

#import "GJWSubCell.h"

@implementation GJWSubCell

+ (instancetype)cellForTableView:(UITableView *)tableView {
    NSString *identifier = NSStringFromClass([self class]);
    GJWSubCell *subCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (subCell == nil) {
        subCell = [[GJWSubCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return subCell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *bg = [[UIImageView alloc] init];
        bg.image = [[UIImage imageNamed:@"bg_dropdown_rightpart"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
        self.backgroundView = bg;

//        UIImageView *selectedBg = [[UIImageView alloc] init];
//        selectedBg.image = [[UIImage imageNamed:@"bg_dropdown_rightpart"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
//        self.selectedBackgroundView = selectedBg;
    }
    return self;
}

@end
