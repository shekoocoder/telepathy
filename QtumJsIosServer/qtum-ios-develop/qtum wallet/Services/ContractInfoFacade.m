//
//  ContractInfoFacade.m
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 09.11.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

@implementation ContractInfoFacade

- (NSArray <ContracBalancesObject *> *)arrayOfStingValuesOfTokenBalanceWithToken:(Contract *) token {

	NSArray *allAddressesArray = [SLocator.walletManager.wallet addressesInRightOrder];
	NSDictionary <NSString *, QTUMBigNumber *> *addressBalanceDictionary = token.addressBalanceDictionary;
	NSMutableArray *resultArray = @[].mutableCopy;

	for (int i = 0; i < allAddressesArray.count; i++) {

		ContracBalancesObject *object = [ContracBalancesObject new];
		NSString *address = allAddressesArray[i];
		object.addressString = address;
		object.longBalanceStringBalance = [addressBalanceDictionary[address] stringNumberWithPowerOfMinus10:token.decimals];
		object.shortBalanceStringBalance = [addressBalanceDictionary[address] shortFormatOfNumberWithPowerOfMinus10:token.decimals];
        object.balance = addressBalanceDictionary[address];
		[resultArray addObject:object];
	}

	return [resultArray copy];
}

- (NSArray <ContracBalancesObject *> *)sortedArrayOfStingValuesOfTokenBalanceWithToken:(Contract *) token {
    
    NSArray* resultArray = [self arrayOfStingValuesOfTokenBalanceWithToken:token];
    
    NSArray *sortedArray = [resultArray sortedArrayUsingComparator:^NSComparisonResult(ContracBalancesObject* obj1, ContracBalancesObject* obj2) {
        
        QTUMBigNumber* balance1 = obj1.balance;
        QTUMBigNumber* balance2 = obj2.balance;
        
        if ([balance1 isGreaterThan:balance2])
            return NSOrderedAscending;
        if ( [balance1 isLessThan:balance2]) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    
    return sortedArray;
}

@end
