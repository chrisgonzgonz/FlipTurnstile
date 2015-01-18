//
//  GNZRosterViewController.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 1/18/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZRosterViewController.h"

@interface GNZRosterViewController ()

@end

@implementation GNZRosterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Roster";
    [self addTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = @"Numba";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%li", indexPath.row];
    return cell;
}

- (void)addTableView {
    UITableView *rosterTable = [[UITableView alloc] init];
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
