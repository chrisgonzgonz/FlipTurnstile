//
//  GNZLaneTableViewCell+ConfigureForRaceTime.h
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/21/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZLaneTableViewCell.h"

@class GNZRaceTime;
@interface GNZLaneTableViewCell (ConfigureForRaceTime)
- (void)configureForRaceTime:(GNZRaceTime *)raceTime;
@end
