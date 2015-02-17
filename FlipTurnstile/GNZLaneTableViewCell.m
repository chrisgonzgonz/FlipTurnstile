//
//  GNZLaneTableViewCell.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/16/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZLaneTableViewCell.h"

#import "GNZRaceTime.h"
@interface GNZLaneTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *swimmerLabel;
@property (weak, nonatomic) IBOutlet UILabel *lapsLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
@implementation GNZLaneTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

- (void)setRaceTime:(GNZRaceTime *)raceTime {
  self.swimmerLabel.text = raceTime.name;
  self.lapsLabel.text = raceTime.lapDescription.length ? raceTime.lapDescription : @"Lap Times:";
  self.timeLabel.text = raceTime.timeDescription;
}

@end
