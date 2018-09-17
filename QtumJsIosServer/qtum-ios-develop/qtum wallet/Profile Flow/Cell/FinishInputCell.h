//
//  FinishInputCell.h
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 17.05.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *FinishInputCellIdentifire = @"FinishInputCellIdentifire";

@interface FinishInputCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *value;

@property (copy, nonatomic) NSString *shortValueString;

@end
