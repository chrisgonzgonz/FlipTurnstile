//
//  ArrayDataSource.h
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/21/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@interface GNZArrayDataSource : NSObject <UITableViewDataSource>
- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)cellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
@end
