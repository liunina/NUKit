//
//  NLTitleTableViewCell.m
//  NUKit_Example
//
//  Created by liu nian on 2020/3/2.
//  Copyright © 2020 i19850511@gmail.com. All rights reserved.
//

#import "NLTitleTableViewCell.h"

@implementation NLTitleTableViewCell

+ (instancetype)cellWIthTableView:(UITableView *)tableView {
    static NSString *identifier = @"NLTitleTableViewCell";
    NLTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NLTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
