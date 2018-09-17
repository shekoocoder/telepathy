//
//  NewPaymentViewController.h
//  qtum wallet
//
//  Created by Sharaev Vladimir on 18.11.16.
//  Copyright © 2016 QTUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPaymentOutputDelegate.h"
#import "NewPaymentOutput.h"

@interface NewPaymentViewController : BaseViewController <NewPaymentOutput, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, copy) NSString *currentBalance;
@property (nonatomic, copy) NSDictionary *dictionary;
@property (assign, nonatomic) NSInteger sendButtomBottomOffset;
@property (strong, nonatomic) NSArray <ContracBalancesObject *> *tokenBalancesInfo;

- (IBAction)actionVoidTap:(id) sender;

@end
