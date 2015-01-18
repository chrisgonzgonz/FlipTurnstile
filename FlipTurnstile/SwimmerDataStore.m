//
//  SwimmerDataStore.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 1/18/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "SwimmerDataStore.h"
#import "GNZRoster.h"
#import "GNZSwimmer.h"

@interface SwimmerDataStore ()
@property (strong, readwrite, nonatomic) GNZRoster *roster;
@end
@implementation SwimmerDataStore

+ (instancetype)sharedStore {
    static SwimmerDataStore *_sharedStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedStore = [[SwimmerDataStore alloc] init];
    });
    
    return _sharedStore;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
    
        if (coordinator) {
            _managedObjectContext = [[NSManagedObjectContext alloc] init];
            _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
        }
    }
    
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SwimAttendance" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (!_persistentStoreCoordinator) {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SwimmerDataStore.sqlite"];
        NSError *error;
        
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            NSLog(@"Unresolved error: %@, %@", error, [error userInfo]);
        }
    }
    
    return _persistentStoreCoordinator;
}

- (NSURL *)persistentStoreURL {
    NSURL *storeURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"SwimAttendance.sqlite"];
    return storeURL;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)loadData {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"GNZRoster"];
    self.roster =[[self.managedObjectContext executeFetchRequest:request error:nil] firstObject];
}

- (GNZRoster *)roster {
    [self loadData];
    if (!_roster) {
        GNZRoster *newRoster = [NSEntityDescription insertNewObjectForEntityForName:@"GNZRoster" inManagedObjectContext:self.managedObjectContext];
        
        NSDictionary *swimmers = @{@"Chris": @{@"lastName": @"Gonzales", @"paymentOption": @1000}, @"Marc": @{@"lastName": @"Gershel", @"paymentOption": @10}, @"Megan": @{@"lastName": @"Jones", @"paymentOption": @8}};
        for (NSString *key in swimmers) {
            GNZSwimmer *newSwimmer = [NSEntityDescription insertNewObjectForEntityForName:@"GNZSwimmer" inManagedObjectContext:self.managedObjectContext];
            newSwimmer.email = [NSString stringWithFormat:@"%@@gmail.com", key];
            newSwimmer.firstName = key;
            newSwimmer.lastName = swimmers[key][@"lastName"];
            newSwimmer.paymentOption = swimmers[key][@"paymentOption"];
            
            [newRoster addSwimmersObject:newSwimmer];
        }
        [self.managedObjectContext save:nil];
        [self loadData];
    }
    return _roster;
}
@end
