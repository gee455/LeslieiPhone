//
//  SideBarViewController.m
//  PortfolioTheme
//
//  Created by Viktor Todorov on 9/1/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import "SideBarViewController.h"
#import "PortfolioViewController.h"
#import "SWRevealViewController.h"
#import "AboutViewController.h"
#import "CollectionViewController.h"
#import "ProductsViewController.h"
#import "BlogPostViewController.h"
//Custom Content Class
#import "CritterViewController.h"

@interface SideBarViewController ()

@end

@implementation SideBarViewController

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
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0)
    {
        NSLog(@"Path: %@", [paths objectAtIndex:0]);
        
        NSError *error = nil;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // Remove all files in the documents directory
        BOOL deleted = [fileManager removeItemAtPath:[paths objectAtIndex:0] error:&error];
        
        if (deleted != YES || error != nil)
        {
            // Deal with the error...
        }
        else
            // Recreate the Documents directory
            [fileManager createDirectoryAtPath:[paths objectAtIndex:0] withIntermediateDirectories:NO attributes:nil error:&error];
        
    }
    
    
    // Do any additional setup after loading the view.
    [_tableView setDelegate:self];
    self.view.backgroundColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor clearColor];
    _logo.layer.cornerRadius = 45;
    _logo.clipsToBounds = YES;
    
    [self readTopScorePlist];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSString *row = [NSString stringWithFormat:@"%li",(long)indexPath.row];
    GetMoreTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSMutableDictionary *menu = [_data valueForKey:row];
    
    if (cell == nil) {
        cell = [[GetMoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.ttitle.text = [[_data valueForKey:row] valueForKey:@"Name"];
    CALayer * l = [cell.cellImage layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:10.0];
    
    CALayer * b = [cell.cellBackground layer];
    [b setMasksToBounds:YES];
    [b setCornerRadius:19.0];
    cell.cellImage.image = [UIImage imageNamed:[menu valueForKey:@"Image"]];
    cell.cellImage.alpha = 0.8;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        return 60; /* Device is iPad */
    }
    else {
        return 50;
    }
    return 50;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetMoreTableViewCell *cell = (GetMoreTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:36/255.0
                                                      green:38/255.0
                                                       blue:44/255.0
                                                      alpha:1.0];
    cell.selectedBackgroundView =  customColorView;
    cell.ttitle.textColor = [UIColor colorWithRed:96.f/255.f green:133.f/255.f blue:178.f/255.f alpha:1];
    
    SWRevealViewController *revealController = self.revealViewController;
    // Set the title of navigation bar by using the menu items
    [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    NSInteger row = indexPath.row;
    
    UIViewController *newFrontController = nil;
    
    if (row == 0)
    {
        UIStoryboard *storyboard = self.storyboard;
        newFrontController = [storyboard instantiateViewControllerWithIdentifier:@"main"];
    }
    else if(row == 1)
    {
        UIStoryboard *storyboard = self.storyboard;
        newFrontController = [storyboard instantiateViewControllerWithIdentifier:@"about"];
    }
    else if(row == 2)
    {
        UIStoryboard *storyboard = self.storyboard;
        newFrontController = [storyboard instantiateViewControllerWithIdentifier:@"contact"];
    }
    else if(row == 3)
    {
        UIStoryboard *storyboard = self.storyboard;
        ProductsViewController *svc = [storyboard instantiateViewControllerWithIdentifier:@"Critter2"];
        newFrontController = svc;
    }
    else if(row == 4)
    {
        UIStoryboard *storyboard = self.storyboard;
        ProductsViewController *svc = [storyboard instantiateViewControllerWithIdentifier:@"blog"];
        newFrontController = svc;
    }
    else if(row == 5)
    {
        UIStoryboard *storyboard = self.storyboard;
        ProductsViewController *svc = [storyboard instantiateViewControllerWithIdentifier:@"ScavengerChoose"];
        newFrontController = svc;
    }
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
    [revealController pushFrontViewController:navigationController animated:YES];

    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    GetMoreTableViewCell *cell = (GetMoreTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    //cell.backgroundColor = [UIColor clearColor];
    cell.ttitle.textColor = [UIColor whiteColor];
}

-(void)readTopScorePlist
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"sidebar.plist"]; //3
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath: path]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"sidebar" ofType:@"plist"]; //5
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
    }
    _data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    NSLog(@"%@",_data);
}


@end

@implementation GetMoreTableViewCell

@synthesize  ttitle, cellImage, cellBackground, changeButton, deleteButton;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        
        ttitle.textColor = [UIColor whiteColor];
        ttitle.numberOfLines = 30;
        ttitle.lineBreakMode = NSLineBreakByCharWrapping;
        ttitle.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:ttitle];
        [self setAutoresizesSubviews:YES];
        
    }
    return self;
}

@end
