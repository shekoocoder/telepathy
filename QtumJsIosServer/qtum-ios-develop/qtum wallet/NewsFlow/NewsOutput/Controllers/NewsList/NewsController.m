//
//  NewsController.m
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 07.02.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import "NewsController.h"
#import "NewsCellModel.h"

@interface NewsController ()

@property (strong, nonatomic) UIRefreshControl *refresh;
@property (strong, nonatomic) NSMutableArray <NewsCellModel *> *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;

@end

@implementation NewsController

@synthesize news;

#pragma mark - Lifecycle

- (void)viewDidLoad {

	[super viewDidLoad];

	[self configTableView];
	[self configPullRefresh];
    [self configLocalization];

	if (!self.news) {
		[self getData];
	}
}

- (void)viewWillDisappear:(BOOL) animated {
    
    [super viewWillDisappear:animated];
    [self endEditing:nil];
}

- (UIColor *)logoColor {
	return lightDarkGrayColor ();
}

#pragma mark - Getters


#pragma mark - Configuration

-(void)configLocalization {
    
    self.titleTextLabel.text = NSLocalizedString(@"News", @"News Controllers Title");
}

- (void)configPullRefresh {

	self.refresh = [[UIRefreshControl alloc] init];
	[self.refresh setTintColor:customBlueColor ()];
	[self.refresh addTarget:self action:@selector (actionRefresh) forControlEvents:UIControlEventValueChanged];
	[self.tableView addSubview:self.refresh];
}

- (void)configTableView {

	self.tableView.rowHeight = UITableViewAutomaticDimension;
	self.tableView.estimatedRowHeight = 120.0f;
}

#pragma mark - Private Methods

- (IBAction)endEditing:(id) sender {

	[self.view endEditing:YES];
}

- (void)getData {

	[self.delegate refreshTableViewData];
}

- (void)reloadTable {

	__weak typeof (self) weakSelf = self;
	dispatch_async (dispatch_get_main_queue (), ^{
		[weakSelf.tableView reloadData];
	});
}

#pragma mark - NewsOutput

- (void)reloadTableView {
	[self reloadTable];
}

- (void)startLoading {
	[SLocator.popupService showLoaderPopUp];
}

- (void)stopLoadingIfNeeded {
	[SLocator.popupService dismissLoader];
}

#pragma mark - Actions

- (void)actionRefresh {

	[self.refresh endRefreshing];
	[self getData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath {

	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	if ([self.delegate respondsToSelector:@selector (didSelectCellWithNews:)]) {
		[self.delegate didSelectCellWithNews:self.news[indexPath.row]];
	}
}

@end
