//
//  MasterViewController.h
//  MarketApp
//
//  Created by Rafael Iga on 6/24/12.
//  Copyright (c) 2012 RubyThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <RKObjectLoaderDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

- (void)sendRequest;

@end
