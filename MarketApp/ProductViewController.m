//
//  ProductViewController.m
//  MarketApp
//
//  Created by Rafael Iga on 6/24/12.
//  Copyright (c) 2012 RubyThree. All rights reserved.
//

#import "ProductViewController.h"

@interface ProductViewController ()

@end

@implementation ProductViewController
@synthesize doneButton;
@synthesize saveButton;
@synthesize nameText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setDoneButton:nil];
    [self setSaveButton:nil];
    [self setNameText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)closeModal:(id)sender {
    [self dismissModalViewControllerAnimated:TRUE];
}

- (IBAction)save:(id)sender {
    Product *product = [Product alloc];
    product.name = nameText.text;
    
    [[RKObjectManager sharedManager] postObject:product delegate:self];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
}

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    if(response.statusCode == 201) {
        [self dismissModalViewControllerAnimated:TRUE];
    }
}

@end
