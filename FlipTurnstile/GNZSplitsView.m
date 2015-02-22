//
//  GNZSplitsView.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 2/14/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "GNZSplitsView.h"

@interface GNZSplitsView ()
@property (weak, nonatomic, readwrite) UITableView *tableView;
@end
@implementation GNZSplitsView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self autolayoutSubviews];
  }
  return self;
}

- (void)autolayoutSubviews {
  NSDictionary *views = @{@"tableView": self.tableView};
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views]];
}

- (UITableView *)tableView {
  if (!_tableView) {
    UITableView *tableView = [[UITableView alloc] init];
    _tableView = tableView;
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_tableView];
  }
  return _tableView;
}


@end
