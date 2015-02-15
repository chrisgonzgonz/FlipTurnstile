//
//  GNZSplitsViewController.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/15/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZSplitsViewController.h"

#import "GNZSplitsView.h"
@interface GNZSplitsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) GNZSplitsView *view;
@end

@implementation GNZSplitsViewController

- (void)loadView {
  self.view = [[GNZSplitsView alloc] init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.tableView.delegate = self;
  self.view.tableView.dataSource = self;
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Datasource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//  
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//  
//}

@end
