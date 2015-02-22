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
  self.configureCellBlock(cell, item);
  return cell;
}

@end
