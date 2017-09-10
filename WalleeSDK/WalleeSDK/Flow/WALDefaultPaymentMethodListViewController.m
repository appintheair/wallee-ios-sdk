//
//  WALDefaultPaymentMethodListViewController.m
//  WalleeSDK
//
//  Created by Daniel Schmid on 04.09.17.
//  Copyright © 2017 smoca AG. All rights reserved.
//

#import "WALDefaultPaymentMethodListViewController.h"

#import "WALPaymentMethodConfiguration.h"
#import "WALLoadedPaymentMethods.h"

#import "WALPaymentMethodTableViewCell.h"

static NSString * const cellIdentifier = @"defaultCell";

@interface WALDefaultPaymentMethodListViewController ()
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation WALDefaultPaymentMethodListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"Select PaymentMethod";
}

- (void)addSubviewsToContentView:(UIView *)contentView {
    CGFloat height = self.loadedPaymentMethods.paymentMethodConfigurations.count * WALPaymentMethodTableViewCell.defaultCellHeight;
    CGRect tableRect = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y, contentView.bounds.size.width, height);
    self.tableView = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.tableView.scrollEnabled = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [contentView addSubview:self.tableView];
}

- (CGSize)contentSize {
    return CGSizeMake(self.tableView.frame.size.width, self.tableView.frame.origin.y + self.tableView.frame.size.height);
}

- (NSString *)confirmationTitle {
    return @"Token";
}

- (void)confirmationTapped:(id)sender {
    self.onBack();
}

// MARK: - TableViewDelegate and Datasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WALPaymentMethodConfiguration *method = self.loadedPaymentMethods.paymentMethodConfigurations[indexPath.row];
    if (self.onPaymentMethodSelected && method) {
        self.onPaymentMethodSelected(method);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.loadedPaymentMethods.paymentMethodConfigurations.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WALPaymentMethodTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WALPaymentMethodTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    WALPaymentMethodConfiguration *method = self.loadedPaymentMethods.paymentMethodConfigurations[indexPath.row];
    WALPaymentMethodIcon *icon = self.loadedPaymentMethods.paymentMethodIcons[method];
    [cell configureWith:method.name paymentIcon:icon];
    
    return cell;
}

@end
