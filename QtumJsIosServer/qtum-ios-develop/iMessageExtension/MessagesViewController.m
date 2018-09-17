//
//  MessagesViewController.m
//  iMessageExtension
//
//  Created by Vladimir Lebedevich on 23.02.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import "MessagesViewController.h"
#import "iMessageGradientView.h"
#import "iMessageDataOperation.h"

@interface MessagesViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *goToHostButton;
@property (weak, nonatomic) IBOutlet UIButton *sendMessageWithaddress;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *amount;
@property (strong, nonatomic) MSMessage *storedPaymendMessage;
@property (assign, nonatomic) BOOL isHasWallet;

@property (weak, nonatomic) IBOutlet UIButton *requestExpandButton;

@property (weak, nonatomic) IBOutlet UIButton *mainActionButton;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIView *textFieldUnderline;
@property (weak, nonatomic) IBOutlet UILabel *amountValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIView *compactPresentationView;
@property (weak, nonatomic) IBOutlet UIView *expandedPresentationView;
@property (weak, nonatomic) IBOutlet UIView *sendMessageExpandView;
@property (weak, nonatomic) IBOutlet UIView *createWalletExpandView;
@property (weak, nonatomic) IBOutlet UIView *paymentArimentExpandView;
@property (weak, nonatomic) IBOutlet UIView *finalizedExpandView;
@property (weak, nonatomic) IBOutlet UILabel *finalizedTextLabel;

@property (assign, nonatomic) BOOL isPaymentInProcess;
@property (assign, nonatomic) BOOL isCreatinNewInProcces;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendScreenTitleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendScreenCenterViewYConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendScreenTitleTopLandscapeConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendScreenCenterViewYLandscapeConstraint;
@property (weak, nonatomic) IBOutlet UILabel *sendAddressLabel;

@end

static NSString *isHasWalletKey = @"isHaveWallet";
static NSString *WalletAddressKey = @"walletAddress";
static NSString *addressKey = @"address";
static NSString *registerText = @"You have no wallets yet. Tap to create one.";
static NSString *sendaddressText = @"Send your address";
static NSString *createWalletButtonText = @"Create wallet";
static NSString *sendaddressButtonText = @"Send address";
static NSString *finalizedAgreeText = @"Yes, i will see what i can do";
static NSString *finalizedDisagreeText = @"Sorry, but not now";

@implementation MessagesViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	NSDictionary *groupInfo = [iMessageDataOperation getDictFormGroupFileWithName:@"group"];

	[self.sendAddressLabel setText:groupInfo[WalletAddressKey]];
	self.isHasWallet = [groupInfo[isHasWalletKey] isEqualToString:@"YES"] ? YES : NO;
	self.address = groupInfo[addressKey];
	self.sendMessageWithaddress.hidden = !self.isHasWallet;
	self.goToHostButton.hidden = self.isHasWallet;
	self.textLabel.text = self.isHasWallet ? sendaddressText : registerText;

	self.amountTextField.delegate = self;
}

- (IBAction)GoToHost:(id) sender {
	[self.extensionContext openURL:[NSURL URLWithString:@"host://"] completionHandler:^(BOOL success) {
		NSLog (@"Opened HostApp - %@", success ? @"Yes" : @"NO");
	}];
}

- (IBAction)actionSendMessage:(id) sender {

	MSConversation *conversation = self.activeConversation;
	MSSession *session;
	MSMessage *message;

	if ([self.activeConversation.localParticipantIdentifier isEqual:self.activeConversation.selectedMessage.senderParticipantIdentifier]) {
		session = self.activeConversation.selectedMessage.session;
		message = self.activeConversation.selectedMessage;
	} else {
		session = [[MSSession alloc] init];
		message = [[MSMessage alloc] initWithSession:session];
	}
	MSMessageTemplateLayout *layout = [MSMessageTemplateLayout new];
	layout.image = [self imageForMessageWithText:[NSString stringWithFormat:@"transfer me %@ QTUM", self.amountTextField.text.length > 0 ? self.amountTextField.text : @"some"] finalized:NO isResultSuccess:NO];
	message.layout = layout;
	message.shouldExpire = YES;
	message.URL = [self createUrlForMessageWithFinalized:NO andSucces:NO];
	[conversation insertMessage:message completionHandler:nil];
	[self.view endEditing:YES];
	[self dismiss];
}

