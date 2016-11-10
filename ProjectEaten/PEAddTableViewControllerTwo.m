//
//  PEAddTableViewControllerTwo.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 09/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PEAddTableViewControllerTwo.h"
#import "PETextFieldTableViewCell.h"

@interface PEAddTableViewControllerTwo ()

@end

@implementation PEAddTableViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *next = [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextScreen)];
    self.navigationItem.rightBarButtonItem = next;
    self.navigationItem.title = @"Restaurant Details";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PETextFieldTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PETextFieldTableViewCell"];
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Actions -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PETextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PETextFieldTableViewCell" forIndexPath:indexPath];
    
    return cell;
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Actions -

-(void)nextScreen{
    
}

@end
