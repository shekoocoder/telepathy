//
//  AbiParameterTypeAddress.m
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 30.08.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

@implementation AbiParameterTypeAddress

@synthesize type;

-(ParameterTypeFromAbi)type {
    return Address;
}

@end
