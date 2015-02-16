//
//  GNZRace.h
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/15/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GNZSwimmer;
@interface GNZRace : NSObject
@property (nonatomic) NSDate *dateStarted;
@property (nonatomic) GNZSwimmer *swimmer;
@property (nonatomic, readonly) NSArray *laps;
- (NSTimeInterval)finishTime;
@end
