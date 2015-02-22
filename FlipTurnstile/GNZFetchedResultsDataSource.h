//
//  GNZFetchedResultsControllerDataSource.h
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/22/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSFetchedResultsController;

typedef void (^TableViewCellConfigureBlock)(id cell, id item, NSIndexPath *indexPath);

@interface GNZFetchedResultsDataSource : NSObject <UITableViewDataSource>
- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
                                  cellIdentifier:(NSString *)cellIdentifier
                              configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
@end