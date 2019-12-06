//
//  NUTableViewCell.h
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface NUCellData : NSObject
@property (strong) NSString *reuseId;
@property (nonatomic, strong) NSObject *ctarget;
@property (nonatomic, assign) SEL cselector;
- (CGFloat)heightOfWidth:(CGFloat)width;
@end

@interface NUTableViewCell : UITableViewCell
/// 数据模型
@property (nonatomic, strong, readonly) NUCellData *data;
@property (nonatomic, strong) UIColor *colorWhenTouched;
@property (nonatomic, assign) BOOL changeColorWhenTouched;

/// 设置数据模型
/// @param data 数据模型
- (void)fillWithData:(NUCellData *)data;
@end

NS_ASSUME_NONNULL_END
