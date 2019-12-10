//
//  NUTableViewModel.h
//  NUKit
//
//  Created by liu nian on 2019/12/9.
//

#import <Foundation/Foundation.h>
#import "NUTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NUTableViewModel : NSObject
@property (nonatomic, strong) NSMutableArray <NUTableViewCellModel *> *cellModelArray;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, copy) UIView * (^headerViewBlock)(NSInteger section, UITableView *tableView);
@property (nonatomic, copy) UIView * (^footerViewBlock)(NSInteger section, UITableView *tableView);

@end

NS_ASSUME_NONNULL_END
