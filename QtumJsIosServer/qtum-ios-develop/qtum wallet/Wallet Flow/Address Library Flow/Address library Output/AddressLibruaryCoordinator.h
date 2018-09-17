//
//  AddressLibruaryCoordinator.h
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 02.08.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddressLibruaryCoordinator;

@protocol AddressLibruaryCoordinatorDelegate <NSObject>

- (void)coordinatorLibraryDidEnd:(AddressLibruaryCoordinator *) coordinator;

- (void)coordinatorLibraryDidEnd:(AddressLibruaryCoordinator *) coordinator withQrCodeItem:(SendInfoItem *) item;

@end

@interface AddressLibruaryCoordinator : BaseCoordinator <Coordinatorable>

@property (weak, nonatomic) id <AddressLibruaryCoordinatorDelegate> delegate;

- (instancetype)initWithNavigationViewController:(UINavigationController *) navigationController;

@end
