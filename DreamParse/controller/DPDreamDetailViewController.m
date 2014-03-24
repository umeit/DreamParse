    //
//  DPDreamDetailViewController.m
//  DreamParse
//
//  Created by Liu Feng on 14-3-5.
//  Copyright (c) 2014年 Liu Feng. All rights reserved.
//

#import "DPDreamDetailViewController.h"
#import "DPDreamEntity.h"
#import "DPDetailViewSharedButtonCell.h"
#import "DPDreamBodyTextCell.h"
#import "MobClick.h"
#import "UMSocial.h"

//#import <ShareSDK/ShareSDK.h>

#define DetailView @"Detail View"

@interface DPDreamDetailViewController () <UMSocialUIDelegate>

@end

@implementation DPDreamDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = self.dreamEntity.key;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:DetailView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:DetailView];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *bodyTextCell = @"DPDreamBodyTextCell";
    static NSString *sharedButtonCell = @"DPSharedButtonCell";
    
    if (indexPath.row == 0) {
        DPDreamBodyTextCell *cell = [tableView dequeueReusableCellWithIdentifier:bodyTextCell forIndexPath:indexPath];
        
        NSString *detailText = [self.dreamEntity.bodyText stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
        CGSize detailTextLabelSize = [self labelSizeWithMaxWidth:280 content:detailText];
        UILabel *bodyTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, detailTextLabelSize.width, detailTextLabelSize.height)];
        bodyTextLabel.text = detailText;
        bodyTextLabel.numberOfLines = 0;
        bodyTextLabel.textColor = [UIColor darkGrayColor];
        [cell addSubview:bodyTextLabel];
        
        return cell;
    }
    else if (indexPath.row == 1) {
        DPDetailViewSharedButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:sharedButtonCell forIndexPath:indexPath];
//        [cell.sharedButton addTarget:self action:@selector(sharedButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
    return nil;
}


#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSString *detailText = [self.dreamEntity.bodyText stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
        CGSize detailTextLabelSize = [self labelSizeWithMaxWidth:280 content:detailText];
        CGFloat cellHeight = 45 + detailTextLabelSize.height + 20;
        
        return cellHeight;
    }
    else if (indexPath.row == 1) {
        return 51;
    }
    
    return 44;
}


#pragma mark - Action

- (IBAction)sharedButtonPress:(UIButton *)sender
{
    NSString *content = [self.dreamEntity.bodyText
                         stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5321d22a56240b031d03dc4d"
                                      shareText:content
                                     shareImage:[UIImage imageNamed:@"MainTableViewBackgroundImage"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,
                                                                          UMShareToWechatSession,
                                                                          UMShareToWechatTimeline,
                                                                          nil]
                                       delegate:self];
}


#pragma mark - UMSocialUIDelegate Delegate

- (void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    NSString *content = [self.dreamEntity.bodyText
                         stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    
    if ([platformName isEqualToString:UMShareToWechatTimeline]) {
//        socialData.title = content;
        socialData.shareText = @"";
        [UMSocialData defaultData].extConfig.title = content;
    }
    else {
        [UMSocialData defaultData].extConfig.title = @"标题";
    }
}


#pragma mark - Private

- (CGSize)labelSizeWithMaxWidth:(CGFloat)width content:(NSString *)content
{
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
    
    return [content boundingRectWithSize:CGSizeMake(width, 1000)
                                 options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                              attributes:dic
                                 context:nil].size;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
