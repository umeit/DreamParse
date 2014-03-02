//
//  DPDreamMainListViewController.m
//  DreamParse
//
//  Created by Liu Feng on 14-2-24.
//  Copyright (c) 2014年 Liu Feng. All rights reserved.
//

#import "DPDreamMainListViewController.h"
#import "DPDreamService.h"
#import "DPMainPageCell.h"
#import "DPDreamEntity.h"

#define DreamService [DPDreamService sharedInstance]

@interface DPDreamMainListViewController ()

@property (strong, nonatomic) NSArray *mainPageList;

@end

@implementation DPDreamMainListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [DreamService mainPageList:^(NSArray *list) {
        self.mainPageList = list;
        [self.tableView reloadData];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mainPageList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MainPageListCell";
    DPMainPageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}


#pragma mark - Private

- (void)configureCell:(DPMainPageCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    DPDreamEntity *dreamEntity = self.mainPageList[indexPath.row];
    
    cell.dreamTitleLabel.text = dreamEntity.key;
    cell.dreamTextLabel.text = dreamEntity.bodyText;
}

@end
