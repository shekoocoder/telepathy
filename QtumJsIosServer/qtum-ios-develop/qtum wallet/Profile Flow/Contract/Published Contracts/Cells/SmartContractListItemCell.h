//
//  SmartContractListItemCell.h
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 30.05.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTUMSwipableCellWithButtons.h"

static NSString *smartContractListItemCellIdentifire = @"SmartContractListItemCellIdentifire";

@interface SmartContractListItemCell : QTUMSwipableCellWithButtons

@property (weak, nonatomic) IBOutlet UILabel *contractName;
@property (weak, nonatomic) IBOutlet UILabel *typeIdentifire;
@property (weak, nonatomic) IBOutlet UILabel *creationDate;

@end
