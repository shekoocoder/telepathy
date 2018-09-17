//
//  NubersTokenView.h
//  qtum wallet
//
//  Created by Sharaev Vladimir on 29.05.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NubersTokenView : UIView

@property (weak, nonatomic) IBOutlet UILabel *initialSupplyLabel;
@property (weak, nonatomic) IBOutlet UILabel *decimalUnitsLabel;
@property (copy, nonatomic) NSString *shortTotalSupply;
@property (weak, nonatomic) IBOutlet UILabel *initialSupTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *decimalUnitsTextLabel;


@end
