//
//  NLViewController.m
//  NUKit
//
//  Created by i19850511@gmail.com on 12/05/2019.
//  Copyright (c) 2019 i19850511@gmail.com. All rights reserved.
//

#import "NLViewController.h"
#import "NUTableViewModel.h"
#import "NLTitleTableViewCell.h"

@interface NLViewControllerDataSource ()
@property (nonatomic, strong) NSMutableArray <NUTableViewModel *> *sectionModelArray;
@property (nonatomic, weak) id delegate;

@end
@implementation NLViewControllerDataSource

+ (NSArray <NUTableViewModel *> *)reformDataWithDelegate:(id)delegate {
	NLViewControllerDataSource *dataSource = [NLViewControllerDataSource new];
	dataSource.delegate = delegate;
	[dataSource.sectionModelArray removeAllObjects];

	[dataSource configTableViewCellModel];
	return dataSource.sectionModelArray;
}

- (void)configTableViewCellModel {

	NSMutableArray *sections = @[].mutableCopy;
	for (NSInteger i = 0; i< 5; i++) {
		NSMutableArray *rows = @[].mutableCopy;
		for (NSInteger j = 0; j< 10; j++) {
			[rows addObject:@(j)];
		}
		
		[sections addObject:rows];
	}
	__weak typeof(self) ws = self;
	NUTableViewModel *sectionModel = [[NUTableViewModel alloc] init];
	[sectionModel setHeaderViewBlock:^UIView *(NSInteger section, UITableView *tableView) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.text = [NSString stringWithFormat:@"section - %d",section];
		return label;
	}];
	sectionModel.headerHeight = 20.0;

	[sections enumerateObjectsUsingBlock:^(NSArray * _Nonnull rows, NSUInteger idx, BOOL * _Nonnull stop) {
		// rows
		[rows enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL * _Nonnull stop) {
			NUTableViewCellModel *cellModel = [[NUTableViewCellModel alloc] init];
			cellModel.cellHeight = 54;
			[cellModel setConfigCellBlock:^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
			
					
				NLTitleTableViewCell *cell = [NLTitleTableViewCell cellWIthTableView:tableView];
				cell.textLabel.text = [number stringValue];
				return cell;
			}];
			[cellModel setSelectCellBlock:^(NSIndexPath *indexPath, UITableView *tableView) {
				
			}];
			
			[sectionModel.cellModelArray addObject:cellModel];
		}];
		
		[ws.sectionModelArray addObject:sectionModel];
	}];
	
	
}

#pragma mark - getter
- (NSMutableArray<NUTableViewModel *> *)sectionModelArray {
	if (!_sectionModelArray) {
		_sectionModelArray = [NSMutableArray array];
	}
	return _sectionModelArray;
}
@end
@interface NLViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sectionModelArray;
@end

@implementation NLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.sectionModelArray = [NLViewControllerDataSource reformDataWithDelegate:self];
	self.tableView.backgroundColor = self.view.backgroundColor;
	[self.tableView reloadData];
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (void)viewDidLayoutSubviews {
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.sectionModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NUTableViewModel *model = self.sectionModelArray[section];
	return model.cellModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NUTableViewModel *model = self.sectionModelArray[indexPath.section];
	NUTableViewCellModel *cellModel = model.cellModelArray[indexPath.row];
	return cellModel.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NUTableViewModel *model = self.sectionModelArray[indexPath.section];
	NUTableViewCellModel *cellModel = model.cellModelArray[indexPath.row];
	return cellModel.configCellBlock(indexPath, tableView);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NUTableViewModel *model = self.sectionModelArray[indexPath.section];
	NUTableViewCellModel *cellModel = model.cellModelArray[indexPath.row];
	cellModel.selectCellBlock(indexPath, tableView);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NUTableViewModel *model = self.sectionModelArray[section];
	return model.headerTitle;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	NUTableViewModel *model = self.sectionModelArray[section];
	return model.headerViewBlock(section, tableView);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	NUTableViewModel *model = self.sectionModelArray[section];
	return model.headerHeight;
}

#pragma mark - getter
- (UITableView *)tableView {
	if (_tableView == nil) {
		_tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds
												  style:UITableViewStylePlain];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.tableFooterView = [[UIView alloc] init];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
		_tableView.separatorColor = [UIColor whiteColor];
		_tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 0);
		[self.view addSubview:_tableView];
	}
	return _tableView;
}

@end
