//
//  ProductViewController.h
//  MarketApp
//
//  Created by Rafael Iga on 6/24/12.
//  Copyright (c) 2012 RubyThree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestKit/RestKit.h"
#import "Product.h"

@interface ProductViewController : UIViewController <RKObjectLoaderDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *nameText;

- (IBAction)closeModal:(id)sender;
- (IBAction)save:(id)sender;

@end
