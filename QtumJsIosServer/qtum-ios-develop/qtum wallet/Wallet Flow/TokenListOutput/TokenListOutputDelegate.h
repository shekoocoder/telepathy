//
//  TokenListOutputDelegate.h
//  qtum wallet
//
//  Created by Sharaev Vladimir on 07.07.17.
//  Copyright © 2017 QTUM. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TokenListOutputDelegate <NSObject>

@required
- (void)didSelectTokenIndexPath:(NSIndexPath *) indexPath withItem:(Contract *) item;

@end
