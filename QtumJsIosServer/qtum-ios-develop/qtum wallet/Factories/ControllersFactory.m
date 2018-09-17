//
//  ControllersFactory.m
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 26.12.16.
//  Copyright © 2016 QTUM. All rights reserved.
//

#import "SendNavigationCoordinator.h"
#import "NewsNavigationController.h"
#import "ProfileNavigationCoordinator.h"
#import "UIViewController+Extension.h"
#import "TabBarControllerDark.h"
#import "WalletNameViewController.h"
#import "LoginViewController.h"
#import "FirstAuthViewController.h"
#import "RestoreWalletViewController.h"
#import "CreatePinViewController.h"
#import "RepeateViewController.h"
#import "AuthNavigationController.h"
#import "ExportWalletBrandKeyViewController.h"
#import "SubscribeTokenViewController.h"
#import "WalletNavigationController.h"
#import "ConstructorFromAbiViewController.h"
#import "CreateTokenFinishViewController.h"
#import "TokenDetailsViewController.h"
#import "TokenFunctionViewController.h"
#import "TokenFunctionDetailViewController.h"
#import "TemplateTokenViewController.h"
#import "AddNewTokensViewController.h"
#import "QRCodeViewController.h"
#import "ChoseTokenPaymentViewController.h"
#import "SmartContractMenuViewController.h"
#import "SmartContractsListViewController.h"
#import "WatchContractViewController.h"
#import "RestoreContractsViewController.h"
#import "EnableFingerprintViewController.h"
#import "TabBarControllerLight.h"
#import "NSUserDefaults+Settings.h"

#import "SecurityPopupViewController.h"
#import "RestoreContractsPopUpViewController.h"
#import "LoaderPopUpViewController.h"
#import "ErrorPopUpViewController.h"
#import "ConfirmPopUpViewController.h"
#import "NoInternetConnectionPopUpViewController.h"
#import "PhotoLibraryPopUpViewController.h"
#import "SourceCodePopUpViewController.h"
#import "ConfirmPurchasePopUpViewController.h"
#import "ShareTokenPopUpViewController.h"
#import "InformationPopUpViewController.h"
#import "AddressTransferPopupViewController.h"

#import "NewPaymentOutput.h"
#import "WalletOutput.h"
#import "BalancePageOutput.h"
#import "TokenListOutput.h"
#import "ProfileOutput.h"
#import "LanguageOutput.h"
#import "ExportBrainKeyOutput.h"
#import "HistoryItemOutput.h"
#import "RecieveOutput.h"
#import "LibraryOutput.h"
#import "NewsOutput.h"
#import "BackupContractOutput.h"
#import "AddressControlOutput.h"
#import "TokenAddressLibraryOutput.h"
#import "SplashScreenOutput.h"
#import "QStoreContractOutput.h"
#import "QStoreListOutput.h"
#import "QStoreTemplateDetailOutput.h"
#import "AboutOutput.h"
#import "ChooseReciveAddressOutput.h"
#import "NewsDetailOutput.h"
#import "SourceCodeOutput.h"
#import "QRCodeOutput.h"
#import "ConfirmPassphraseOutput.h"

@implementation ControllersFactory

- (UIViewController *)sendFlowTab {
	SendNavigationCoordinator *nav = [[SendNavigationCoordinator alloc] init];
	return nav;
}

- (UIViewController *)profileFlowTab {
	NSObject <ProfileOutput> *controller = (NSObject <ProfileOutput> *)[UIViewController controllerInStoryboard:@"Profile" withIdentifire:@"ProfileViewController"];
	ProfileNavigationCoordinator *nav = [[ProfileNavigationCoordinator alloc] initWithRootViewController:[controller toPresent]];
	return nav;
}

- (UIViewController *)newsFlowTab {

	NewsNavigationController *nav = [[NewsNavigationController alloc] init];
	return nav;
}



