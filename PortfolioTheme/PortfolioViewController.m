//
//  PortfolioViewController.m
//  PortfolioTheme
//
//  Created by Viktor Todorov on 9/1/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import "PortfolioViewController.h"
#import "SWRevealViewController.h"
#import "UIKit+AFNetworking.h"
#import "Strings.h"
#import "OffersViewController.h"
#import "SWRevealViewController.h"
#import "GalleryViewController.h"
#import "RadioStreamViewController.h"

@interface PortfolioViewController ()

@end

#define kBorderWidth 3.0
#define kCornerRadius 8.0
#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )
@implementation PortfolioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isFiltered = NO;
    _search.delegate = self;
    _searchItems = [NSMutableArray new];
    _searchItemsIndexPaths = [NSMutableArray new];
    _filteredItems = [NSMutableDictionary new];
    // Do any additional setup after loading the view.
    _data = [NSMutableDictionary new];
    _data = [[[NSUserDefaults standardUserDefaults]objectForKey:@"dictOffers"] mutableCopy];
    
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    _photo.layer.cornerRadius = 45;
    _photo.clipsToBounds = YES;
    _topBar.alpha = 1;
    _line.alpha = 1;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView setDelegate:self];
    _tableView.separatorColor = [UIColor clearColor];
    [_tableView setShowsHorizontalScrollIndicator:NO];
    [_tableView setShowsVerticalScrollIndicator:NO];
    [self readTopScorePlist];
    tempIndex = 0;
    [self updateContent];
    
}
-(void)updateContent {
    for (int i = 0;i < [_data count]; i++) {
        [_searchItems addObject:[[_data valueForKey:[NSString stringWithFormat:@"%i",i]] valueForKey:@"Destination"]];
        [_searchItemsIndexPaths addObject:[NSNumber numberWithInt:i]];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_isFiltered == NO) {
        return [_data count];
    }
    else {
        return [_filteredItems count];
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSString *row = [NSString stringWithFormat:@"%li",(long)indexPath.row];
    TimeLineCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //NSMutableDictionary *menu = [_data valueForKey:row];
    if (cell == nil) {
        cell = [[TimeLineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if(_isFiltered == NO) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ttitle.text = [[_data valueForKey:row] valueForKey:@"Destination"];
        cell.detailText.text = [[_data valueForKey:row] valueForKey:@"Description"];
        cell.date.text = [[_data valueForKey:row] valueForKey:@"DateFrom"];
        NSString* priceString = [NSString stringWithFormat:@"%@ %@",[[_data valueForKey:row] valueForKey:@"NormalPrice"],[[_data valueForKey:row] valueForKey:@"Currency"]];
        cell.priceLabel.text = priceString;
        CALayer * l = [cell.cellImage layer];
        [l setMasksToBounds:YES];
        [l setCornerRadius:0];
        
        CALayer * b = [cell.cellBackground layer];
        [b setMasksToBounds:YES];
        [b setCornerRadius:0];
       [cell.cellImage setImageWithURL:[NSURL URLWithString:[[_data valueForKey:row] valueForKey:@"Image"]] placeholderImage:[UIImage imageNamed:@"loadingSign.jpg"]];
        
       cell.backgroundColor = [UIColor clearColor];
        
    }
    else {
        NSLog(@"Test: %@", [[_filteredItems valueForKey:row] valueForKey:@"Destination"]);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ttitle.text = [[_filteredItems valueForKey:row] valueForKey:@"Destination"];
        cell.detailText.text = [[_filteredItems valueForKey:row] valueForKey:@"Description"];
        cell.date.text = [[_filteredItems valueForKey:row] valueForKey:@"DateFrom"];
        NSString* priceString = [NSString stringWithFormat:@"%@ %@",[[_filteredItems valueForKey:row] valueForKey:@"NormalPrice"],[[_filteredItems valueForKey:row] valueForKey:@"Currency"]];
        cell.priceLabel.text = priceString;
        CALayer * l = [cell.cellImage layer];
        [l setMasksToBounds:YES];
        [l setCornerRadius:0];
        
        CALayer * b = [cell.cellBackground layer];
        [b setMasksToBounds:YES];
        [b setCornerRadius:0];
        [cell.cellImage setImageWithURL:[NSURL URLWithString:[[_filteredItems valueForKey:row] valueForKey:@"Image"]] placeholderImage:[UIImage imageNamed:@"loadingSign.jpg"]];
        
        cell.backgroundColor = [UIColor clearColor];

    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:(void (^)(void)) ^{
                         cell.transform=CGAffineTransformMakeScale(0.5, 0.5);
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.1
                                               delay:0
                                             options:UIViewAnimationOptionBeginFromCurrentState
                                          animations:(void (^)(void)) ^{
                                              cell.transform=CGAffineTransformMakeScale(1.0, 1.0);
                                          }
                                          completion:^(BOOL finished){
                                              
                                          }];
                     }];

    [[NSUserDefaults standardUserDefaults]setInteger:indexPath.row forKey:@"offerNumber"];
    UIStoryboard *storyboard = self.storyboard;
    
    BOOL isRadio = [[[_data valueForKey:[NSString stringWithFormat:@"%li",(long)indexPath.row]] valueForKey:@"isRadioStation"] boolValue];
    BOOL isGallery = [[[_data valueForKey:[NSString stringWithFormat:@"%li",(long)indexPath.row]] valueForKey:@"isGallery"] boolValue];
    
    if(isGallery == YES && isRadio == NO) {
        GalleryViewController* abc = [storyboard instantiateViewControllerWithIdentifier:@"gallery"];
        abc._source = _data;
        [self presentViewController:abc animated:YES completion:nil];
    }
    else if(isRadio == YES && isGallery == NO) {
        RadioStreamViewController* abc = [storyboard instantiateViewControllerWithIdentifier:@"radio"];
        abc.source = _data;
        [self presentViewController:abc animated:YES completion:nil];
    }
    else {
        OffersViewController *abc = [storyboard instantiateViewControllerWithIdentifier:@"offer"];
        if(_isFiltered == NO) {
            abc._data = _data;
        }
        else {
            abc._data = _filteredItems;
        }
        [self presentViewController:abc animated:YES completion:nil];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.transform=CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:(void (^)(void)) ^{
                         cell.transform=CGAffineTransformMakeScale(1.0, 1.0);
                     }
                     completion:^(BOOL finished){
                         cell.transform=CGAffineTransformIdentity;
                     }];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        return 500; /* Device is iPad */
    }
    else {
        return 450;
    }
    return 450;
    
}
-(void)readTopScorePlist
{
   // _data = [[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:OffersPlistLocation]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    NSLog(@"Changed");
    
    if(text.length == 0)
    {
        _isFiltered = NO;
        [_filteredItems removeAllObjects];
        [_searchItems removeAllObjects];
        [_tableView reloadData];
        [self updateContent];
        tempIndex = 0;
    }
    else {
        NSLog(@"%li",[_searchItems count]);
        tempIndex = 0;
        [_filteredItems removeAllObjects];
        for (int i=0; i<[_searchItems count]; i++) {
            
            
            if ([[_searchItems objectAtIndex:i] rangeOfString:text options: NSCaseInsensitiveSearch].location != NSNotFound) {
                NSLog(@"Found: %@ : %@",text,[_searchItems objectAtIndex:i]);
                [_filteredItems setObject:[_data valueForKey:[NSString stringWithFormat:@"%i",i]] forKey:[NSString stringWithFormat:@"%i",tempIndex]];
                _isFiltered = YES;
                [_tableView reloadData];
                tempIndex++;
            }
        }
    }
}
@end

@implementation TimeLineCell

@synthesize  ttitle, cellImage, cellBackground, changeButton, deleteButton, detailText,date, dateTo,priceLabel;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        
        ttitle.numberOfLines = 30;
        ttitle.lineBreakMode = NSLineBreakByCharWrapping;
        ttitle.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:ttitle];
        [self setAutoresizesSubviews:YES];
        
    }
    return self;
}

@end
