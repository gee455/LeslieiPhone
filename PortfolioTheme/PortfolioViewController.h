//
//  PortfolioViewController.h
//  PortfolioTheme
//
//  Created by Viktor Todorov on 9/1/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TimeLineCell;
@interface PortfolioViewController : UIViewController <UITableViewDelegate, UISearchBarDelegate>{
    IBOutlet UIImageView* _photo;
    IBOutlet UIImageView* _topBar;
    IBOutlet UITableView* _tableView;
    IBOutlet UIImageView* _line;
    IBOutlet UILabel* _priceLabel;
     NSMutableDictionary* _data;
    IBOutlet UISearchBar* _search;
    NSMutableArray* _searchItems;
    NSMutableArray* _searchItemsIndexPaths;
    NSMutableDictionary* _filteredItems;
    
    BOOL _isFiltered;
    int tempIndex;
}


@end

@interface TimeLineCell : UITableViewCell
{
    UILabel *ttitle;
    UIImageView *cellImage;
    UIImageView *cellBackground;
    
}

@property (nonatomic,retain) IBOutlet UILabel *ttitle;
@property (nonatomic,retain) IBOutlet UIImageView *cellImage;
@property (nonatomic,retain) IBOutlet UIImageView *cellBackground;
@property (nonatomic,retain) IBOutlet UIButton *changeButton;
@property (nonatomic,retain) IBOutlet UIButton *deleteButton;
@property (nonatomic,retain) IBOutlet UILabel* detailText;
@property (nonatomic,retain) IBOutlet UILabel* date;
@property (nonatomic,retain) IBOutlet UILabel* dateTo;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end