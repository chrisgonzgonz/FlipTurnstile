//
//  UITableViewCell+configureCellForSwimmer.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/22/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZRosterTableViewCell+configureForSwimmer.h"

#import "GNZSwimmer.h"
#import "GNZAttendance.h"
#import "NSDate+GNZDateNormalizer.h"

@implementation GNZRosterTableViewCell (configureForSwimmer)
- (void)configureForSwimmer:(GNZSwimmer *)swimmer {
  NSInteger remainingPractices = [swimmer.paymentOption integerValue] - swimmer.attendances.count;
  BOOL today = NO;
  GNZAttendance *lastAttendance = swimmer.attendances.lastObject;
  
  if ([[NSDate normalizedDate:lastAttendance.practiceDate] isEqualToDate:[NSDate normalizedDate:[NSDate date]]]) {
    today = YES;
  }
  
  self.textLabel.text = swimmer.firstName;
  self.detailTextLabel.text = [NSString stringWithFormat:@"%@ : %@", today ? @"YES" : @"NO",remainingPractices > 50 ? @"🔗" : @(remainingPractices)];
  self.detailTextLabel.textColor = [UIColor darkGrayColor];
  
  if (remainingPractices > 5) {
    self.backgroundColor = [UIColor greenColor];
  } else if (remainingPractices > 3) {
    self.backgroundColor = [UIColor yellowColor];
  } else if (remainingPractices > 1 ) {
    self.backgroundColor = [UIColor orangeColor];
  } else {
    self.backgroundColor = [UIColor redColor];
  }
}
@end
