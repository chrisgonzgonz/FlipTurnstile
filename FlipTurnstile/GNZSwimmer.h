//
//  GNZSwimmer.h
//  FlipTurnstile
//
//  Created by Chris Gonzales on 1/18/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GNZAttendance;

@interface GNZSwimmer : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * paymentOption;
@property (nonatomic, retain) NSOrderedSet *attendances;
@end

@interface GNZSwimmer (CoreDataGeneratedAccessors)

- (void)insertObject:(GNZAttendance *)value inAttendancesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromAttendancesAtIndex:(NSUInteger)idx;
- (void)insertAttendances:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeAttendancesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInAttendancesAtIndex:(NSUInteger)idx withObject:(GNZAttendance *)value;
- (void)replaceAttendancesAtIndexes:(NSIndexSet *)indexes withAttendances:(NSArray *)values;
- (void)addAttendancesObject:(GNZAttendance *)value;
- (void)removeAttendancesObject:(GNZAttendance *)value;
- (void)addAttendances:(NSOrderedSet *)values;
- (void)removeAttendances:(NSOrderedSet *)values;
@end