- (UITabBarController <TabbarOutput> *)createTabFlow {

	if ([NSUserDefaults isDarkSchemeSetting]) {
		return [TabBarControllerDark new];
	} else {
		return [TabBarControllerLight new];
	}
}

- (UINavigationController *)walletFlowTab {

	NSObject <BalancePageOutput> *controller = (NSObject <BalancePageOutput> *)[UIViewController controllerInStoryboard:@"Wallet" withIdentifire:@"BalancePageViewController"];
	WalletNavigationController *nav = [[WalletNavigationController alloc] initWithRootViewController:[controller toPresent]];
	return nav;
}

- (NSObject <NewPaymentOutput> *)createNewPaymentDarkViewController {

	NSObject <NewPaymentOutput> *controller = (NSObject <NewPaymentOutput> *)[UIViewController controllerInStoryboard:@"Send" withIdentifire:@"NewPayment"];
	return controller;
}

- (NSObject <QRCodeOutput> *)createQRCodeViewControllerForSend {

	NSObject <QRCodeOutput> *controller = (NSObject <QRCodeOutput> *)[UIViewController controllerInStoryboard:@"Send" withIdentifire:@"QRCodeViewController"];
	return controller;
}

- (WalletNameViewController *)createWalletNameCreateController {

	WalletNameViewController *controller = (WalletNameViewController *)[UIViewController controllerInStoryboard:@"Start" withIdentifire:@"WalletNameViewController"];
	return controller;
}

- (NSObject <LoginViewOutput> *)createLoginController {

	NSObject <LoginViewOutput> *controller = (NSObject <LoginViewOutput> *)[UIViewController controllerInStoryboard:@"Start" withIdentifire:@"LoginViewController"];
	return controller;
}

- (NSObject <LoginViewOutput> *)createConfirmPinForExportViewController {

	NSObject <LoginViewOutput> *controller = (NSObject <LoginViewOutput> *)[UIViewController controllerInStoryboard:@"Profile" withIdentifire:@"ConfirmPinForExportViewController"];
	return controller;
}

- (NSObject <FirstAuthOutput> *)createFirstAuthController {

	NSObject <FirstAuthOutput> *controller = (FirstAuthViewController *)[UIViewController controllerInStoryboard:@"Start" withIdentifire:@"FirstAuthViewController"];
	return controller;
}

- (NSObject <RestoreWalletOutput> *)createRestoreWalletController {

	NSObject <RestoreWalletOutput> *controller = (NSObject <RestoreWalletOutput> *)[UIViewController controllerInStoryboard:@"Start" withIdentifire:@"RestoreWalletViewController"];
	return controller;
}

- (CreatePinViewController *)createCreatePinController {
	CreatePinViewController *controller = (CreatePinViewController *)[UIViewController controllerInStoryboard:@"Start" withIdentifire:@"CreatePinViewController"];
	return controller;
}

- (NSObject <ChangePinOutput> *)createChangePinController {
	NSObject <ChangePinOutput> *output = (NSObject <ChangePinOutput> *)[UIViewController controllerInStoryboard:@"Profile" withIdentifire:@"PinViewController"];
	return output;
}

- (RepeateViewController *)createRepeatePinController {
	RepeateViewController *controller = (RepeateViewController *)[UIViewController controllerInStoryboard:@"Start" withIdentifire:@"RepeateViewController"];
	return controller;
}

- (AuthNavigationController *)createAuthNavigationController {
	AuthNavigationController *controller = [[AuthNavigationController alloc] init];
	return controller;
}

- (ExportWalletBrandKeyViewController *)createExportWalletBrandKeyViewController {
	ExportWalletBrandKeyViewController *controller = (ExportWalletBrandKeyViewController *)[UIViewController controllerInStoryboard:@"Start" withIdentifire:@"ExportWalletBrandKeyViewController"];
	return controller;
}

