//
//  GNZRace.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/15/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZRace.h"

@interface GNZRace ()
@property (nonatomic, readwrite) NSArray *laps;
@end
@implementation GNZRace

- (instancetype)init
{
  self = [super init];
  if (self) {
    _laps = @[];
  }
  return self;
}

- (NSTimeInterval)finishTime {
  return [[self.laps valueForKey:@"@sum.self"] doubleValue];
}
@end
