//
//  HistoryElement.m
//  qtum wallet
//
//  Created by Sharaev Vladimir on 21.11.16.
//  Copyright © 2016 QTUM. All rights reserved.
//

@implementation HistoryElement

@synthesize
    address = _address,
    amount = _amount,
    amountString = _amountString,
    txHash = _txHash,
    dateNumber = _dateNumber,
    shortDateString = _shortDateString,
    fullDateString = _fullDateString,
    send = _send,
    confirmed = _confirmed,
    isSmartContractCreater = _isSmartContractCreater,
    fromAddreses = _fromAddreses,
    toAddresses = _toAddresses,
    currency = _currency;

- (void)calcAmountAndAdresses:(NSDictionary *) dictionary {

	NSDictionary *hashTableAdresses = [self hashTableOfKeys];
	CGFloat outMoney = 0;
	CGFloat inMoney = 0;

	//if hashTable of adresses constain object, add this value to inValue
	for (NSDictionary *inObject in dictionary[@"vin"]) {

		[self.fromAddreses addObject:@{@"address": inObject[@"address"],
				@"value": inObject[@"value"]}];
		NSString *address = hashTableAdresses[inObject[@"address"]];
		if (address) {
			inMoney += [inObject[@"value"] doubleValue];
		}
	}

	//if hashTable of adresses constain object, add this value to ouyValue
	for (NSDictionary *outObject in dictionary[@"vout"]) {
		[self.toAddresses addObject:@{@"address": outObject[@"address"],
				@"value": outObject[@"value"]}];

		NSString *address = hashTableAdresses[outObject[@"address"]];
		if (address) {
			outMoney += [outObject[@"value"] doubleValue];
		}
	}

	CGFloat amount = outMoney - inMoney;
	self.amount = [QTUMBigNumber decimalWithString:[NSString stringWithFormat:@"%f", amount]];
	self.send = amount < 0;
}

#pragma mark - Accessory Methods

- (void)setAmount:(QTUMBigNumber *) amount {
	_amount = amount;
	[self createAmountString];
}

- (void)setDateNumber:(NSNumber *) dateNumber {
	_dateNumber = dateNumber;
	[self createDateString];
}

- (NSMutableArray *)fromAddreses {
	if (!_fromAddreses) {
		_fromAddreses = @[].mutableCopy;
	}
	return _fromAddreses;
}

- (NSString *)currency {

    return @"QTUM";
}

- (NSMutableArray *)toAddresses {
	if (!_toAddresses) {
		_toAddresses = @[].mutableCopy;
	}
	return _toAddresses;
}

#pragma mark - Private Methods

- (void)createAmountString {
	self.amountString = [NSString stringWithFormat:@"%@ %@", [self.amount roundedNumberWithScale:3].stringValue, NSLocalizedString(@"QTUM", nil)];
}

- (void)createDateString {

	CGFloat dateNumber = [self.dateNumber doubleValue];
	if (!dateNumber) {
		return;
	}

	NSTimeInterval dateTimeInterval = dateNumber;
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateTimeInterval];

	NSDateFormatter *fullDateFormater = [[NSDateFormatter alloc] init];
	fullDateFormater.dateFormat = @"MMMM d, hh:mm:ss aa";
	fullDateFormater.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];

	self.fullDateString = [NSString stringWithFormat:@"%@", [fullDateFormater stringFromDate:date]];

	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"MMM dd";
	dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];

	self.shortDateString = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:date]];
}

- (NSString *)shortDateString {

	CGFloat dateNumber = [self.dateNumber doubleValue];
	if (!dateNumber) {
		return @"";
	}

	NSTimeInterval dateTimeInterval = dateNumber;
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateTimeInterval];
	NSTimeInterval nowTimeInterval = [[NSDate new] timeIntervalSince1970];

	NSTimeInterval difference = nowTimeInterval - dateTimeInterval;
	NSTimeInterval day = 24 * 60 * 60;
	NSTimeInterval currenDayTimeInterval = (long)nowTimeInterval % (long)day;
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

	if (difference < currenDayTimeInterval) {
		dateFormatter.dateFormat = @"h:mm a";
		dateFormatter.AMSymbol = @"a.m.";
		dateFormatter.PMSymbol = @"p.m.";
		dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];

	} else {
		dateFormatter.dateFormat = @"MMM dd";
		dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
	}

	return [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:date]];
}

