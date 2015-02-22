//
//  GNZLaneTableViewCell+ConfigureForRaceTime.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/21/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZLaneTableViewCell+ConfigureForRaceTime.h"
#import "GNZRaceTime.h"

@implementation GNZLaneTableViewCell (ConfigureForRaceTime)

- (void)configureForRaceTime:(GNZRaceTime *)raceTime {
  self.swimmerLabel.text = raceTime.name;
  self.lapsLabel.text = raceTime.lapDescription.length ? raceTime.lapDescription : @"Lap Times:";
  self.timeLabel.text = raceTime.timeDescription;
}
@end
