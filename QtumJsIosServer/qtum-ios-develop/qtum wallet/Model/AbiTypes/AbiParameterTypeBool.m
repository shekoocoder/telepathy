//
//  AbiParameterTypeBool.m
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 30.08.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

@implementation AbiParameterTypeBool

- (NSInteger)maxValueLenght {

	return 1;
}

-(ParameterTypeFromAbi)type {
    return Bool;
}

@end
