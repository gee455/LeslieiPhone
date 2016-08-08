//
//  HomeModel.m
//  PortfolioTheme
//
//  Created by Viktor Todorov on 10/28/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import "HomeModel.h"
#import "Strings.h"

@implementation HomeModel

- (void)downloadItems
{
    // Create feed parser and pass the URL of the feed
    NSURL *feedURL = [NSURL URLWithString:WordPressLink];
    self.feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
    
    // Delegate must conform to 'MWFeedParserDelegate'
    self.feedParser.delegate = self;
    
    // Parse the feeds info (title, link) and all feed items
    self.feedParser.feedParseType = ParseTypeFull;
    
    // Connection type
    self.feedParser.connectionType = ConnectionTypeAsynchronously;
    
    // Begin parsing
    [self.feedParser parse];
}

// Called when data has downloaded and parsing has begun
- (void)feedParserDidStart:(MWFeedParser *)parser
{
    self.feedItems = [[NSMutableArray alloc] init];
}

// Provides info about a feed item
- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item
{
    FeedItem *feedItem = [[FeedItem alloc] init];
    feedItem.title = item.title;
    feedItem.summary = item.summary;
    feedItem.author = item.author;
    feedItem.url = item.link;
    [self.feedItems addObject:feedItem];
}

// Parsing complete or stopped at any time by 'stopParsing'
- (void)feedParserDidFinish:(MWFeedParser *)parser
{
    if (self.delegate)
    {
        [self.delegate itemsDownloaded:self.feedItems];
    }
}

// Parsing failed
- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error
{
    
}

@end
