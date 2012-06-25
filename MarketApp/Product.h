//
//  Product.h
//  MarketApp
//
//  Created by Rafael Iga on 6/24/12.
//  Copyright (c) 2012 RubyThree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"

@interface Product : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) Category *category;

@end
