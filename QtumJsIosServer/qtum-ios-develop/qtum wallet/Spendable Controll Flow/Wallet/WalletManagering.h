//
//  WalletManagering.h
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 18.07.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Managerable.h"
#import "Clearable.h"

@class Wallet;
@class WalletManagerRequestAdapter;
@class BTCKey;

@protocol WalletManagering <Clearable, Managerable>

@property (strong, nonatomic, readonly) WalletManagerRequestAdapter *requestAdapter;
@property (strong, nonatomic) Wallet *wallet;

- (void)createNewWalletWithName:(NSString *) name
							pin:(NSString *) pin
			 withSuccessHandler:(void (^)(Wallet *newWallet)) success
			  andFailureHandler:(void (^)(void)) failure;

- (void)createNewWalletWithName:(NSString *) name
							pin:(NSString *) pin seedWords:(NSArray *) seedWords
			 withSuccessHandler:(void (^)(Wallet *newWallet)) success
			  andFailureHandler:(void (^)(void)) failure;

- (void)storePin:(NSString *) pin;

- (BOOL)changePinFrom:(NSString *) pin toPin:(NSString *) newPin;

- (BOOL)verifyPin:(NSString *) pin;

- (BOOL)isSignedIn;

- (BOOL)isLongPin;

- (NSDictionary *)hashTableOfKeys;

- (NSDictionary *)hashTableOfKeysForHistoryElement;

- (NSString*)stringAddressFromBTCKey:(BTCKey*) key;

- (BOOL)startWithPin:(NSString *) pin;

- (NSString *)brandKeyWithPin:(NSString *) pin;

@end
