//
//  GNZRosterViewController.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 1/18/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZRosterViewController.h"
#import "SwimmerDataStore.h"
#import "GNZSwimmer.h"
#import "GNZAttendance.h"
#import "NSDate+GNZDateNormalizer.h"

@interface GNZRosterViewController () <NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation GNZRosterViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"MM/yyyy"];
  
  
  self.navigationItem.title = [NSString stringWithFormat: @"Roster: %@", [formatter stringFromDate:[NSDate date]]];
  
  [self addTableView];
  [[SwimmerDataStore sharedStore] roster];
  NSLog(@"%@", [[SwimmerDataStore sharedStore] applicationDocumentsDirectory]);
  
  
  self.managedObjectContext = [[SwimmerDataStore sharedStore] managedObjectContext];
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"GNZSwimmer"];
  [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES]]];
  self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
  self.fetchedResultsController.delegate = self;
  NSError *error;
  [self.fetchedResultsController performFetch:&error];
  if (error) {
    NSLog(@"Unable to perform fetch.");
    NSLog(@"%@, %@", error, error.localizedDescription);
  }
  
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSArray *sections = [self.fetchedResultsController sections];
  id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
  return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellID = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
  }
  [self configureCell:cell atIndexPath:indexPath];
  
  return cell;
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
  [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  [self.tableView endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
  switch (type) {
    case NSFetchedResultsChangeInsert:
      [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    case NSFetchedResultsChangeDelete: {
      [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    }
    case NSFetchedResultsChangeUpdate: {
      [self configureCell:(UITableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
      break;
    }
    case NSFetchedResultsChangeMove: {
      [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    }
    default:
      break;
  }
}

#pragma mark - Helper methods

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  GNZSwimmer *swimmer = [self.fetchedResultsController objectAtIndexPath:indexPath];
  
  NSInteger remainingPractices = [swimmer.paymentOption integerValue] - swimmer.attendances.count;
  BOOL today = NO;
  GNZAttendance *lastAttendance = swimmer.attendances.lastObject;
  
  if ([[NSDate normalizedDate:lastAttendance.practiceDate] isEqualToDate:[NSDate normalizedDate:[NSDate date]]]) {
    today = YES;
  }
  
  cell.textLabel.text = swimmer.firstName;
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ : %@", today ? @"YES" : @"NO",remainingPractices > 50 ? @"🔗" : @(remainingPractices)];
  cell.detailTextLabel.textColor = [UIColor darkGrayColor];
  
  if (remainingPractices > 5) {
    cell.backgroundColor = [UIColor greenColor];
  } else if (remainingPractices > 3) {
    cell.backgroundColor = [UIColor yellowColor];
  } else if (remainingPractices > 1 ) {
    cell.backgroundColor = [UIColor orangeColor];
  } else {
    cell.backgroundColor = [UIColor redColor];
  }
}

- (void)addTableView {
  UITableView *rosterTable = [[UITableView alloc] init];
  self.tableView = rosterTable;
  rosterTable.dataSource = self;
  rosterTable.delegate = self;
  [self.view addSubview:rosterTable];
  [rosterTable setTranslatesAutoresizingMaskIntoConstraints:NO];
  NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(rosterTable);
  NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[rosterTable]|" options:0 metrics:nil views:viewDictionary];
  [self.view addConstraints:hConstraints];
  NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rosterTable]|" options:0 metrics:nil views:viewDictionary];
  [self.view addConstraints:vConstraints];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
