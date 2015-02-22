//
//  NSDate+GNZDateNormalizer.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 1/18/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "NSDate+GNZDateNormalizer.h"

@implementation NSDate (GNZDateNormalizer)

+ (NSDate *)normalizedDate:(NSDate *)date {
    if (!date) return nil;
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:date];
    return [calendar dateFromComponents:components];
}

@end
