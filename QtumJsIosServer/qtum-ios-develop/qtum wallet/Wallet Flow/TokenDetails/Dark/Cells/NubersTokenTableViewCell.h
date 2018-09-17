//
//  NubersTokenTableViewCell.h
//  qtum wallet
//
//  Created by Sharaev Vladimir on 19.05.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NubersTokenTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *initialSupplyLabel;
@property (weak, nonatomic) IBOutlet UILabel *decimalUnitsLabel;

@end
