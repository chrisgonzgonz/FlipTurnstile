//
//  Attendance.h
//  FlipTurnstile
//
//  Created by Chris Gonzales on 1/18/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Quarter, Swimmer;

@interface Attendance : NSManagedObject

@property (nonatomic, retain) NSDate * practiceDate;
@property (nonatomic, retain) Quarter *quarter;
@property (nonatomic, retain) Swimmer *swimmer;

@end
