//
//  CollectionViewController.h
//  PortfolioTheme
//
//  Created by Viktor Todorov on 9/2/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
@class CollectionCellClass;
@interface CollectionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView* _tableView;
    NSMutableDictionary* _data;
}

@end

@interface CollectionCellClass : UITableViewCell
{
    UILabel *ttitle;
    UIImageView *cellBackground;
    
}

@property (nonatomic,retain) IBOutlet UILabel *ttitle;
@property (nonatomic,retain) IBOutlet UIImageView *cellBackground;

@end