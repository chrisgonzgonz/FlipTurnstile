//
//  GNZLaneTableViewCell.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/16/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZLaneTableViewCell.h"

@implementation GNZLaneTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

+ (UINib *)nib {
  return [UINib nibWithNibName:@"GNZLaneTableViewCell" bundle:nil];
}

@end
