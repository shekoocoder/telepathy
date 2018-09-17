//
//  TextFieldWithLineLight.m
//  qtum wallet
//
//  Created by Sharaev Vladimir on 10.07.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import "TextFieldWithLineLight.h"

@implementation TextFieldWithLineLight

- (UIColor *)getUnderlineColorDeselected {
	return [UIColor whiteColor];
}

- (UIColor *)getUnderlineColorSelected {
	return [UIColor whiteColor];
}

- (UIColor *)getPlaceholderColor {
	return lightTextFieldPlaceholderColor ();
}

- (UIFont *)getPlaceholderFont {
	return [UIFont fontWithName:@"ProximaNova-Regular" size:self.font.pointSize];
}

@end