- (IBAction)actionSendFinalizedMessage:(id) sender withText:(NSString *) text isAgree:(BOOL) flag {

	MSConversation *conversation = self.activeConversation;
	MSSession *session;
	MSMessage *message;

	if (self.activeConversation.selectedMessage) {
		session = self.activeConversation.selectedMessage.session;
		message = self.activeConversation.selectedMessage;
	} else {
		session = [[MSSession alloc] init];
		message = [[MSMessage alloc] initWithSession:session];
	}
	MSMessageTemplateLayout *layout = [MSMessageTemplateLayout new];
	layout.image = [self imageForMessageWithText:text finalized:YES isResultSuccess:flag];
	message.layout = layout;
	message.shouldExpire = YES;
	message.URL = [self createUrlForMessageWithFinalized:YES andSucces:flag];
	[conversation insertMessage:message completionHandler:nil];
	[self requestPresentationStyle:MSMessagesAppPresentationStyleCompact];
}

- (void)gotoHostFromMessage:(MSMessage *) message {
	NSString *address = [self getaddressFromMessage:message];
	NSString *amount = [self getAmountFromMessage:message];
	[self openHostWithaddress:address andAmount:amount];
}

- (NSURL *)createUrlForMessageWithFinalized:(BOOL) finalized andSucces:(BOOL) success {
	NSURLComponents *components = [NSURLComponents new];
	NSURLQueryItem *address = [[NSURLQueryItem alloc] initWithName:@"address" value:finalized ? [self getaddressFromMessage:self.storedPaymendMessage] : self.address];
	NSURLQueryItem *amount = [[NSURLQueryItem alloc] initWithName:@"amount" value:finalized ? [self getAmountFromMessage:self.storedPaymendMessage] : self.amountTextField.text];
	if (finalized) {
		NSURLQueryItem *final = [[NSURLQueryItem alloc] initWithName:@"finalized" value:success ? @"YES" : @"NO"];
		components.queryItems = @[address, amount, final];
	} else {
		components.queryItems = @[address, amount];
	}
	return components.URL;
}

- (IBAction)actionCreateWallet:(id) sender {
	[self.extensionContext openURL:[NSURL URLWithString:@"host://"] completionHandler:^(BOOL success) {
		NSLog (@"Opened HostApp - %@", success ? @"Yes" : @"NO");
	}];
}

- (IBAction)actionVoidTap:(id) sender {
	[self.view endEditing:YES];
}

- (IBAction)actiomSendMoney:(id) sender {
	self.isPaymentInProcess = YES;
	self.storedPaymendMessage = self.activeConversation.selectedMessage;
	[self actionSendFinalizedMessage:nil withText:[NSString stringWithFormat:@"transfer me %@ QTUM", [self getAmountFromMessage:self.storedPaymendMessage].length > 0 ? [self getAmountFromMessage:self.storedPaymendMessage] : @"some"] isAgree:YES];
}

- (IBAction)actionCancelSendMoney:(id) sender {
	[self actionSendFinalizedMessage:nil withText:[NSString stringWithFormat:@"transfer me %@ QTUM", [self getAmountFromMessage:self.activeConversation.selectedMessage].length > 0 ? [self getAmountFromMessage:self.activeConversation.selectedMessage] : @"some"] isAgree:NO];
}

- (void)handleSendinMessage:(MSMessage *) message {
	if (self.isPaymentInProcess) {
		self.isPaymentInProcess = NO;
		[self gotoHostFromMessage:_storedPaymendMessage ? _storedPaymendMessage : message];
	}
}

- (void)openHostWithaddress:(NSString *) address andAmount:(NSString *) amount {
	NSString *stringUrl = [NSString stringWithFormat:@"%@addressAndAmount/?address=%@&amount=%@", @"host://", address, amount];
	[self.extensionContext openURL:[NSURL URLWithString:stringUrl] completionHandler:^(BOOL success) {
		NSLog (@"Opened HostApp - %@", success ? @"Yes" : @"NO");
	}];
}

