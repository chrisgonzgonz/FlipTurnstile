//
//  GNZLaneTableViewCell.h
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/16/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GNZRaceTime;
@interface GNZLaneTableViewCell : UITableViewCell
@property (nonatomic) GNZRaceTime *raceTime;
@property (weak, nonatomic) IBOutlet UILabel *laneLabel;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@end
