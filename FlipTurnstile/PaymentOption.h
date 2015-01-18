//
//  PaymentOption.h
//  FlipTurnstile
//
//  Created by Chris Gonzales on 1/18/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Swimmer;

@interface PaymentOption : NSManagedObject

@property (nonatomic, retain) NSDate * purchaseDate;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) Swimmer *swimmer;

@end
