//
//  PopupService.m
//  qtum wallet
//
//  Created by Sharaev Vladimir on 18.05.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import "NoInternetConnectionPopUpViewController.h"
#import "PhotoLibraryPopUpViewController.h"
#import "InformationPopUpViewController.h"
#import "ConfirmPopUpViewController.h"
#import "ErrorPopUpViewController.h"
#import "LoaderPopUpViewController.h"
#import "RestoreContractsPopUpViewController.h"
#import "SecurityPopupViewController.h"
#import "SourceCodePopUpViewController.h"
#import "ConfirmPurchasePopUpViewController.h"
#import "ShareTokenPopUpViewController.h"
#import "AddressTransferPopupViewController.h"

@interface PopupService () <PopUpViewControllerDelegate>

@property (nonatomic) PopUpViewController *currentPopUp;

@end

@implementation PopupService

#pragma mark - Instance

- (instancetype)init {

	self = [super init];
	if (self != nil) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (noInternetConnetion) name:NO_INTERNET_CONNECTION_ERROR_KEY object:nil];
	}
	return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Creation of pop-up

- (NoInternetConnectionPopUpViewController *)createNoInternetConnetion {
    
	NoInternetConnectionPopUpViewController *controller = [SLocator.popupFactory createNoInternetConnectionPopUpViewController];
	return controller;
}

- (PhotoLibraryPopUpViewController *)createPhotoLibrary {
	PhotoLibraryPopUpViewController *controller = [SLocator.popupFactory createPhotoLibraryPopUpViewController];
	return controller;
}

- (ErrorPopUpViewController *)createErrorPopUp {
	ErrorPopUpViewController *controller = [SLocator.popupFactory createErrorPopUpViewController];
	return controller;
}

- (InformationPopUpViewController *)createInformationPopUp {
	InformationPopUpViewController *controller = [SLocator.popupFactory createInformationPopUpViewController];
	return controller;
}

- (ConfirmPopUpViewController *)createConfirmPopUp {
	ConfirmPopUpViewController *controller = [SLocator.popupFactory createConfirmPopUpViewController];
	return controller;
}

- (SecurityPopupViewController *)createSecurityPopUp {
	SecurityPopupViewController *controller = [SLocator.popupFactory createSecurityPopupViewController];
	return controller;
}

- (AddressTransferPopupViewController *)createAddressTransferPopUp {
	AddressTransferPopupViewController *controller = [SLocator.popupFactory createAddressTransferPopupViewController];
	return controller;
}

- (LoaderPopUpViewController *)createLoaderPopUp {
	LoaderPopUpViewController *controller = [SLocator.popupFactory createLoaderViewController];
	return controller;
}

- (RestoreContractsPopUpViewController *)createRestoreContractPopUp {
	RestoreContractsPopUpViewController *controller = [SLocator.popupFactory createRestoreContractsPopUpViewController];
	return controller;
}

- (SourceCodePopUpViewController *)createSourceCodePopUp {
	SourceCodePopUpViewController *controller = [SLocator.popupFactory createSourceCodePopUpViewController];
	return controller;
}

- (ConfirmPurchasePopUpViewController *)createConfirmPurchasePopUp {
	ConfirmPurchasePopUpViewController *controller = [SLocator.popupFactory createConfirmPurchasePopUpViewController];
	return controller;
}

- (ShareTokenPopUpViewController *)createShareTokenPopUp {
	ShareTokenPopUpViewController *controller = [SLocator.popupFactory createShareTokenPopUpViewController];
	return controller;
}

#pragma mark - Public Methods

- (void)showLoaderPopUp {

	BOOL needShow = [self checkAndHideCurrentPopUp:[LoaderPopUpViewController class] withContent:nil];
	if (!needShow) {
		return;
	}

	LoaderPopUpViewController *controller = [self createLoaderPopUp];
	self.currentPopUp = controller;
	[controller showFromViewController:nil animated:YES completion:nil];
}

- (LoaderPopUpViewController *)showLoaderPopUpInView:(UIView *) view {

	LoaderPopUpViewController *controller = [self createLoaderPopUp];
	self.currentPopUp = controller;
	[controller showFromView:view animated:YES completion:nil];
	return controller;
}

