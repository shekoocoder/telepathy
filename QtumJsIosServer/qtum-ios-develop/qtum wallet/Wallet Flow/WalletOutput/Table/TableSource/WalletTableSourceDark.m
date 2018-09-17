//
//  WalletTableSourceDark.m
//  qtum wallet
//
//  Created by Sharaev Vladimir on 05.07.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import "WalletTableSourceDark.h"
#import "HistoryTableViewCellDark.h"
#import "WalletHeaderCellDark.h"

@implementation WalletTableSourceDark

- (CGFloat)tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath {

	if (indexPath.section == 0) {
		switch ([self headerCellType]) {
			case HeaderCellTypeWithoutPageControl:
				return 192;
			case HeaderCellTypeWithoutNotCorfirmedBalance:
				return 161;
			case HeaderCellTypeWithoutAll:
				return 152;
			case HeaderCellTypeAllVisible:
			default:
				return 212;
		}
	} else {
		return 75;
	}
}

- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {

	[self updateEmptyPlaceholderView];

	if (indexPath.section == 0) {
		WalletHeaderCellDark *cell = [tableView dequeueReusableCellWithIdentifier:@"WalletHeaderCellDark"];

		cell.delegate = self.delegate;
		[cell setCellType:[self headerCellType]];
		[cell setData:self.wallet];
		[self didScrollForheaderCell:tableView];

		self.mainCell = cell;

		return cell;
	} else {
		HistoryTableViewCellDark *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryTableViewCellDark"];

		HistoryElement *element = self.wallet.historyStorage.historyPrivate[indexPath.row];
		cell.historyElement = element;
		[cell changeHighlight:NO];

		return cell;
	}
}

@end
