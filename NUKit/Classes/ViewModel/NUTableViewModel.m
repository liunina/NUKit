//
//  NUTableViewModel.m
//  NUKit
//
//  Created by liu nian on 2019/12/9.
//

#import "NUTableViewModel.h"

@implementation NUTableViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.cellModelArray = [NSMutableArray array];
        self.headerHeight = UITableViewAutomaticDimension;
        self.footerHeight = UITableViewAutomaticDimension;
        [self setHeaderViewBlock:^UITableViewHeaderFooterView *(NSInteger section, UITableView *tableView) {
            return nil;
        }];
        [self setFooterViewBlock:^UITableViewHeaderFooterView *(NSInteger section, UITableView *tableView) {
            return nil;
        }];
    }
    return self;
}

@end