- (NSObject <ConfirmPassphraseOutput> *)createConfirmBrandKeyViewController {
    
    NSObject <ConfirmPassphraseOutput> *output = (NSObject <ConfirmPassphraseOutput> *)[UIViewController controllerInStoryboard:@"Start" withIdentifire:@"ConfirmPassphraseViewController"];
    return output;
}

- (NSObject <SubscribeTokenOutput> *)createSubscribeTokenViewController {

	NSObject <SubscribeTokenOutput> *output = (NSObject <SubscribeTokenOutput> *)[UIViewController controllerInStoryboard:@"SubscribeToken" withIdentifire:@"SubscribeTokenViewController"];
	return output;
}

- (NSObject <SourceCodeOutput> *)createSourceCodeOutput {

	NSObject <SourceCodeOutput> *output = (NSObject <SourceCodeOutput> *)[UIViewController controllerInStoryboard:@"Profile" withIdentifire:@"SourceCodeViewController"];
	return output;
}

- (NSObject <LanguageOutput> *)createLanguageViewController {
	NSObject <LanguageOutput> *controller = (NSObject <LanguageOutput> *)[UIViewController controllerInStoryboard:@"Profile" withIdentifire:@"LanguageViewController"];
	return controller;
}

- (NSObject <ExportBrainKeyOutput> *)createExportBrainKeyViewController {
	NSObject <ExportBrainKeyOutput> *controller = (NSObject <ExportBrainKeyOutput> *)[UIViewController controllerInStoryboard:@"Profile" withIdentifire:@"ExportBrainKeyViewController"];
	return controller;
}

- (NSObject <RecieveOutput> *)createRecieveViewController {
	NSObject <RecieveOutput> *controller = (NSObject <RecieveOutput> *)[UIViewController controllerInStoryboard:@"Wallet" withIdentifire:@"RecieveViewController"];
	return controller;
}

- (NSObject <HistoryItemOutput> *)createHistoryItem {
	NSObject <HistoryItemOutput> *controller = (NSObject <HistoryItemOutput> *)[UIViewController controllerInStoryboard:@"Wallet" withIdentifire:@"HistoryItemViewController"];
	return controller;
}

- (NSObject <WalletOutput> *)createWalletViewController {
	NSObject <WalletOutput> *controller = (NSObject <WalletOutput> *)[UIViewController controllerInStoryboard:@"Wallet" withIdentifire:@"WalletViewController"];
	return controller;
}

- (NSObject <ConstructorAbiOutput> *)createConstructorFromAbiViewController {

	NSObject <ConstructorAbiOutput> *output = (NSObject <ConstructorAbiOutput> *)[UIViewController controllerInStoryboard:@"CreateToken" withIdentifire:@"ConstructorFromAbiViewController"];
	return output;
}

- (NSObject <QStoreTemplateDetailOutput> *)createQStoreTemplateDetailOutput {

	NSObject <QStoreTemplateDetailOutput> *output = (NSObject <QStoreTemplateDetailOutput> *)[UIViewController controllerInStoryboard:@"QStore" withIdentifire:@"QStoreTemplateDetailViewController"];
	return output;
}

- (NSObject <ContractCreationEndOutput> *)createCreateTokenFinishViewController {

	NSObject <ContractCreationEndOutput> *output = (NSObject <ContractCreationEndOutput> *)[UIViewController controllerInStoryboard:@"CreateToken" withIdentifire:@"CreateTokenFinishViewController"];
	return output;
}

- (NSObject <TokenDetailOutput> *)createTokenDetailsViewController {

	NSObject <TokenDetailOutput> *controller = (NSObject <TokenDetailOutput> *)[UIViewController controllerInStoryboard:@"Wallet" withIdentifire:@"TokenDetailsViewController"];
	return controller;
}

- (NSObject <TokenListOutput> *)createTokenListViewController {
	NSObject <TokenListOutput> *controller = (NSObject <TokenListOutput> *)[UIViewController controllerInStoryboard:@"Wallet" withIdentifire:@"TokenListViewController"];
	return controller;
}

