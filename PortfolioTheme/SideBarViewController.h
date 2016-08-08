//
//  SideBarViewController.h
//  PortfolioTheme
//
//  Created by Viktor Todorov on 9/1/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GetMoreTableViewCell;
@interface SideBarViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView* _tableView;
    IBOutlet UIImageView* _logo;
    
     NSMutableDictionary* _data;
}

@end


@interface GetMoreTableViewCell : UITableViewCell
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

@end