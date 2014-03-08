//
//  DPDreamMainListViewController.m
//  DreamParse
//
//  Created by Liu Feng on 14-2-24.
//  Copyright (c) 2014年 Liu Feng. All rights reserved.
//

#import "DPDreamMainListViewController.h"
#import "DPDreamDetailViewController.h"
#import "DPDreamService.h"
#import "DPMainPageCell.h"
#import "DPDreamEntity.h"

#define DreamService [DPDreamService sharedInstance]

@interface DPDreamMainListViewController () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *mainPageList;

@property (strong, nonatomic) NSArray *searchResultList;

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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResultList count];
    }
    return [self.mainPageList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MainPageListCellIdentifier = @"MainPageListCell";
    static NSString *MainPageResultListCellIdentifier = @"MainPageResultList";
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MainPageResultListCellIdentifier
                                                                forIndexPath:indexPath];
        return cell;
    }
    else {
        DPMainPageCell *cell = [tableView dequeueReusableCellWithIdentifier:MainPageListCellIdentifier
                                                               forIndexPath:indexPath];
        [self configureCell:cell forIndexPath:indexPath];
        return cell;
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DPDreamEntity *dreamEntity = self.mainPageList[[self.tableView indexPathForSelectedRow].row];
    
    
    UIViewController *vc = segue.destinationViewController;
    
    if ([vc respondsToSelector:@selector(setDreamEntity:)]) {
        [vc performSelector:@selector(setDreamEntity:) withObject:dreamEntity];
    }
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // 根据关键词搜索
    NSString *keyWord = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    DPDreamEntity *dreamEntity = [DreamService searchDreamWithKeyWord:keyWord];
    
    if (dreamEntity) {
        DPDreamDetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DPDreamDtailViewController"];
        detailViewController.dreamEntity = dreamEntity;
        detailViewController.title = keyWord;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    else {
        // 没有搜索结果
    }
}


#pragma mark - Private

- (void)configureCell:(DPMainPageCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    DPDreamEntity *dreamEntity = self.mainPageList[indexPath.row];
    
    cell.dreamTitleLabel.text = dreamEntity.key;
    cell.dreamTextLabel.text = [dreamEntity.bodyText stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
}

@end