- (UIImage *)imageForMessageWithText:(NSString *) text finalized:(BOOL) final isResultSuccess:(BOOL) succes {
	UIView *backView = [[UIView alloc] initWithFrame:CGRectMake (self.view.frame.size.width, self.view.frame.size.height, 300, 100)];
	NSString *statusString;
	if (final && succes) {
		statusString = @"Wait...";
	} else if (final) {
		statusString = @"Canceled";
	}
	backView.backgroundColor = customBlueColor ();

	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake (20, 58, backView.bounds.size.width, 50)];
	label.font = [UIFont fontWithName:label.font.fontName size:18];
	label.text = text;
	[label sizeToFit];
	label.textColor = [UIColor whiteColor];
	label.textAlignment = NSTextAlignmentLeft;

	UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake (0, 10, backView.frame.size.width - 20, 20)];
	statusLabel.font = [UIFont fontWithName:label.font.fontName size:15];
	statusLabel.text = statusString;
	statusLabel.textColor = [UIColor whiteColor];
	statusLabel.textAlignment = NSTextAlignmentRight;

	UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake (0, 0, backView.frame.size.width, 40)];
	blackView.backgroundColor = customBlackColor ();

	[backView addSubview:blackView];
	[backView addSubview:statusLabel];
	[backView addSubview:label];
	[self.view addSubview:backView];
	UIGraphicsBeginImageContextWithOptions (backView.frame.size, NO, [UIScreen mainScreen].scale);
	[backView drawViewHierarchyInRect:backView.bounds afterScreenUpdates:YES];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext ();
	UIGraphicsEndImageContext ();
	[backView removeFromSuperview];
	return image;
}

- (void)updateControlsWithSyle:(MSMessagesAppPresentationStyle) style {

	BOOL isExpand = (self.presentationStyle == MSMessagesAppPresentationStyleExpanded);
	BOOL isMineMessage = ([self.activeConversation.localParticipantIdentifier isEqual:self.activeConversation.selectedMessage.senderParticipantIdentifier] || !self.activeConversation.selectedMessage);
    BOOL isFinalized = [self getFinalizedFromMessage:self.activeConversation.selectedMessage] ? YES : NO;
	if (isExpand) {
		if (self.isCreatinNewInProcces) {
			if (self.isHasWallet) {
				[self prepareSendingaddressWithControll];
			} else {
				[self prepareCreateWallet];
			}
		} else if (isFinalized) {
			[self prepareFinalized];
		} else if (isMineMessage) {
			if (self.isHasWallet) {
				[self prepareSendingaddressWithControll];
			} else {
				[self prepareCreateWallet];
			}
		} else {
			if (self.isHasWallet) {
				[self preparePaymentAgriment];
			} else {
				[self prepareCreateWallet];
			}
		}
	} else {
		self.isCreatinNewInProcces = NO;
		self.compactPresentationView.hidden = NO;
		self.expandedPresentationView.hidden = YES;
	}
}

- (void)prepareSendingaddressWithControll {
	self.sendMessageExpandView.hidden = NO;
	self.createWalletExpandView.hidden = YES;
	self.compactPresentationView.hidden = YES;
	self.expandedPresentationView.hidden = NO;
	self.addressLabel.text = [self getaddressFromMessage:self.activeConversation.selectedMessage];
	self.amountValueLabel.text = [self getAmountFromMessage:self.activeConversation.selectedMessage];
	self.paymentArimentExpandView.hidden = YES;
	self.finalizedExpandView.hidden = YES;
}

- (void)prepareCreateWallet {
	self.sendMessageExpandView.hidden = YES;
	self.createWalletExpandView.hidden = NO;
	self.expandedPresentationView.hidden = NO;
	self.compactPresentationView.hidden = YES;
	self.paymentArimentExpandView.hidden = YES;
	self.finalizedExpandView.hidden = YES;
}

- (void)preparePaymentAgriment {
	self.sendMessageExpandView.hidden = YES;
	self.createWalletExpandView.hidden = YES;
	self.expandedPresentationView.hidden = NO;
	self.compactPresentationView.hidden = YES;
	self.paymentArimentExpandView.hidden = NO;
	self.finalizedExpandView.hidden = YES;
}

- (void)prepareFinalized {
	self.sendMessageExpandView.hidden = YES;
	self.createWalletExpandView.hidden = YES;
	self.expandedPresentationView.hidden = NO;
	self.compactPresentationView.hidden = YES;
	self.paymentArimentExpandView.hidden = YES;
	self.finalizedExpandView.hidden = NO;
	self.finalizedTextLabel.text = [self isFinalizeSuccess] ? finalizedAgreeText : finalizedDisagreeText;
}


