//
//  GNZFetchedResultsControllerDataSource.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/22/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZFetchedResultsDataSource.h"

#import <CoreData/NSFetchedResultsController.h>

@interface GNZFetchedResultsDataSource () <NSFetchedResultsControllerDelegate>
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;
@end
@implementation GNZFetchedResultsDataSource

- (instancetype)init
{
  NSAssert(NO, @"use initWithFetchedResultsController:cellIdentifier:configureCellBlock");
  return nil;
}

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
                        cellIdentifier:(NSString *)cellIdentifier
                    configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock {
  if (self = [super init]) {
    _fetchedResultsController = fetchedResultsController;
    _cellIdentifier = cellIdentifier;
    _configureCellBlock = configureCellBlock;
  }
  return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
  return [self.fetchedResultsController objectAtIndexPath:indexPath];
}


#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSArray *sections = [self.fetchedResultsController sections];
  id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
  return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
  id item = [self itemAtIndexPath:indexPath];
  self.configureCellBlock(cell, item, indexPath);
  return cell;
}

@end
