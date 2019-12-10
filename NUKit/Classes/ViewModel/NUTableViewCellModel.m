//
//  NUTableViewCellModel.m
//  NUKit
//
//  Created by liu nian on 2019/12/9.
//

#import "NUTableViewCellModel.h"

@implementation NUTableViewCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.cellHeight = UITableViewAutomaticDimension;
        [self setSelectCellBlock:^(NSIndexPath *indexPath, UITableView *tableView) {
        }];
    }
    return self;
}

@end
