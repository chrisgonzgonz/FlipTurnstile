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
@property (nonatomic) NSDateFormatter *formatter;
@end
@implementation GNZRaceTime

- (instancetype)init
{
  self = [super init];
  if (self) {
    _lapTimes = @[];
    _name = @"New Swimmer";
    _formatter = [[NSDateFormatter alloc] init];
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

- (NSString *)lapDescription {
  NSMutableString *lapString = [[NSMutableString alloc] initWithString:@"Lap:"];
  for (NSInteger x = 0; x < self.lapTimes.count; x++) {
    NSTimeInterval lapTime = [self lapTimeForIndex:x];
    NSDate *intervalDate = [NSDate dateWithTimeIntervalSince1970:lapTime];
    NSString *formattedLapTime = [self.formatter stringFromDate:intervalDate];
    if (x<self.lapTimes.count-1) [lapString appendFormat:@" %ld: %@ |", x+1, formattedLapTime];
  }
  return lapString;
}

- (NSString *)intervalToString:(NSTimeInterval)interval {
    NSDate *intervalDate = [NSDate dateWithTimeIntervalSince1970:interval];
    return [self.formatter stringFromDate:intervalDate];
}

- (NSString *)timeDescription {
  if (self.raceComplete) {
    return [self intervalToString:[self finishTime]];
  }
  
  NSTimeInterval elapsedTime = 0;
  if (self.lapTimes.count) {
    elapsedTime = [[NSDate date] timeIntervalSinceDate:self.lapTimes.firstObject];
  }
  [self.formatter setDateFormat:@"mm:ss.SS"];
  NSDate *intervalDate = [NSDate dateWithTimeIntervalSince1970:elapsedTime];
  return [self.formatter stringFromDate:intervalDate];
}

- (NSTimeInterval)lapTimeForIndex:(NSUInteger)index {
  if (index+1 < self.lapTimes.count) {
    return [self.lapTimes[index+1] timeIntervalSinceDate:self.lapTimes[index]];
  }
  return 0;
}
@end
