//
//  SHViewController.m
//  SHDeepDiff
//
//  Created by huasheng on 11/03/2022.
//  Copyright (c) 2022 huasheng. All rights reserved.
//

#import "SHViewController.h"
#import "SHTableViewController.h"

@interface SHViewController ()

@end

@implementation SHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)toTableViewController:(id)sender {
    SHTableViewController *vc = [[SHTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)toCollectionViewController:(id)sender {
    
}

@end
