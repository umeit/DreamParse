//
//  DPDreamDetailViewController.m
//  DreamParse
//
//  Created by Liu Feng on 14-3-5.
//  Copyright (c) 2014年 Liu Feng. All rights reserved.
//

#import "DPDreamDetailViewController.h"
#import "DPDreamEntity.h"

@interface DPDreamDetailViewController ()

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *bodyTextCell = @"DPDreamBodyTextCell";
    
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:bodyTextCell forIndexPath:indexPath];
    }
    NSString *detailText = [self.dreamEntity.bodyText stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    CGSize detailTextLabelSize = [self labelSizeWithMaxWidth:280 content:detailText];
    UILabel *bodyTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, detailTextLabelSize.width, detailTextLabelSize.height)];
    bodyTextLabel.text = detailText;
    bodyTextLabel.numberOfLines = 0;
    bodyTextLabel.textColor = [UIColor darkGrayColor];
    [cell addSubview:bodyTextLabel];
    
    // Configure the cell...
    
    return cell;
}


#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *detailText = [self.dreamEntity.bodyText stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    CGSize detailTextLabelSize = [self labelSizeWithMaxWidth:280 content:detailText];
    CGFloat cellHeight = 45 + detailTextLabelSize.height + 5;
    return cellHeight;
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