- (void)dismissLoader {

	if ([self.currentPopUp isKindOfClass:[LoaderPopUpViewController class]]) {
		[self hideCurrentPopUp:NO completion:nil];
	}
}

- (void)dismissLoader:(LoaderPopUpViewController *) loader {

	[loader hide:YES completion:nil];
}

- (void)showNoIntenterConnetionsPopUp:(id <PopUpViewControllerDelegate>) delegate presenter:(UIViewController *) presenter completion:(void (^)(void)) completion {
	BOOL needShow = [self checkAndHideCurrentPopUp:[NoInternetConnectionPopUpViewController class] withContent:nil];
	if (!needShow) {
		return;
	}

	NoInternetConnectionPopUpViewController *controller = [self createNoInternetConnetion];
	controller.delegate = delegate;
	self.currentPopUp = controller;
	[controller showFromViewController:presenter animated:YES completion:completion];
}

- (void)showPhotoLibraryPopUp:(id <PopUpWithTwoButtonsViewControllerDelegate>) delegate presenter:(UIViewController *) presenter completion:(void (^)(void)) completion {
	BOOL needShow = [self checkAndHideCurrentPopUp:[PhotoLibraryPopUpViewController class] withContent:nil];
	if (!needShow) {
		return;
	}

	PhotoLibraryPopUpViewController *controller = [self createPhotoLibrary];
	controller.delegate = delegate;
	self.currentPopUp = controller;
	[controller showFromViewController:presenter animated:YES completion:completion];
}

- (ErrorPopUpViewController *)showErrorPopUp:(id <PopUpWithTwoButtonsViewControllerDelegate>) delegate withContent:(PopUpContent *) content presenter:(UIViewController *) presenter completion:(void (^)(void)) completion {

	BOOL needShow = [self checkAndHideCurrentPopUp:[ErrorPopUpViewController class] withContent:content];
	if (!needShow) {
		return nil;
	}

	ErrorPopUpViewController *controller = [self createErrorPopUp];
	controller.delegate = delegate;
	[controller setContent:content];
	self.currentPopUp = controller;
	[controller showFromViewController:presenter animated:YES completion:completion];
	return controller;
}

- (void)showInformationPopUp:(id <PopUpViewControllerDelegate>) delegate withContent:(PopUpContent *) content presenter:(UIViewController *) presenter completion:(void (^)(void)) completion {

	BOOL needShow = [self checkAndHideCurrentPopUp:[InformationPopUpViewController class] withContent:content];
	if (!needShow) {
		return;
	}

	InformationPopUpViewController *controller = [self createInformationPopUp];
	controller.delegate = delegate;
	[controller setContent:content];
	self.currentPopUp = controller;
	[controller showFromViewController:presenter animated:YES completion:completion];
}

- (RestoreContractsPopUpViewController *)showRestoreContractsPopUp:(id <PopUpWithTwoButtonsViewControllerDelegate>) delegate presenter:(UIViewController *) presenter completion:(void (^)(void)) completion {

	BOOL needShow = [self checkAndHideCurrentPopUp:[RestoreContractsPopUpViewController class] withContent:nil];
	if (!needShow) {
		return nil;
	}

	RestoreContractsPopUpViewController *controller = [self createRestoreContractPopUp];
	controller.delegate = delegate;
	self.currentPopUp = controller;
	[controller showFromViewController:presenter animated:YES completion:completion];
	return controller;
}

- (void)showConfirmPopUp:(id <PopUpWithTwoButtonsViewControllerDelegate>) delegate withContent:(PopUpContent *) content presenter:(UIViewController *) presenter completion:(void (^)(void)) completion {

	BOOL needShow = [self checkAndHideCurrentPopUp:[ConfirmPopUpViewController class] withContent:content];
	if (!needShow) {
		return;
	}

	ConfirmPopUpViewController *controller = [self createConfirmPopUp];
	controller.delegate = delegate;
	[controller setContent:content];
	self.currentPopUp = controller;
	[controller showFromViewController:presenter animated:YES completion:completion];
}

