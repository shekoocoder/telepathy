//
//  AddressControlCellLight.m
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 02.08.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import "AddressControlCellLight.h"

@interface AddressControlCellLight ()

@property (weak, nonatomic) IBOutlet UILabel *transferTextLabel;

@end

@implementation AddressControlCellLight

- (void)awakeFromNib {

	[super awakeFromNib];
	UIView *bgColorView = [[UIView alloc] init];
	bgColorView.backgroundColor = lightBlueColor ();
	[self setSelectedBackgroundView:bgColorView];
    
    self.transferTextLabel.text = NSLocalizedString(@"Transfer", @"");
}


@end
