//
//  PostDetailViewController.h
//  PortfolioTheme
//
//  Created by Viktor Todorov on 10/28/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import "ViewController.h"
#import "FeedItem.h"
@interface PostDetailViewController : ViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) FeedItem *selectedFeedItem;
@end
