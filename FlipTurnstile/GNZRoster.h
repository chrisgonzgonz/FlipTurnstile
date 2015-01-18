//
//  GNZRoster.h
//  FlipTurnstile
//
//  Created by Chris Gonzales on 1/18/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GNZQuarter, GNZSwimmer;

@interface GNZRoster : NSManagedObject

@property (nonatomic, retain) NSString * teamName;
@property (nonatomic, retain) NSSet *quarters;
@property (nonatomic, retain) NSSet *swimmers;
@end

@interface GNZRoster (CoreDataGeneratedAccessors)

- (void)addQuartersObject:(GNZQuarter *)value;
- (void)removeQuartersObject:(GNZQuarter *)value;
- (void)addQuarters:(NSSet *)values;
- (void)removeQuarters:(NSSet *)values;

- (void)addSwimmersObject:(GNZSwimmer *)value;
- (void)removeSwimmersObject:(GNZSwimmer *)value;
- (void)addSwimmers:(NSSet *)values;
- (void)removeSwimmers:(NSSet *)values;

@end
