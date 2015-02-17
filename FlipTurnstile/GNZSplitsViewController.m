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
#import "GNZLaneTableViewCell.h"
@interface GNZSplitsViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic) GNZSplitsView *view;
@property (nonatomic) NSMutableArray *lanes;
@property (nonatomic) NSTimer *tableViewTimer;
@property (weak, nonatomic) UIButton *toggleAllButton;
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
  self.view.tableView.dataSource = self;
  self.lanes = [[NSMutableArray alloc] init];
  
  [self.view.tableView registerNib:[UINib nibWithNibName:@"GNZLaneTableViewCell" bundle:nil] forCellReuseIdentifier:@"laneCell"];
//  Fake data, kill this
  GNZRaceTime *marcTime = [[GNZRaceTime alloc] init];
  marcTime.name = @"Marc";
  GNZRaceTime *meganTime = [[GNZRaceTime alloc] init];
  meganTime.name = @"Megan";
  GNZRaceTime *chrisTime = [[GNZRaceTime alloc] init];
  chrisTime.name = @"Chris";
  self.lanes = [[NSMutableArray alloc] initWithArray:@[marcTime, meganTime, chrisTime]];
  
}

- (void)timerTick:(NSTimer *)sender {
  [self.view.tableView reloadData];
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

- (void)startStopAllLanes:(UIButton *)sender {
  NSLog(@"Tapped!");
  sender.selected = !sender.selected;
  if (sender.selected) {
    for (NSInteger index = 0; index < self.lanes.count; index++) {
      GNZRaceTime *currentLane = self.lanes[index];
      if (!currentLane.lapTimes.count) {
        [self addLapTimeForRaceTime:currentLane];
      }
    }
    [self.toggleAllButton setBackgroundColor:[UIColor colorWithRed:0.904 green:0.000 blue:0.050 alpha:0.800]];
  } else {
    [self.toggleAllButton setBackgroundColor:[UIColor colorWithRed:0.101 green:0.494 blue:0.322 alpha:0.800]];
  }
  [self.view.tableView reloadData];
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
  [self.lanes exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
  [self.view.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [self.lanes removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  GNZRaceTime *selectedTime = self.lanes[indexPath.row];
  [self addLapTimeForRaceTime:selectedTime];
}

#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.lanes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//  static NSString *basicCell = @"basicCell";
  static NSString *laneCell = @"laneCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:laneCell];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:laneCell];
  }
//  GNZRaceTime *currentTime = self.lanes[indexPath.row];
//  NSTimeInterval elapsedTime = 0;
//  if (currentTime.lapTimes.count) {
//    elapsedTime = [[NSDate date] timeIntervalSinceDate:currentTime.lapTimes.firstObject];
//  }
//  cell.textLabel.text = [NSString stringWithFormat:@"Lane: %lu Swimmer: %@ Time: %@", indexPath.row+1, currentTime.name, currentTime.lapTimes.count ? @(elapsedTime) : @"00" ];
//  NSMutableString *lapString = [[NSMutableString alloc] init];
//  for (NSInteger x = 0; x < currentTime.lapTimes.count; x++) {
//    NSInteger lapTime = [currentTime lapTimeForIndex:x];
//    if (x<currentTime.lapTimes.count-1) [lapString appendFormat:@"Lap %ld: %ld,", x+1, (long)lapTime];
//  }
//  cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", lapString];
  return cell;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [self.view.tableView reloadData];
}

@end
