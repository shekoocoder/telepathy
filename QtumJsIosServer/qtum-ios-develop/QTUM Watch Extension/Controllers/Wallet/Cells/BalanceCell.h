//
//  BalanceCell.h
//  qtum wallet
//
//  Created by Sharaev Vladimir on 13.06.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@protocol BalanceCellDelegaete <NSObject>

- (void)showQRCode;

@end

@interface BalanceCell : NSObject

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *availableBalance;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *notConfirmedBalance;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *address;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceGroup *balanceGroup;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceGroup *uncBalanceGroup;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *unconfirmedSymbol;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *confirmedSymbol;

@property (nonatomic, weak) id <BalanceCellDelegaete> delegate;

@end
