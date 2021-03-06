//
//  GNZSplitsViewController.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/15/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZSplitsViewController.h"

#import "GNZRaceTime.h"
#import "GNZSplitsView.h"
#import "GNZLaneTableViewCell+ConfigureForRaceTime.h"
#import "GNZArrayDataSource.h"
static NSString * const LaneCellIdentifier = @"GNZLaneTableViewCell";

@interface GNZSplitsViewController () <UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic) GNZSplitsView *view;
@property (nonatomic) NSMutableArray *lanes;
@property (nonatomic) NSTimer *tableViewTimer;
@property (weak, nonatomic) UIButton *toggleAllButton;
@property (nonatomic) NSDate *startDate;
@property (weak, nonatomic) UILabel *headerLabel;
@property (nonatomic) GNZArrayDataSource *dataSource;
@end

@implementation GNZSplitsViewController

- (void)loadView {
  [super loadView];
  self.view = [[GNZSplitsView alloc] init];
  self.navigationItem.titleView = [self navTitleLabelWithName:nil];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addLane:)];
  self.navigationItem.leftBarButtonItem = self.editButtonItem;
  [self autolayoutViews];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.tableView.delegate = self;
  self.lanes = [[NSMutableArray alloc] init];
  
  [self.view.tableView registerNib:[GNZLaneTableViewCell nib] forCellReuseIdentifier:LaneCellIdentifier];
  
//  Fake data, kill this
  GNZRaceTime *marcTime = [[GNZRaceTime alloc] init];
  marcTime.name = @"Marc";
  GNZRaceTime *meganTime = [[GNZRaceTime alloc] init];
  meganTime.name = @"Megan";
  GNZRaceTime *chrisTime = [[GNZRaceTime alloc] init];
  chrisTime.name = @"Chris";
  self.lanes = [[NSMutableArray alloc] initWithArray:@[marcTime, meganTime, chrisTime]];
//  end fake data
  
  [self setupTableView];
}

- (void)setupTableView {
  TableViewCellConfigureBlock configureCell = ^(GNZLaneTableViewCell *cell, GNZRaceTime *raceTime, NSIndexPath *indexPath) {
    [cell configureForRaceTime:raceTime];
    [cell.stopButton addTarget:self action:@selector(stopTimer:) forControlEvents:UIControlEventTouchUpInside];
    cell.laneLabel.text = [NSString stringWithFormat:@"Lane: %@", @(indexPath.row+1)];
  };
  self.dataSource = [[GNZArrayDataSource alloc] initWithItems:self.lanes cellIdentifier:LaneCellIdentifier configureCellBlock:configureCell];
  self.view.tableView.dataSource = self.dataSource;
}

- (void)timerTick:(NSTimer *)sender {
  NSTimeInterval elapsedTime = 0;
  elapsedTime = [[NSDate date] timeIntervalSinceDate:self.startDate];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"mm:ss.SS"];
  NSDate *intervalDate = [NSDate dateWithTimeIntervalSince1970:elapsedTime];
  self.headerLabel.text = [formatter stringFromDate:intervalDate];
}

- (void)addLane:(UIBarButtonItem *)sender {
  [self.lanes addObject:[[GNZRaceTime alloc] init]];
  [self.view.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];
}

- (void)renameRace:(id)sender {
  NSLog(@"tapping!");
  self.navigationItem.titleView = [self navTitleEditField];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
  [super setEditing:editing animated:animated];
  [self.view.tableView setEditing:editing animated:animated];
  self.navigationItem.rightBarButtonItem.enabled = !editing;
}

- (void)killTimer {
  if (self.tableViewTimer.valid) {
    [self.tableViewTimer invalidate];
  }
  self.tableViewTimer = nil;
}

