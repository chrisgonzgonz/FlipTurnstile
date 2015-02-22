//
//  GNZRosterViewController.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 1/18/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZRosterViewController.h"
#import "GNZSwimmerDataStore.h"
#import "GNZSwimmer.h"
#import "GNZAttendance.h"
#import "NSDate+GNZDateNormalizer.h"
#import "GNZFetchedResultsControllerDataSource.h"
#import "GNZRosterTableViewCell+configureForSwimmer.h"

static NSString * const cellID = @"Cell";

@interface GNZRosterViewController () <UITableViewDelegate, NSFetchedResultsControllerDelegate>
@property (nonatomic) UITableView *view;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) GNZFetchedResultsControllerDataSource *fetchedResultsControllerDataSource;

@end

@implementation GNZRosterViewController

- (void)loadView {
  self.view = [[UITableView alloc] init];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"M/d/yyyy"];
  self.navigationItem.title = [NSString stringWithFormat: @"Roster: %@", [formatter stringFromDate:[NSDate date]]];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [[GNZSwimmerDataStore sharedStore] roster];
  NSLog(@"%@", [[GNZSwimmerDataStore sharedStore] applicationDocumentsDirectory]);
  self.managedObjectContext = [[GNZSwimmerDataStore sharedStore] managedObjectContext];
  
  [self setupTableView];
}

- (void)setupTableView {
  self.view.delegate = self;
  
  TableViewCellConfigureBlock configureCell = ^(GNZRosterTableViewCell *cell, GNZSwimmer *swimmer, NSIndexPath *indexPath){
    [cell configureForSwimmer:swimmer];
    NSLog(@"configuring cell");
  };
  self.fetchedResultsControllerDataSource = [[GNZFetchedResultsControllerDataSource alloc] initWithFetchedResultsController:self.fetchedResultsController cellIdentifier:cellID configureCellBlock:configureCell];
  self.view.dataSource = self.fetchedResultsControllerDataSource;
  [self.view registerClass:[GNZRosterTableViewCell class] forCellReuseIdentifier:cellID];
}

- (NSFetchedResultsController *)fetchedResultsController {
  if (!_fetchedResultsController) {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([GNZSwimmer class])];
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:NSStringFromSelector(@selector(firstName)) ascending:YES]]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    NSError *error;
    [self.fetchedResultsController performFetch:&error];
    if (error) {
      NSLog(@"Unable to perform fetch.");
      NSLog(@"%@, %@", error, error.localizedDescription);
    }
  }
  return _fetchedResultsController;
}

#pragma mark - UITableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  GNZSwimmer *selectedSwimmer = [self.fetchedResultsController objectAtIndexPath:indexPath];
  GNZAttendance *lastAttendance = selectedSwimmer.attendances.lastObject;
  if ([[NSDate normalizedDate:lastAttendance.practiceDate] isEqualToDate:[NSDate normalizedDate:[NSDate date]]]) {
    [self.managedObjectContext deleteObject:lastAttendance];
  } else {
    GNZAttendance *newAttendance = [NSEntityDescription insertNewObjectForEntityForName:@"GNZAttendance" inManagedObjectContext:self.managedObjectContext];
    newAttendance.practiceDate = [NSDate date];
    newAttendance.swimmer = selectedSwimmer;
  }
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
}

#pragma mark - NSFetchedResultsController Delegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
  [self.view beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  [self.view endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
  switch (type) {
    case NSFetchedResultsChangeInsert:
      [self.view insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    case NSFetchedResultsChangeDelete: {
      [self.view deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    }
    case NSFetchedResultsChangeUpdate: {
      [self.view reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
      break;
    }
    case NSFetchedResultsChangeMove: {
      [self.view deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      [self.view insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    }
    default:
      break;
  }
}
@end
