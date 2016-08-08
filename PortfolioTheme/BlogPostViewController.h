//
//  BlogPostViewController.h
//  PortfolioTheme
//
//  Created by Viktor Todorov on 10/28/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@class PostCell;
@interface BlogPostViewController : UIViewController <HomeModelProtocol,UITableViewDataSource,UITableViewDelegate> {
    IBOutlet UITableView* _table;
}

@end

@interface PostCell : UITableViewCell
{
    UILabel *ttitle;
    UITextView* summary;
    UILabel* author;
}
@property (nonatomic,retain) IBOutlet UILabel *ttitle;
@property (nonatomic,retain) IBOutlet UITextView *summary;
@property (nonatomic,retain) IBOutlet UILabel *author;
@end