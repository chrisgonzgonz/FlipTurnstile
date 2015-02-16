//
//  GNZRace.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/15/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZRaceTime.h"

@interface GNZRaceTime ()
@property (nonatomic, readwrite) NSArray *laps;
@end
@implementation GNZRaceTime

- (instancetype)init
{
  self = [super init];
  if (self) {
    _laps = @[];
  }
  return self;
}

// TODO: store NSDates instead of Time Intervals
- (void)addLap:(NSTimeInterval)timeInterval {
  self.laps = [self.laps arrayByAddingObject:@(timeInterval)];
  
}

- (NSTimeInterval)finishTime {
  return [[self.laps valueForKey:@"@sum.self"] doubleValue];
}
@end