- (NSString *)getaddressFromMessage:(MSMessage *) message {
	if (!message) {
		return self.address;
	}
	NSURLComponents *components = [[NSURLComponents alloc] initWithURL:message.URL resolvingAgainstBaseURL:NO];
	NSString *address;
	for (NSURLQueryItem *item in components.queryItems) {
		if ([item.name isEqualToString:@"address"]) {
			address = item.value;
		}
	}
	return address;
}

- (NSString *)getAmountFromMessage:(MSMessage *) message {
	if (!message) {
		return nil;
	}
	NSURLComponents *components = [[NSURLComponents alloc] initWithURL:message.URL resolvingAgainstBaseURL:NO];
	NSString *amount;
	for (NSURLQueryItem *item in components.queryItems) {
		if ([item.name isEqualToString:@"amount"]) {
			amount = item.value;
		}
	}
	return amount;
}

- (NSString *)getFinalizedFromMessage:(MSMessage *) message {
	if (!message) {
		return nil;
	}
	NSURLComponents *components = [[NSURLComponents alloc] initWithURL:message.URL resolvingAgainstBaseURL:NO];
	NSString *amount;
	for (NSURLQueryItem *item in components.queryItems) {
		if ([item.name isEqualToString:@"finalized"]) {
			amount = item.value;
		}
	}
	return amount;
}

- (BOOL)isFinalizeSuccess {
	return [[self getFinalizedFromMessage:self.activeConversation.selectedMessage] isEqualToString:@"YES"] ? YES : NO;
}

- (void)didBecomeActiveWithConversation:(MSConversation *) conversation {
	[self updateControlsWithSyle:self.presentationStyle];
}

- (void)willResignActiveWithConversation:(MSConversation *) conversation {

}

- (void)willBecomeActiveWithConversation:(MSConversation *) conversation {

}

- (IBAction)actionReauestExpand:(id) sender {
	self.isCreatinNewInProcces = YES;
	[self requestPresentationStyle:MSMessagesAppPresentationStyleExpanded];
}

- (void)didStartSendingMessage:(MSMessage *) message conversation:(MSConversation *) conversation {
	[self handleSendinMessage:message];
}

- (void)willTransitionToPresentationStyle:(MSMessagesAppPresentationStyle) presentationStyle {

}

- (void)didTransitionToPresentationStyle:(MSMessagesAppPresentationStyle) presentationStyle {
	[self updateControlsWithSyle:presentationStyle];
}

#pragma mark - Сolors

UIColor *customBlueColor() {
	return [UIColor colorWithRed:46 / 255.0f green:154 / 255.0f blue:208 / 255.0f alpha:1.0f];
}

UIColor *customRedColor() {
	return [UIColor colorWithRed:231 / 255.0f green:86 / 255.0f blue:71 / 255.0f alpha:1.0f];
}

UIColor *customBlackColor() {
	return [UIColor colorWithRed:35 / 255.0f green:35 / 255.0f blue:40 / 255.0f alpha:1.0f];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *) textField {

	self.sendScreenTitleTopConstraint.constant = self.sendScreenTitleTopConstraint.constant - 40.0f;
	self.sendScreenTitleTopLandscapeConstraint.constant = self.sendScreenTitleTopLandscapeConstraint.constant - 60.0f;
	self.sendScreenCenterViewYConstraint.constant = self.sendScreenCenterViewYConstraint.constant - 60.0f;
	self.sendScreenCenterViewYLandscapeConstraint.constant = self.sendScreenCenterViewYLandscapeConstraint.constant - 90.0f;

	[UIView animateWithDuration:0.3f animations:^{
		[self.view layoutIfNeeded];
	}];

	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *) textField {

	self.sendScreenTitleTopConstraint.constant = self.sendScreenTitleTopConstraint.constant + 40.0f;
	self.sendScreenTitleTopLandscapeConstraint.constant = self.sendScreenTitleTopLandscapeConstraint.constant + 60.0f;
	self.sendScreenCenterViewYConstraint.constant = self.sendScreenCenterViewYConstraint.constant + 60.0f;
	self.sendScreenCenterViewYLandscapeConstraint.constant = self.sendScreenCenterViewYLandscapeConstraint.constant + 90.0f;

	[UIView animateWithDuration:0.3f animations:^{
		[self.view layoutIfNeeded];
	}];

	return YES;
}

@end