- (NSObject <ContractFunctionsOutput> *)createTokenFunctionViewController {

	NSObject <ContractFunctionsOutput> *output = (NSObject <ContractFunctionsOutput> *)[UIViewController controllerInStoryboard:@"CreateToken" withIdentifire:@"TokenFunctionViewController"];
	return output;
}

- (NSObject <ContractFunctionDetailOutput> *)createTokenFunctionDetailViewController {
	NSObject <ContractFunctionDetailOutput> *controller = (NSObject <ContractFunctionDetailOutput> *)[UIViewController controllerInStoryboard:@"CreateToken" withIdentifire:@"TokenFunctionDetailViewController"];
	return controller;
}

- (NSObject <TemplatesListOutput> *)createTemplateTokenViewController {

	NSObject <TemplatesListOutput> *output = (NSObject <TemplatesListOutput> *)[UIViewController controllerInStoryboard:@"CreateToken" withIdentifire:@"TemplateTokenViewController"];
	return output;
}

- (AddNewTokensViewController *)createAddNewTokensViewController {
	AddNewTokensViewController *controller = (AddNewTokensViewController *)[UIViewController controllerInStoryboard:@"SubscribeToken" withIdentifire:@"AddNewTokensViewController"];
	return controller;
}

- (NSObject <QRCodeOutput> *)createQRCodeViewControllerForSubscribe {
	NSObject <QRCodeOutput> *controller = (NSObject <QRCodeOutput> *)[UIViewController controllerInStoryboard:@"SubscribeToken" withIdentifire:@"QRCodeViewController"];
	return controller;
}

- (NSObject <QRCodeOutput> *)createQRCodeViewControllerForWallet {
	NSObject <QRCodeOutput> *controller = (NSObject <QRCodeOutput> *)[UIViewController controllerInStoryboard:@"Wallet" withIdentifire:@"QRCodeViewController"];
	return controller;
}

- (ChoseTokenPaymentViewController *)createChoseTokenPaymentViewController {
	ChoseTokenPaymentViewController *controller = (ChoseTokenPaymentViewController *)[UIViewController controllerInStoryboard:@"Send" withIdentifire:@"ChoseTokenPaymentViewController"];
	return controller;
}

- (NSObject <SmartContractMenuOutput> *)createSmartContractMenuViewController {

	NSObject <SmartContractMenuOutput> *controller = (NSObject <SmartContractMenuOutput> *)[UIViewController controllerInStoryboard:@"CreateToken" withIdentifire:@"SmartContractMenuViewController"];
	return controller;
}

- (NSObject <PublishedContractListOutput> *)createSmartContractsListViewController {

	NSObject <PublishedContractListOutput> *controller = (NSObject <PublishedContractListOutput> *)[UIViewController controllerInStoryboard:@"CreateToken" withIdentifire:@"SmartContractsListViewController"];
	return controller;
}

- (NSObject <QStoreMainOutput> *)createQStoreMainViewController {
	NSObject <QStoreMainOutput> *controller = (NSObject <QStoreMainOutput> *)[UIViewController controllerInStoryboard:@"QStore" withIdentifire:@"QStoreViewController"];
	return controller;
}

- (NSObject <QStoreListOutput> *)createQStoreListViewController {
	NSObject <QStoreListOutput> *controller = (NSObject <QStoreListOutput> *)[UIViewController controllerInStoryboard:@"QStore" withIdentifire:@"QStoreListViewController"];
	return controller;
}

- (NSObject <QStoreContractOutput> *)createQStoreContractViewController {
	NSObject <QStoreContractOutput> *controller = (NSObject <QStoreContractOutput> *)[UIViewController controllerInStoryboard:@"QStore" withIdentifire:@"QStoreContractViewController"];
	return controller;
}

- (NSObject <WatchContractOutput> *)createWatchContractViewController {
	NSObject <WatchContractOutput> *controller = (NSObject <WatchContractOutput> *)[UIViewController controllerInStoryboard:@"CreateToken" withIdentifire:@"WatchContractViewController"];
	return controller;
}


