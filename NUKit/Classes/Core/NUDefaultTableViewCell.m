//
//  NUDefaultTableViewCell.m
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import "NUDefaultTableViewCell.h"

@implementation NUDefaultCellData

@end

@interface NUDefaultTableViewCell ()
@property (nonatomic, readwrite, strong, nullable) UIImageView *nImageView;
@property (nonatomic, readwrite, strong, nullable) UILabel *nTextLabel;
@property (nonatomic, readwrite, strong, nullable) UILabel *nDetailTextLabel;
@end
@implementation NUDefaultTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		[self setupViews];
    }
    return self;
}

- (void)setupViews {
	/// 子类继承
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)updateConstraints {
	[super updateConstraints];
}

#pragma mark - getter
- (UILabel *)nTextLabel {
	if (!_nTextLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.backgroundColor = [UIColor clearColor];
		label.textColor = [UIColor darkTextColor];
		label.font = [UIFont systemFontOfSize:14];
		label.textAlignment = NSTextAlignmentLeft;
		label.text = @"";
		[self.contentView addSubview:label];
		_nTextLabel = label;
	}
	return _nTextLabel;
}

- (UILabel *)nDetailTextLabel {
	if (!_nDetailTextLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.backgroundColor = [UIColor clearColor];
		label.textColor = [UIColor darkGrayColor];
		label.font = [UIFont systemFontOfSize:12];
		label.textAlignment = NSTextAlignmentLeft;
		label.text = @"";
		[self.contentView addSubview:label];
		_nDetailTextLabel = label;
	}
	return _nDetailTextLabel;
}
@end
