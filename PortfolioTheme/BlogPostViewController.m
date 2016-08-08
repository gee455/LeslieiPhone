//
//  BlogPostViewController.m
//  PortfolioTheme
//
//  Created by Viktor Todorov on 10/28/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import "BlogPostViewController.h"
#import "SWRevealViewController.h"
#import "PostDetailViewController.h"
#define kTintColorHex @"#AA0000"
#import "UIColor+MBWPExtensions.h"
@interface BlogPostViewController () {
    HomeModel *_homeModel;
    NSArray *_feedItems;
    FeedItem *_selectedFeedItem;
}

@end

@implementation BlogPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:kTintColorHex];
    
    self.title = @"Leslie Science & Nature Center Events";
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self.revealViewController action:@selector(revealToggle:)];
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    [_table setDataSource:self];
    // Do any additional setup after loading the view.
    // Create array object and assign it to _feedItems variable
    _feedItems = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to _homeModel variable
    _homeModel = [[HomeModel alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _homeModel.delegate = self;
    
    // Call the download items method of the home model object
    [_homeModel downloadItems];
    
    _table.backgroundColor = [UIColor clearColor];
    [_table setDelegate:self];
    _table.separatorColor = [UIColor clearColor];
    [_table setShowsHorizontalScrollIndicator:NO];
    [_table setShowsVerticalScrollIndicator:NO];
    [_table setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _feedItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PostCell *cell = [_table dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    FeedItem *item = _feedItems[indexPath.row];
    cell.ttitle.text = item.title;
    cell.author.text = [NSString stringWithFormat:@"by %@",item.author];
    cell.summary.text = item.summary;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        return 150; /* Device is iPad */
    }
    else {
        return 150;
    }
    return 250;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Set selected feeditem to var
    _selectedFeedItem = _feedItems[indexPath.row];
    
    // Manually call segue to detail view controller
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}
#pragma mark Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get reference to the destination view controller
    PostDetailViewController *detailVC = segue.destinationViewController;
    
    // Set the property to the selected listing so when the view for
    // detail view controller loads, it can access that property to get the feeditem obj
    detailVC.selectedFeedItem = _selectedFeedItem;
}

-(void)itemsDownloaded:(NSArray *)items
{
    _feedItems = items;
    [_table reloadData];
}

@end

@implementation PostCell

@synthesize  ttitle, summary, author;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        ttitle.lineBreakMode = NSLineBreakByCharWrapping;
        ttitle.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
