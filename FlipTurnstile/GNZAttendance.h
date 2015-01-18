//
//  GNZAttendance.h
//  FlipTurnstile
//
//  Created by Chris Gonzales on 1/18/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GNZQuarter, GNZSwimmer;

@interface GNZAttendance : NSManagedObject

@property (nonatomic, retain) NSDate * practiceDate;
@property (nonatomic, retain) GNZQuarter *quarter;
@property (nonatomic, retain) GNZSwimmer *swimmer;

@end
