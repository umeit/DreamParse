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
#import "MobClick.h"
#import "UMFeedbackViewController.h"

#define DreamService [DPDreamService sharedInstance]
#define IsSearchResultTableView (tableView == self.searchDisplayController.searchResultsTableView)

#define MainListPage @"Main List Page"

@interface DPDreamMainListViewController () <UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *mainPageList;

@property (strong, nonatomic) NSArray *searchResultList;

@end

@implementation DPDreamMainListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MainPageResultList"];
    
    self.navigationItem.rightBarButtonItem.target = self;
    self.navigationItem.rightBarButtonItem.action = @selector(feedbackButtonPress:);
    
    self.navigationItem.leftBarButtonItem.target = self;
    self.navigationItem.leftBarButtonItem.action = @selector(rateButtonPress:);
    
    [DreamService mainPageList:^(NSArray *list) {
        self.mainPageList = list;
        [self.tableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:MainListPage];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:MainListPage];
}


#pragma mark - Action

- (void)feedbackButtonPress:(id)sender
{
    [self showNativeFeedbackWithAppkey];
}

- (void)rateButtonPress:(id)sender
{
    NSLog(@"asdf");
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
    
    if (IsSearchResultTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MainPageResultListCellIdentifier
                                                                forIndexPath:indexPath];
        DPDreamEntity *dreamEntity = self.searchResultList[indexPath.row];
        cell.textLabel.text = dreamEntity.key;
        return cell;
    }
    else {
        DPMainPageCell *cell = [tableView dequeueReusableCellWithIdentifier:MainPageListCellIdentifier
                                                               forIndexPath:indexPath];
        [self configureCell:cell forIndexPath:indexPath];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IsSearchResultTableView) {
        DPDreamEntity *dreamEntity = self.searchResultList[indexPath.row];
        DPDreamDetailViewController *dreamDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DPDreamDetailViewController"];
        dreamDetailViewController.dreamEntity = dreamEntity;
        
        [self.navigationController pushViewController:dreamDetailViewController animated:YES];
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
    
}


#pragma mark - UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSString *keyWord = [searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([keyWord isEqualToString:@""]) {
        return NO;
    }
    
    self.searchResultList = [DreamService searchDreamWithKeyWord:keyWord];
    if (self.searchResultList && [self.searchResultList count] > 0) {
        return YES;
    }
    
    return NO;
}


#pragma mark - Private

- (void)showNativeFeedbackWithAppkey
{
    UMFeedbackViewController *feedbackViewController = [[UMFeedbackViewController alloc] initWithNibName:@"UMFeedbackViewController" bundle:nil];
    feedbackViewController.appkey = @"5321d22a56240b031d03dc4d";
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)configureCell:(DPMainPageCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    DPDreamEntity *dreamEntity = self.mainPageList[indexPath.row];
    
    cell.dreamTitleLabel.text = dreamEntity.key;
    cell.dreamTextLabel.text = [dreamEntity.bodyText stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
}

@end
