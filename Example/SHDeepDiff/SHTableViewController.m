//
//  SHTableViewController.m
//  SHDeepDiff_Example
//
//  Created by 花生 on 2022/11/3.
//  Copyright © 2022 huasheng. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHCollectionViewController.h"
#import "SHDataModel.h"
#import <SHDeepDiff/SHDeepDiff.h>

@interface SHTableViewController ()

@property (nonatomic, copy) NSArray <SHDataModel *> *models;

@end

@implementation SHTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TableViewDemo";
    self.models = [SHDataModel randomModels];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.navigationItem.rightBarButtonItems = @[
        [[UIBarButtonItem alloc] initWithTitle:@"改变" style:(UIBarButtonItemStylePlain) target:self action:@selector(randomChange)],
        [[UIBarButtonItem alloc] initWithTitle:@"增删" style:(UIBarButtonItemStylePlain) target:self action:@selector(randomInsertOrDelete)],
    ];
}


- (void)randomChange {
    NSArray *models = [SHDataModel randomChange:self.models];
    NSLog(@"");
    
    for (SHDataModel *model in models) {
        NSLog(@"%ld", model.hash);
    }
    
    NSLog(@"");
    for (SHDataModel *model in self.models) {
        NSLog(@"%ld", model.hash);
    }
    NSLog(@"");
    
    [self.tableView reloadSection:0 fromList:self.models toList:models updateBlock:^{
        self.models = models;
    } completion:^(BOOL finished) {
                
    }];
    
}

- (void)randomInsertOrDelete {
    NSArray *models = [SHDataModel randomInsertOrDelete:self.models];
    [self.tableView reloadSection:0 fromList:self.models toList:models updateBlock:^{
        self.models = models;
    } completion:^(BOOL finished) {
                
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.models[indexPath.row].title;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