- (NSString *)formattedDateStringSinceCome {

	CGFloat dateNumber = [self.dateNumber doubleValue];
	if (!dateNumber) {
		return @"";
	}

	NSTimeInterval dateTimeInterval = dateNumber;
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateTimeInterval];
	NSDate *now = [NSDate date];

	NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
	formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;

	NSCalendar *calendar = [NSCalendar currentCalendar];
	calendar.locale = [NSLocale localeWithLocaleIdentifier:[LanguageManager currentLanguageCode]];

	NSDateComponents *components = [calendar components:(NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond)
											   fromDate:date
												 toDate:now
												options:0];

	NSString *formatString;

	if (components.day >= 2) {

		return self.shortDateString;

	} else if (components.day == 1) {

		formatString = NSLocalizedString(@"Yesterday", @"day at history cell");
		return formatString;
        
	} else if (components.hour >= 1 && components.hour < 24) {

		return self.shortDateString;

	} else if (components.minute >= 1 && components.minute < 60) {

		NSString *minutsString = NSLocalizedString(@"minuts ago", @"time ago");
		NSString *minutString = NSLocalizedString(@"minut ago", @"time ago");

		return [NSString stringWithFormat:@"%li %@", (long)components.minute, components.minute > 1 ? minutsString : minutString];

	} else if (components.second > 0 && components.second < 60) {

		formatString = NSLocalizedString(@"few seconds ago", @"few seconds ago");
		return formatString;
	} else {
		return self.shortDateString;
	}
}

- (NSDictionary *)hashTableOfKeys {
	return [SLocator.walletManager hashTableOfKeysForHistoryElement];
}

#pragma mark - Setup

- (void)setupWithObject:(id) object {

	if ([object isKindOfClass:[NSDictionary class]]) {
		//u shoud not use setter at initionalize
		self.dateNumber = ![object[@"block_time"] isKindOfClass:[NSNull class]] ? object[@"block_time"] : nil;
		self.address = object[@"address"];
		self.confirmed = [object[@"block_height"] floatValue] > 0;
		self.txHash = ![object[@"tx_hash"] isKindOfClass:[NSNull class]] ? object[@"tx_hash"] : nil;
		self.isSmartContractCreater = [object[@"contract_has_been_created"] boolValue];
		[self calcAmountAndAdresses:object];
	}
}

- (NSDictionary *)dictionaryFromElementForWatch {
	NSString *address = self.send ? [self.toAddresses firstObject][@"address"] : [self.fromAddreses firstObject][@"address"];

	NSDictionary *dictionary = @{@"address": address ? : @"",
			@"date": self.shortDateString ? : @"",
			@"amount": self.amountString ? : @"",
			@"send": @(self.send)};

	return dictionary;
}

#pragma mark - Equal

- (BOOL)isEqualElementWithoutConfimation:(HistoryElement *) object {

	if (self.address && object.address && ![self.address isEqualToString:object.address]) {
		return NO;
	}
	if (self.amount && object.amount && ![self.amount isEqualToDecimalNumber:object.amount]) {
		return NO;
	}
	if (self.amountString && object.amountString && ![self.amountString isEqualToString:object.amountString]) {
		return NO;
	}
	if (self.dateNumber && object.dateNumber && ![self.dateNumber isEqualToNumber:object.dateNumber]) {
		return NO;
	}
	if (self.send != object.send) {
		return NO;
	}
	if (self.txHash && object.txHash && ![self.txHash isEqualToString:object.txHash]) {
		return NO;
	}
	return YES;
}
    
@end
