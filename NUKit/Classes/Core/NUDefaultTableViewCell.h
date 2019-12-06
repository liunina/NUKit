//
//  NUDefaultTableViewCell.h
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//
//	该类是逻辑类,不可直接使用

#import "NUTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface NUDefaultCellData : NUCellData
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *detailText;
@end

@interface NUDefaultTableViewCell : NUTableViewCell
@property (nonatomic, readonly, strong, nullable) UILabel *nTextLabel;
@property (nonatomic, readonly, strong, nullable) UILabel *nDetailTextLabel;
/// 初始化调用,子类需继承
- (void)setupViews;
@end

NS_ASSUME_NONNULL_END
