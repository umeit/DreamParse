//
//  DPDreamDtailViewController.m
//  DreamParse
//
//  Created by Liu Feng on 14-2-24.
//  Copyright (c) 2014年 Liu Feng. All rights reserved.
//

#import "DPDreamDtailViewController.h"
#import "DPDreamEntity.h"

@interface DPDreamDtailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *detailTextLabel;
@end

@implementation DPDreamDtailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.detailTextLabel.text = [self.dreamEntity.bodyText stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
}

@end
