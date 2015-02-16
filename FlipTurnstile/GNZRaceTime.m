//
//  GNZRace.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/15/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZRaceTime.h"

@interface GNZRaceTime ()
@property (nonatomic, readwrite) NSArray *lapTimes;
@end
@implementation GNZRaceTime

- (instancetype)init
{
  self = [super init];
  if (self) {
    _lapTimes = @[];
    _name = @"New Swimmer";
  }
  return self;
}

// TODO: store NSDates instead of Time Intervals
- (void)addLap:(NSDate *)lapDate {
  self.lapTimes = [self.lapTimes arrayByAddingObject:lapDate];
}

- (NSTimeInterval)finishTime {
  return [self.lapTimes.lastObject timeIntervalSinceDate:self.lapTimes.firstObject];
}

- (NSTimeInterval)lapTimeForIndex:(NSUInteger)index {
  if (index+1 < self.lapTimes.count) {
    return [self.lapTimes[index+1] timeIntervalSinceDate:self.lapTimes[index]];
  }
  return 0;
}
@end
