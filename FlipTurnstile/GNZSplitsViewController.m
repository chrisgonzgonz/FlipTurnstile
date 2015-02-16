//
//  GNZSplitsViewController.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/15/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZSplitsViewController.h"

#import "GNZSplitsView.h"
@interface GNZSplitsViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic) GNZSplitsView *view;
@property (nonatomic) NSMutableArray *raceTimes;
@end

@implementation GNZSplitsViewController

- (void)loadView {
  self.view = [[GNZSplitsView alloc] init];
  self.navigationItem.titleView = [self navTitleLabelWithName:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.tableView.delegate = self;
  self.view.tableView.dataSource = self;
  self.raceTimes = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
  NSLog(@"Memory Warning!");
}
- (UILabel *)navTitleLabelWithName:(NSString *)raceName {
  UILabel *titleLabel = [[UILabel alloc] init];
  titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
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
  editTitleView.textAlignment = NSTextAlignmentRight;
  [editTitleView sizeToFit];
  editTitleView.delegate = self;
  [editTitleView becomeFirstResponder];
  editTitleView.backgroundColor = [UIColor whiteColor];
  editTitleView.borderStyle = UITextBorderStyleRoundedRect;
  return editTitleView;
}

- (void)renameRace:(id)sender {
  NSLog(@"tapping!");
  self.navigationItem.titleView = [self navTitleEditField];
}

#pragma mark - TextField Delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
  self.navigationItem.titleView = [self navTitleLabelWithName:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

#pragma mark - TableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.raceTimes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *basicCell = @"basicCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:basicCell];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:basicCell];
  }
  cell.textLabel.text = [NSString stringWithFormat:@"Lane: %lu", indexPath.row+1];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"Lap:"];
  return cell;
}

@end
