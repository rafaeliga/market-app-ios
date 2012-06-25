//
//  MasterViewController.m
//  MarketApp
//
//  Created by Rafael Iga on 6/24/12.
//  Copyright (c) 2012 RubyThree. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/UI.h>
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ProductViewController.h"

@interface MasterViewController ()

@property (nonatomic, strong) RKFetchedResultsTableController *tableController;
@property (nonatomic, strong) NSArray *data;

@end

@implementation MasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize tableController;
@synthesize data;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewWillAppear:(BOOL)animated
{
//    [super viewWillAppear:animated];
    
    /**
     Load the table view!
     */
//    [tableController loadTable];
    [self sendRequest];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    RKURL *baseURL = [RKURL URLWithBaseURLString:@"http://market_app.dev/"];
    [RKObjectManager managerWithBaseURL:baseURL];
    [RKObjectManager sharedManager].acceptMIMEType = RKMIMETypeJSON; 
    [RKObjectManager sharedManager].serializationMIMEType = RKMIMETypeJSON;
    
    RKObjectMapping *productMapping = [RKObjectMapping mappingForClass:[Product class]];
    [productMapping mapKeyPathsToAttributes:@"id", @"identifier", @"name", @"name", nil];
    [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:productMapping forClass:[Product class]]; 
    [[RKObjectManager sharedManager].mappingProvider registerMapping:productMapping withRootKeyPath:@"product"];
    
    RKObjectMapping *categoryMapping = [RKObjectMapping mappingForClass:[Category class]];
    [categoryMapping mapKeyPathsToAttributes:@"id", @"identifier", @"name", @"name", nil];
    
    [productMapping mapRelationship:@"category" withMapping:categoryMapping];
    [[RKObjectManager sharedManager].mappingProvider setMapping:categoryMapping forKeyPath:@"category"];
    
    RKObjectRouter *router = [RKObjectManager sharedManager].router;
    [router routeClass:[Product class] toResourcePath:@"/products" forMethod:RKRequestMethodPOST];
    [router routeClass:[Product class] toResourcePath:@"/products/:identifier" forMethod:RKRequestMethodDELETE];
    
    
    /**
     Configure the RestKit table controller to drive our view
     */
//    self.tableController = [[RKObjectManager sharedManager] fetchedResultsTableControllerForTableViewController:self];
//    self.tableController.autoRefreshFromNetwork = YES;
//    self.tableController.pullToRefreshEnabled = YES;
//    self.tableController.resourcePath = @"/products";
//    self.tableController.variableHeightRows = YES;
//    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
//    self.tableController.sortDescriptors = [NSArray arrayWithObject:descriptor];
    
    /**
     Configure the Pull to Refresh View
     */
//    NSBundle *restKitResources = [NSBundle restKitResourcesBundle];
//    UIImage *arrowImage = [restKitResources imageWithContentsOfResource:@"blueArrow" withExtension:@"png"];
//    [[RKRefreshTriggerView appearance] setTitleFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
//    [[RKRefreshTriggerView appearance] setLastUpdatedFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
//    [[RKRefreshTriggerView appearance] setArrowImage:arrowImage];
    
    /**
     Configure a basic loading view
     */
//    RKGHLoadingView *loadingView = [[RKGHLoadingView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
//    loadingView.center = self.tableView.center;
//    self.tableController.loadingView = loadingView;
    
    /**
     Setup some images for various table states
     */
//    self.tableController.imageForOffline = [UIImage imageNamed:@"offline.png"];
//    self.tableController.imageForError = [UIImage imageNamed:@"error.png"];
//    self.tableController.imageForEmpty = [UIImage imageNamed:@"empty.png"];
    
    /**
     Configure our RKGHIssue -> UITableViewCell mappings. When RestKit loads the
     remote resource collection, the JSON payload will be object mapped into local
     RKGHIssue instances on a background thread. Once the payload has been processed,
     the table controller will object map the RKGHIssue instances into table cells and 
     render the tableView.
     */
//    RKTableViewCellMapping *cellMapping = [RKTableViewCellMapping cellMapping];
//    cellMapping.cellClassName = @"RKGHIssueCell";
//    cellMapping.reuseIdentifier = @"Product";
//    cellMapping.rowHeight = 100.0;
//    [cellMapping mapKeyPath:@"identifier" toAttribute:@"identifier"];
//    [cellMapping mapKeyPath:@"name" toAttribute:@"name"];
//    
//    [tableController mapObjectsWithClass:[Product class] toTableCellsWithMapping:cellMapping];
    
    /**
     Use a custom Nib to draw our table cells for RKGHIssue objects
     */
//    [self.tableView registerNib:[UINib nibWithNibName:@"RKGHIssueCell" bundle:nil] forCellReuseIdentifier:@"Product"];
}

- (void)sendRequest
{
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/products" delegate:self];    
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
}

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"response code: %d", [response statusCode]);
    NSLog(@"response body: %@", [response bodyAsString]);
    
    if([request isDELETE]) {
        [self sendRequest];
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSLog(@"objects[%d]", [objects count]);
    data = objects;
        
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Product *product = [data objectAtIndex:indexPath.row];
    cell.textLabel.text = [product name];
    cell.detailTextLabel.text = [product.category name];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Product *product = [data objectAtIndex:indexPath.row];
        [[RKObjectManager sharedManager] deleteObject:product delegate:self];
        
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

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

@end
