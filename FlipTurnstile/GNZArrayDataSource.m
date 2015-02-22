//
//  ArrayDataSource.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/21/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZArrayDataSource.h"

@interface GNZArrayDataSource ()
@property (nonatomic) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;
@end
@implementation GNZArrayDataSource

- (instancetype)init
{
  NSAssert(NO, @"Use initWithItems:cellIdentifier:configureCellBlock:");
  return nil;
}

- (id)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock {
  if (self = [super init]) {
    _items = items;
    _cellIdentifier = cellIdentifier;
    _configureCellBlock = configureCellBlock;
  }
  return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
  return self.items[indexPath.row];
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
  id item = [self itemAtIndexPath:indexPath];
  self.configureCellBlock(cell, item, indexPath);
  return cell;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
  NSMutableArray *mutableItems = [self.items mutableCopy];
  [mutableItems exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
  self.items = [mutableItems copy];
  [tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  NSMutableArray *mutableItems = [self.items mutableCopy];
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [mutableItems removeObjectAtIndex:indexPath.row];
    self.items = [mutableItems copy];
    [tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView endUpdates];
  }
}

@end
