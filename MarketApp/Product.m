//
//  Product.m
//  MarketApp
//
//  Created by Rafael Iga on 6/24/12.
//  Copyright (c) 2012 RubyThree. All rights reserved.
//

#import "Product.h"

@implementation Product

@synthesize identifier;
@synthesize name;
@synthesize category;

- (NSString *)description
{
    return [NSString stringWithFormat:@"\n identifier: %@ \n name: %@", identifier, name];
}

@end
