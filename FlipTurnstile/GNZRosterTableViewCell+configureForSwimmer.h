//
//  UITableViewCell+configureCellForSwimmer.h
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/22/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZRosterTableViewCell.h"

@class GNZSwimmer;
@interface GNZRosterTableViewCell (configureForSwimmer)
- (void)configureForSwimmer:(GNZSwimmer *)swimmer;
@end