- (NSObject <WalletTokenOutput> *)createWatchTokensViewController {
	NSObject <WalletTokenOutput> *controller = (NSObject <WalletTokenOutput> *)[UIViewController controllerInStoryboard:@"CreateToken" withIdentifire:@"WatchTokensViewController"];
	return controller;
}

- (NSObject <RestoreContractsOutput> *)createRestoreContractViewController {

	NSObject <RestoreContractsOutput> *controller = (NSObject <RestoreContractsOutput> *)[UIViewController controllerInStoryboard:@"BackupRestore" withIdentifire:@"RestoreContractsViewController"];
	return controller;
}

- (NSObject <BackupContractOutput> *)createBackupContractViewController {

	NSObject <BackupContractOutput> *output = (NSObject <BackupContractOutput> *)[UIViewController controllerInStoryboard:@"BackupRestore" withIdentifire:@"BackupContractsViewController"];
	return output;
}

- (NSObject <AddressControlOutput> *)createAddressControllOutput {

	NSObject <AddressControlOutput> *output = (NSObject <AddressControlOutput> *)[UIViewController controllerInStoryboard:@"Wallet" withIdentifire:@"AddressControlListViewController"];
	return output;
}

- (NSObject <TokenAddressLibraryOutput> *)createTokenAddressControllOutput {

	NSObject <TokenAddressLibraryOutput> *output = (NSObject <TokenAddressLibraryOutput> *)[UIViewController controllerInStoryboard:@"Wallet" withIdentifire:@"TokenAddressControlViewController"];
	return output;
}

- (EnableFingerprintViewController *)createEnableFingerprintViewController {
	EnableFingerprintViewController *controller = (EnableFingerprintViewController *)[UIViewController controllerInStoryboard:@"Start" withIdentifire:@"EnableFingerprintViewController"];
	return controller;
}

- (NSObject <ChooseReciveAddressOutput> *)createChooseReciveAddressOutput {

	NSObject <ChooseReciveAddressOutput> *controller = (NSObject <ChooseReciveAddressOutput> *)[UIViewController controllerInStoryboard:@"Wallet" withIdentifire:@"ChooseReciveAddressViewController"];
	return controller;
}

- (NSObject <LibraryOutput> *)createLibraryViewController {
	NSObject <LibraryOutput> *controller = (NSObject <LibraryOutput> *)[UIViewController controllerInStoryboard:@"CreateToken" withIdentifire:@"LibraryViewController"];
	return controller;
}

- (NSObject <SplashScreenOutput> *)createSplashScreenOutput {
	NSObject <SplashScreenOutput> *controller = (NSObject <SplashScreenOutput> *)[UIViewController controllerInStoryboard:@"Splash" withIdentifire:@"SplashViewController"];
	return controller;
}

- (NSObject <NewsDetailOutput> *)createNewsDetailOutput {

	NSObject <NewsDetailOutput> *output = (NSObject <NewsDetailOutput> *)[UIViewController controllerInStoryboard:@"News" withIdentifire:@"NewsDetailViewController"];
	return output;
}

- (NSObject <NewsOutput> *)createNewsOutput {

	NSObject <NewsOutput> *output = (NSObject <NewsOutput> *)[UIViewController controllerInStoryboard:@"News" withIdentifire:@"NewsViewController"];
	return output;
}

- (NSObject <AboutOutput> *)createAboutOutput {

	NSObject <AboutOutput> *output = (NSObject <AboutOutput> *)[UIViewController controllerInStoryboard:@"Profile" withIdentifire:@"AboutOutputViewController"];
	return output;
}

- (UIViewController *)createFlowNavigationCoordinator {
	return nil;
}

- (UIViewController *)createPinFlowController {
	return nil;
}

- (UIViewController *)createWalletFlowController {
	return nil;
}

- (UIViewController *)changePinFlowController {
	return nil;
}



@end
