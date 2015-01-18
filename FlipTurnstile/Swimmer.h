//
//  Swimmer.h
//  FlipTurnstile
//
//  Created by Chris Gonzales on 1/18/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Attendance, PaymentOption;

@interface Swimmer : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSOrderedSet *attendances;
@property (nonatomic, retain) PaymentOption *paymentOption;
@end

@interface Swimmer (CoreDataGeneratedAccessors)

- (void)insertObject:(Attendance *)value inAttendancesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromAttendancesAtIndex:(NSUInteger)idx;
- (void)insertAttendances:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeAttendancesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInAttendancesAtIndex:(NSUInteger)idx withObject:(Attendance *)value;
- (void)replaceAttendancesAtIndexes:(NSIndexSet *)indexes withAttendances:(NSArray *)values;
- (void)addAttendancesObject:(Attendance *)value;
- (void)removeAttendancesObject:(Attendance *)value;
- (void)addAttendances:(NSOrderedSet *)values;
- (void)removeAttendances:(NSOrderedSet *)values;
@end
