//
//  iOSSessionManager.m
//  qtum wallet
//
//  Created by Sharaev Vladimir on 06.06.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import <WatchConnectivity/WatchConnectivity.h>
#import "QRCodeManager.h"

NSString *MainMessageKey = @"message_key";
NSString *GetQRCodeMessageKey = @"get_qr_code";
NSString *GetWalletInformation = @"get_wallet_information";
NSString *StatusKey = @"status";
NSString *kErrorKey = @"error";

@interface iOSSessionManager () <WCSessionDelegate>

@property (nonatomic) WCSessionActivationState currentState;

@end

@implementation iOSSessionManager

- (instancetype)init {

	self = [super init];

	if (self) {
		if ([WCSession isSupported]) {
			WCSession *session = [WCSession defaultSession];
			session.delegate = self;
			[session activateSession];
			DLog(@"WCSession is supported");
		} else {
			DLog(@"WCSession is NOT supported");
		}
	}

	return self;
}

- (void)sendMessage:(NSString *) message {

	if (self.currentState == WCSessionActivationStateActivated) {
		WCSession *session = [WCSession defaultSession];
		[session sendMessage:@{@"hello": message} replyHandler:^(NSDictionary<NSString *, id> *_Nonnull replyMessage) {
			DLog(@"WCSession activationDidCompleteWithState :  %@", replyMessage);
		}       errorHandler:^(NSError *_Nonnull error) {
			DLog(@"Error send message");
		}];
	}
}

#pragma mark - WCSessionDelegate

/** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
- (void)session:(WCSession *) session activationDidCompleteWithState:(WCSessionActivationState) activationState error:(nullable NSError *) error {
	self.currentState = activationState;
	DLog(@"WCSession activationDidCompleteWithState :  %ld", (long)activationState);
}

/** ------------------------- iOS App State For Watch ------------------------ */

/** Called when the session can no longer be used to modify or add any new transfers and, all interactive messages will be cancelled, but delegate callbacks for background transfers can still occur. This will happen when the selected watch is being changed. */
- (void)sessionDidBecomeInactive:(WCSession *) session {
	self.currentState = session.activationState;
	DLog(@"sessionDidBecomeInactive");
}

/** Called when all delegate callbacks for the previously selected watch has occurred. The session can be re-activated for the now selected watch using activateSession. */
- (void)sessionDidDeactivate:(WCSession *) session {
	self.currentState = session.activationState;
	DLog(@"sessionDidDeactivate");
}

/** Called when any of the Watch state properties change. */
- (void)sessionWatchStateDidChange:(WCSession *) session {
	self.currentState = session.activationState;
	DLog(@"sessionWatchStateDidChange : state = %ld", (long)session.activationState);
}

/** ------------------------- Interactive Messaging ------------------------- */

/** Called when the reachable state of the counterpart app changes. The receiver should check the reachable property on receiving this delegate callback. */
- (void)sessionReachabilityDidChange:(WCSession *) session {
	DLog(@"sessionReachabilityDidChange");
}

/** Called on the delegate of the receiver. Will be called on startup if the incoming message caused the receiver to launch. */
- (void)session:(WCSession *) session didReceiveMessage:(NSDictionary<NSString *, id> *) message {
	DLog(@"sessionReachabilityDidChange : message : %@", message);
}

/** Called on the delegate of the receiver when the sender sends a message that expects a reply. Will be called on startup if the incoming message caused the receiver to launch. */
- (void)session:(WCSession *) session didReceiveMessage:(NSDictionary<NSString *, id> *) message replyHandler:(void (^)(NSDictionary<NSString *, id> *replyMessage)) replyHandler {
	DLog(@"didReceiveMessage with reply : message : %@", message);

	NSString *key = message[MainMessageKey];
	if ([key isEqualToString:GetQRCodeMessageKey]) {
		CGFloat width = [message[@"width"] floatValue];
		NSString *address = SLocator.walletManager.wallet.mainAddress;

		[QRCodeManager createQRCodeFromString:address forSize:CGSizeMake (width, width) withCompletionBlock:^(UIImage *image) {
			NSDictionary *dictionary = @{@"data": UIImagePNGRepresentation (image),
					@"key": address};

			replyHandler (dictionary);
		}];
	} else if ([key isEqualToString:GetWalletInformation]) {
		CGFloat width = [message[@"width"] floatValue];

		if (!SLocator.walletManager.wallet) {
			NSDictionary *dictionary = @{kErrorKey: @"No wallet"};
			replyHandler (dictionary);
			return;
		}

		[SLocator.walletManager.wallet updateBalanceWithHandler:^(BOOL success) {
			if (success) {
				[SLocator.walletManager.wallet updateHistoryWithHandler:^(BOOL success) {
					if (success) {

						Wallet *wallet = SLocator.walletManager.wallet;
						NSString *address = [wallet getStoredLastAddressKey];

						if (!address) {
							NSDictionary *dictionary = @{kErrorKey: @"No wallet"};
							replyHandler (dictionary);
							return;
						}

                        NSString *availableBalance = wallet.balance.stringValue;
                        NSString *unconfirmedBalance = wallet.unconfirmedBalance.stringValue;
						NSArray *history = wallet.historyStorage.historyPrivate;
						NSMutableArray *historyDictionary = [NSMutableArray new];
						for (HistoryElement *element in history) {
							[historyDictionary addObject:[element dictionaryFromElementForWatch]];
						}

						[QRCodeManager createQRCodeFromPublicAddress:address tokenAddress:nil andAmount:nil forSize:CGSizeMake (width, width) withCompletionBlock:^(UIImage *image) {
							NSDictionary *dictionary = @{@"address": address,
                                    @"availableBalance": availableBalance,
                                    @"unconfirmedBalance": unconfirmedBalance,
                                    @"history": historyDictionary,
									@"image": UIImagePNGRepresentation (image)};

							replyHandler (dictionary);
						}];
					} else {
						NSDictionary *dictionary = @{StatusKey: @(NO)};
						replyHandler (dictionary);
					}
				}                                               andPage:0];
			} else {
				NSDictionary *dictionary = @{StatusKey: @(NO)};
				replyHandler (dictionary);
			}
		}];
	}
}

- (void)updateWatch {

	NSDictionary *info = [self createInfoForWatch];
	if (info) {
		[self transferDataToWatch:info];
	}
}

- (NSDictionary *)createInfoForWatch {

	Wallet *wallet = SLocator.walletManager.wallet;
	NSString *address = [wallet getStoredLastAddressKey];
	if (!address) {
		NSDictionary *dictionary = @{kErrorKey: @"No wallet"};
		return dictionary;
	}

	NSString *availableBalance = wallet.balance.stringValue;
	NSString *unconfirmedBalance = wallet.unconfirmedBalance.stringValue;
	NSArray *history = wallet.historyStorage.historyPrivate;
	NSMutableArray *historyDictionary = [NSMutableArray new];

	for (HistoryElement *element in history) {
		[historyDictionary addObject:[element dictionaryFromElementForWatch]];
	}

	NSDictionary *dictionary = @{@"address": address,
			@"availableBalance": availableBalance,
			@"unconfirmedBalance": unconfirmedBalance,
			@"history": historyDictionary,
			@"image": [UIImage new]};

	return dictionary;
}

- (void)transferDataToWatch:(nonnull NSDictionary<NSString *, id> *) info {

	WCSession *session = [WCSession defaultSession];
	[session transferUserInfo:info];
}

@end
