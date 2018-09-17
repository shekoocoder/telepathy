//
//  UIViewController+Extension.m
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 26.12.16.
//  Copyright © 2016 QTUM. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "NSUserDefaults+Settings.h"

@implementation UIViewController (Extension)

+ (UIViewController *)instantiateControllerInStoryboard:(UIStoryboard *) storyboard withIdentifire:(NSString *) identifire {

	return identifire ? [storyboard instantiateViewControllerWithIdentifier:identifire] : [storyboard instantiateInitialViewController];
}

+ (UIViewController *)controllerInStoryboard:(NSString *) storyboard withIdentifire:(NSString *) identifire {

	NSMutableString *mutString = [identifire mutableCopy];

	if ([identifire isEqualToString:@"NewPayment"] ||
			[identifire isEqualToString:@"WalletViewController"] ||
			[identifire isEqualToString:@"BalancePageViewController"] ||
			[identifire isEqualToString:@"TokenListViewController"] ||
			[identifire isEqualToString:@"ProfileViewController"] ||
			[identifire isEqualToString:@"ChoseTokenPaymentViewController"] ||
			[identifire isEqualToString:@"QRCodeViewController"] ||
			[identifire isEqualToString:@"LoginViewController"] ||
			[identifire isEqualToString:@"FirstAuthViewController"] ||
			[identifire isEqualToString:@"RepeateViewController"] ||
			[identifire isEqualToString:@"CreatePinViewController"] ||
			[identifire isEqualToString:@"WalletNameViewController"] ||
			[identifire isEqualToString:@"EnableFingerprintViewController"] ||
			[identifire isEqualToString:@"LanguageViewController"] ||
			[identifire isEqualToString:@"ExportBrainKeyViewController"] ||
			[identifire isEqualToString:@"HistoryItemViewController"] ||
			[identifire isEqualToString:@"RecieveViewController"] ||
			[identifire isEqualToString:@"ConfirmPinForExportViewController"] ||
			[identifire isEqualToString:@"RestoreWalletViewController"] ||
			[identifire isEqualToString:@"ExportWalletBrandKeyViewController"] ||
			[identifire isEqualToString:@"NewsViewController"] ||
			[identifire isEqualToString:@"TokenDetailsViewController"] ||
			[identifire isEqualToString:@"PinViewController"] ||
			[identifire isEqualToString:@"SubscribeTokenViewController"] ||
			[identifire isEqualToString:@"WatchContractViewController"] ||
			[identifire isEqualToString:@"WatchTokensViewController"] ||
			[identifire isEqualToString:@"LibraryViewController"] ||
			[identifire isEqualToString:@"SmartContractMenuViewController"] ||
			[identifire isEqualToString:@"SmartContractsListViewController"] ||
			[identifire isEqualToString:@"TemplateTokenViewController"] ||
			[identifire isEqualToString:@"PhotoLibraryPopUpViewController"] ||
			[identifire isEqualToString:@"SecurityPopupViewController"] ||
			[identifire isEqualToString:@"NoInternetConnectionPopUpViewController"] ||
			[identifire isEqualToString:@"ErrorPopUpViewController"] ||
			[identifire isEqualToString:@"InformationPopUpViewController"] ||
			[identifire isEqualToString:@"LoaderPopUpViewController"] ||
			[identifire isEqualToString:@"RestoreContractsPopUpViewController"] ||
			[identifire isEqualToString:@"RestoreContractsViewController"] ||
			[identifire isEqualToString:@"BackupContractsViewController"] ||
			[identifire isEqualToString:@"ConstructorFromAbiViewController"] ||
			[identifire isEqualToString:@"CreateTokenFinishViewController"] ||
			[identifire isEqualToString:@"TokenFunctionDetailViewController"] ||
			[identifire isEqualToString:@"TokenFunctionViewController"] ||
			[identifire isEqualToString:@"ShareTokenPopUpViewController"] ||
			[identifire isEqualToString:@"AddressControlListViewController"] ||
			[identifire isEqualToString:@"AddressTransferPopupViewController"] ||
			[identifire isEqualToString:@"TokenAddressControlViewController"] ||
			[identifire isEqualToString:@"SplashViewController"] ||
			[identifire isEqualToString:@"ChooseReciveAddressViewController"] ||
			[identifire isEqualToString:@"QStoreContractViewController"] ||
			[identifire isEqualToString:@"QStoreViewController"] ||
			[identifire isEqualToString:@"QStoreListViewController"] ||
			[identifire isEqualToString:@"SourceCodePopUpViewController"] ||
			[identifire isEqualToString:@"ConfirmPurchasePopUpViewController"] ||
			[identifire isEqualToString:@"QStoreTemplateDetailViewController"] ||
			[identifire isEqualToString:@"AboutOutputViewController"] ||
			[identifire isEqualToString:@"ConfirmPopUpViewController"] ||
			[identifire isEqualToString:@"NewsDetailViewController"] ||
            [identifire isEqualToString:@"ConfirmPassphraseViewController"]) {

		if ([NSUserDefaults isDarkSchemeSetting]) {

			[mutString appendString:@"Dark"];
		} else {
			[mutString appendString:@"Light"];
		}
	}

	return [self instantiateControllerInStoryboard:[UIStoryboard storyboardWithName:storyboard bundle:nil] withIdentifire:mutString];
}

- (UIViewController *)controllerInStoryboard:(NSString *) storyboard {
	return [UIViewController instantiateControllerInStoryboard:[UIStoryboard storyboardWithName:storyboard bundle:nil] withIdentifire:self.nameOfClass];
}

@end
