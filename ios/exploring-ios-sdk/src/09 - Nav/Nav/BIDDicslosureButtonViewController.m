//
//  BIDDicslosureButtonViewController.m
//  Nav
//
//  Created by JN on 10/11/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "BIDDicslosureButtonViewController.h"

#import "BIDDisclosureDetailViewController.h"

@interface BIDDicslosureButtonViewController ()

@property (copy, nonatomic) NSArray *movies;
@end

static NSString *MovieCell = @"MovieNameCell";
#warning don't forget to put this in storyboard!

@implementation BIDDicslosureButtonViewController

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

    // Uncomment the following line to preserve selection between
    // presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation
    // bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Movies";
    self.movies = @[@"Toy Story", @"A Bug's Life", @"Toy Story 2",
                    @"Monsters, Inc.", @"Finding Nemo", @"The Incredibles",
                    @"Cars", @"Ratatouille", @"WALL-E", @"Up",
                    @"Toy Story 3", @"Cars 2", @"Brave"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*   STRIKETHROUGH

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}
 */


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*   STRIKETHROUGH
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
     */
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*   STRIKETHROUGH
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
     */
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:MovieCell
                             forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.textLabel.text = self.movies[indexPath.row];
    
    return cell;
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    BIDDisclosureDetailViewController *detail = segue.destinationViewController;
    NSInteger selectedRow = [self.tableView indexPathForSelectedRow].row;
    detail.item = self.movies[selectedRow];
}


@end


/* later...

 - (void)tableView:(UITableView *)tableView
 didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 UIAlertView *alert = [[UIAlertView alloc]
 initWithTitle:@"Hey, do you see the disclosure button?"
 message:@"Touch that to drill down instead."
 delegate:nil
 cancelButtonTitle:@"Won't happen again"
 otherButtonTitles:nil];
 [alert show];
 }
 
 - (void)tableView:(UITableView *)tableView
 accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
 {
 self.detailController.title = @"Disclosure Button Pressed";
 NSString *selectedMovie = self.movies[indexPath.row];
 NSString *detailMessage = [[NSString alloc]
 initWithFormat:@"This is details for %@.",
 selectedMovie];
 self.detailController.message = detailMessage;
 self.detailController.title = selectedMovie;
 [self.navigationController pushViewController:self.detailController
 animated:YES];
 }

*/