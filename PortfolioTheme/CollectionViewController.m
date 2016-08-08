//
//  CollectionViewController.m
//  PortfolioTheme
//
//  Created by Viktor Todorov on 9/2/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import "CollectionViewController.h"
#import "UIKit+AFNetworking.h"
#import "SubProductsViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

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
    // Do any additional setup after loading the view.
     self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithRed:36/255.0
                                                green:38/255.0
                                                 blue:44/255.0
                                                alpha:1.0];

    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView setDelegate:self];
    _tableView.separatorColor = [UIColor clearColor];
    //_data = [NSMutableDictionary new];
    [self readTopScorePlist];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSString *row = [NSString stringWithFormat:@"%li",(long)indexPath.row];
    CollectionCellClass *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    if (cell == nil) {
        cell = [[CollectionCellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.ttitle.text = [[_data valueForKey:row] valueForKey:@"Name"];
    CALayer * b = [cell.cellBackground layer];
    [b setMasksToBounds:YES];

    [cell.cellBackground setImageWithURL:[NSURL URLWithString:[[_data valueForKey:row] valueForKey:@"Image"]] placeholderImage:[UIImage imageNamed:@"loadingSign.jpg"]];
    cell.cellBackground.alpha = 1;
    

    return cell;
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
    
    [[NSUserDefaults standardUserDefaults]setInteger:indexPath.row forKey:@"subNumber"];
    UIStoryboard *storyboard = self.storyboard;
    SubProductsViewController *abc = [storyboard instantiateViewControllerWithIdentifier:@"sub"];
    abc._data = _data;
    [self presentViewController:abc animated:YES completion:nil];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        return 260; /* Device is iPad */
    }
    else {
        return 160;
    }
    return 160;
    
}
-(void)readTopScorePlist
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Collection.plist"]; //3
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath: path]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"Collection" ofType:@"plist"]; //5
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
    }
    _data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    NSLog(@"%@",_data);
}

@end
@implementation CollectionCellClass

@synthesize  ttitle, cellBackground;

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
- (void)setFrame:(CGRect)frame {
    frame.origin.y += 4;
    frame.size.height -= 2 * 4;
    [super setFrame:frame];
}
@end