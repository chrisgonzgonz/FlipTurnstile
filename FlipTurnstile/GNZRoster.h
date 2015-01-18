//
//  GNZRoster.h
//  FlipTurnstile
//
//  Created by Chris Gonzales on 1/18/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GNZSwimmer;

@interface GNZRoster : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSSet *swimmers;
@end

@interface GNZRoster (CoreDataGeneratedAccessors)

- (void)addSwimmersObject:(GNZSwimmer *)value;
- (void)removeSwimmersObject:(GNZSwimmer *)value;
- (void)addSwimmers:(NSSet *)values;
- (void)removeSwimmers:(NSSet *)values;

@end
