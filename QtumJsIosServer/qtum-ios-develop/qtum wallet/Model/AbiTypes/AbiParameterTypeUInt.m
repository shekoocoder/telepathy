//
//  AbiParameterTypeUInt.m
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 30.08.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

@implementation AbiParameterTypeUInt

@synthesize type;

-(ParameterTypeFromAbi)type {
    return Uint;
}

- (NSInteger)maxValueLenght {

	if (self.size == 256) {
		return 78;
	}

	if (self.size == 128) {
		return 39;
	}

	if (self.size == 96) {
		return 29;
	}

	if (self.size == 64) {
		return 20;
	}

	if (self.size == 64) {
		return 19;
	}

	if (self.size == 48) {
		return 15;
	}

	if (self.size == 32) {
		return 10;
	}

	if (self.size == 24) {
		return 8;
	}

	if (self.size == 16) {
		return 5;
	}

	if (self.size == 8) {
		return 3;
	}

	if (self.size == 4) {
		return 2;
	}

	return 1;
}

@end