- (void)startStopAllLanes:(UIButton *)sender {
  NSLog(@"Tapped!");
  sender.selected = !sender.selected;
  if (sender.selected) {
    self.startDate = [NSDate date];
    for (NSInteger index = 0; index < self.lanes.count; index++) {
      GNZRaceTime *currentLane = self.lanes[index];
      if (!currentLane.lapTimes.count) {
        [self addLapTimeForRaceTime:currentLane];
      }
    }
    [self.toggleAllButton setBackgroundColor:[UIColor colorWithRed:0.904 green:0.000 blue:0.050 alpha:0.800]];
  } else {
    for (NSInteger index = 0; index < self.lanes.count; index++) {
      GNZRaceTime *currentLane = self.lanes[index];
      [self stopTimerWithCurrentLane:currentLane];
    }
    [self killTimer];
    [self.toggleAllButton setBackgroundColor:[UIColor colorWithRed:0.101 green:0.494 blue:0.322 alpha:0.800]];
  }
  [self.view.tableView reloadData];
}

- (void)stopTimerWithCurrentLane:(GNZRaceTime *)lane {
  if (!lane.raceComplete) {
    [lane addLap:[NSDate date]];
    lane.raceComplete = YES;
  }
}

- (void)stopTimer:(UIButton *)sender {
  CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.view.tableView];
  NSIndexPath *indexPath = [self.view.tableView indexPathForRowAtPoint:buttonPosition];
  GNZRaceTime *selected = self.lanes[indexPath.row];
  [self stopTimerWithCurrentLane:selected];
  [self.view.tableView beginUpdates];
  [self.view.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
  [self.view.tableView endUpdates];
}


- (void)addLapTimeForRaceTime:(GNZRaceTime *)selectedTime {
  [selectedTime addLap:[NSDate date]];
  if (!self.tableViewTimer) {
    self.tableViewTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
  }
}

#pragma mark - UI
- (UIButton *)toggleAllButton {
  if (!_toggleAllButton) {
    UIButton *toggleAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _toggleAllButton = toggleAllButton;
    _toggleAllButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_toggleAllButton setTitle:@"START ALL LANES" forState:UIControlStateNormal];
    [_toggleAllButton setTitle:@"STOP ALL LANES" forState:UIControlStateSelected];
    _toggleAllButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [_toggleAllButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_toggleAllButton setBackgroundColor:[UIColor colorWithRed:0.101 green:0.494 blue:0.322 alpha:0.800]];
    [_toggleAllButton addTarget:self action:@selector(startStopAllLanes:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_toggleAllButton];
  }
  return _toggleAllButton;
}

- (void)autolayoutViews {
  NSDictionary *views = @{@"toggleAllButton": self.toggleAllButton, @"bottomLayoutGuide":self.bottomLayoutGuide};
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[toggleAllButton(==44)][bottomLayoutGuide]" options:0 metrics:nil views:views]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[toggleAllButton]|" options:0 metrics:nil views:views]];
}

- (UILabel *)navTitleLabelWithName:(NSString *)raceName {
  UILabel *titleLabel = [[UILabel alloc] init];
  titleLabel.font = [UIFont boldSystemFontOfSize:16];
  titleLabel.text = raceName.length ? raceName : @"New Race";
  [titleLabel sizeToFit];
  titleLabel.textColor = [UIColor blackColor];
  [titleLabel setUserInteractionEnabled:YES];
  [titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(renameRace:)]];
  return titleLabel;
}

- (UITextField *)navTitleEditField {
  UITextField *editTitleView = [[UITextField alloc] init];
  editTitleView.placeholder = @"Enter Race Name";
  editTitleView.textAlignment = NSTextAlignmentCenter;
  [editTitleView sizeToFit];
  editTitleView.delegate = self;
  [editTitleView becomeFirstResponder];
  editTitleView.backgroundColor = [UIColor whiteColor];
  editTitleView.borderStyle = UITextBorderStyleRoundedRect;
  return editTitleView;
}

#pragma mark - TextField Delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
  self.navigationItem.titleView = [self navTitleLabelWithName:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  GNZRaceTime *selectedTime = self.lanes[indexPath.row];
  if (!selectedTime.raceComplete) {
    [self addLapTimeForRaceTime:selectedTime];
    [tableView beginUpdates];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [tableView endUpdates];
  }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  UILabel *headerView = [[UILabel alloc] init];
  self.headerLabel = headerView;
  self.headerLabel.textAlignment = NSTextAlignmentCenter;
  self.headerLabel.backgroundColor = [UIColor colorWithRed:0.761 green:0.788 blue:0.936 alpha:1.000];
  
  self.headerLabel.text = @"00:00.00";
  return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 44;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50;
}

@end
