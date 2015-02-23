//
//  GNZArrayDataSourceSpec.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/22/15.
//  Copyright 2015 GNZ. All rights reserved.
//

#import "Specta.h"
#import "GNZArrayDataSource.h"
#define EXP_SHORTHAND
#import <Expecta.h>
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

SpecBegin(GNZArrayDataSource)

__block UITableViewCell *configuredCell = nil;
__block id configuredObject = nil;
TableViewCellConfigureBlock block = ^(UITableViewCell *a, id b, NSIndexPath *indexPath){
  configuredCell = a;
  configuredObject = b;
};
__block id mockTableView = mock([UITableView class]);
__block GNZArrayDataSource *dataSource = [[GNZArrayDataSource alloc] initWithItems:@[@"a", @"b"] cellIdentifier:@"foo" configureCellBlock:block];

describe(@"GNZArrayDataSource", ^{
  describe(@"initialization", ^{
    it(@"should create a valid object",^{
      id obj1 = [[GNZArrayDataSource alloc] initWithItems:@[] cellIdentifier:@"foo" configureCellBlock:^(id cell, id item, NSIndexPath *indexPath) {}];
      expect(obj1).notTo.beNil();
    });
  });
  
  describe(@"providing a configured cell", ^{
    __block UITableViewCell *cell = [[UITableViewCell alloc] init];
    __block NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    __block id result;
    
    beforeAll(^{
      [given([mockTableView dequeueReusableCellWithIdentifier:@"foo"]) willReturn:cell];
      result = [dataSource tableView:mockTableView cellForRowAtIndexPath:indexPath];
    });
    
    it(@"returns the dummy cell",^{
      expect(result).to.equal(cell);
    });
    
    it(@"passes the dummy cell into the block",^{
      expect(configuredCell).to.equal(cell);
    });
    
    it(@"passes the object into the block",^{
      expect(configuredObject).to.equal(@"a");
    });
    
    it(@"calls dequeueCellWithIdentifier on the dummy tableview",^{
      [MKTVerify(mockTableView) dequeueReusableCellWithIdentifier:@"foo"];
    });
  });
});

SpecEnd