- (void)showSourceCodePopUp:(id <PopUpWithTwoButtonsViewControllerDelegate>) delegate withContent:(PopUpContent *) content presenter:(UIViewController *) presenter completion:(void (^)(void)) completion {

	BOOL needShow = [self checkAndHideCurrentPopUp:[SourceCodePopUpViewController class] withContent:content];
	if (!needShow) {
		return;
	}

	SourceCodePopUpViewController *controller = [self createSourceCodePopUp];
	controller.delegate = delegate;
	[controller setContent:content];
	self.currentPopUp = controller;
	[controller showFromViewController:presenter animated:YES completion:completion];
}

- (SecurityPopupViewController *)showSecurityPopup:(id <SecurityPopupViewControllerDelegate>) delegate presenter:(UIViewController *) presenter completion:(void (^)(void)) completion {

	SecurityPopupViewController *controller = [self createSecurityPopUp];
	controller.popupDelegate = delegate;
	self.currentPopUp = controller;
	[controller showFromViewController:presenter animated:YES completion:completion];
	return controller;
}

- (AddressTransferPopupViewController *)showAddressTransferPopupViewController:(id <PopUpWithTwoButtonsViewControllerDelegate>) delegate presenter:(UIViewController *) presenter toAddress:(NSString *) address withFromAddressVariants:(NSArray <WalletBalancesObject *> *) variants completion:(void (^)(void)) completion {

	AddressTransferPopupViewController *controller = [self createAddressTransferPopUp];
	controller.toAddress = address;
	controller.fromAddressesVariants = variants;
	controller.delegate = delegate;
	self.currentPopUp = controller;
	[controller showFromViewController:presenter animated:YES completion:completion];
	return controller;
}


- (ConfirmPurchasePopUpViewController *)showConfirmPurchasePopUp:(id <PopUpWithTwoButtonsViewControllerDelegate>) delegate presenter:(UIViewController *) presenter completion:(void (^)(void)) completion {

	BOOL needShow = [self checkAndHideCurrentPopUp:[ConfirmPurchasePopUpViewController class] withContent:nil];
	if (!needShow) {
		return nil;
	}

	ConfirmPurchasePopUpViewController *controller = [self createConfirmPurchasePopUp];
	controller.delegate = delegate;
	self.currentPopUp = controller;
	[controller showFromViewController:presenter animated:YES completion:completion];
	return controller;
}

- (ShareTokenPopUpViewController *)showShareTokenPopUp:(id <ShareTokenPopupViewControllerDelegate>) delegate presenter:(UIViewController *) presenter completion:(void (^)(void)) completion {

	BOOL needShow = [self checkAndHideCurrentPopUp:[ShareTokenPopUpViewController class] withContent:nil];
	if (!needShow) {
		return nil;
	}

	ShareTokenPopUpViewController *controller = [self createShareTokenPopUp];
	controller.delegate = delegate;
	self.currentPopUp = controller;
	[controller showFromViewController:presenter animated:YES completion:completion];
	return controller;
}

- (void)hideCurrentPopUp:(BOOL) animated completion:(void (^)(void)) completion {
	if (self.currentPopUp == nil)
		return;

	[self.currentPopUp hide:animated completion:completion];
	self.currentPopUp = nil;
}

#pragma mark - Private Methods

- (BOOL)checkAndHideCurrentPopUp:(Class) class withContent:(PopUpContent *) content {
	if (!self.currentPopUp)
		return true;
	BOOL contentEqual = [self.currentPopUp content] ? [[self.currentPopUp content] isEqualContent:content] : true;
	if ([self.currentPopUp isKindOfClass:class] && contentEqual)
		return false;

	[self hideCurrentPopUp:NO completion:nil];
	return true;
}

- (void)noInternetConnetion {
	[self showNoIntenterConnetionsPopUp:self presenter:nil completion:nil];
}

#pragma mark - PopUpViewControllerDelegate

- (void)okButtonPressed:(PopUpViewController *) sender {
	[self hideCurrentPopUp:YES completion:nil];
}

@end
