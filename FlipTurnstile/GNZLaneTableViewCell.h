//
//  GNZLaneTableViewCell.h
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/16/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNZLaneTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *laneLabel;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UILabel *swimmerLabel;
@property (weak, nonatomic) IBOutlet UILabel *lapsLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
+ (UINib *)nib;
@end
