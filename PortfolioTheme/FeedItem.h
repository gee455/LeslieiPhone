//
//  FeedItem.h
//  PortfolioTheme
//
//  Created by Viktor Todorov on 10/28/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *summary;

@end
