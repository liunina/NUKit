//
//  NUTableViewCellModel.h
//  NUKit
//
//  Created by liu nian on 2019/12/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NUTableViewCellModel : NSObject
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, copy) UITableViewCell *(^configCellBlock)(NSIndexPath *indexPath, UITableView *tableView);
@property (nonatomic, copy) void (^selectCellBlock)(NSIndexPath *indexPath, UITableView *tableView);
/*
 其他属性按需求添加
 */
@end

NS_ASSUME_NONNULL_END
