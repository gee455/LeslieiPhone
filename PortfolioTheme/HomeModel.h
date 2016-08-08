//
//  HomeModel.h
//  PortfolioTheme
//
//  Created by Viktor Todorov on 10/28/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWFeedParser.h"
#import "FeedItem.h"

@protocol HomeModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end

@interface HomeModel : NSObject<MWFeedParserDelegate>

@property (nonatomic, weak) id<HomeModelProtocol> delegate;
@property (nonatomic, strong) MWFeedParser *feedParser;
@property (nonatomic, strong) NSMutableArray *feedItems;

- (void)downloadItems;

@end