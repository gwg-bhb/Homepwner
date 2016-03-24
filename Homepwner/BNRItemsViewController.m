//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by hello on 16/2/21.
//  Copyright © 2016年 hello. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItem.h"
#import "BNRItemStore.h"

@interface BNRItemsViewController ()

//@property (nonatomic, strong) IBOutlet UIView * headerView;

@end

@implementation BNRItemsViewController

-(IBAction)addnNewItem:(id)sender
{
    BNRItem *newItem = [[BNRItemStore sharedStore]createItem];
    
    NSInteger lastRow =[[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:lastRow inSection:0];
    
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}
/*
-(IBAction)toggleEditingMode:(id)sender
{
    if(self.isEditing)
    {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        
        [self setEditing:NO animated:YES];
    }
    else
    {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        
        [self  setEditing:YES animated:YES];
    }
}
 

-(UIView *)headerView
{
    if (!_headerView) {
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    
    return _headerView;
}
 */



-(instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];  //调用父类的指定初始化方法
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addnNewItem:)];
        
        navItem.rightBarButtonItem = bbi;
        
        navItem.leftBarButtonItem = self.editButtonItem;
        navItem.leftBarButtonItem.title = @"编辑";
    }
    return  self;
}

-(instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = [items objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [item description];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] init];
    
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectedItem = items[indexPath.row];
    
    detailViewController.item = selectedItem;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
//    UIView *header = [self headerView];
//    [self.tableView setTableHeaderView:header];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

@end
