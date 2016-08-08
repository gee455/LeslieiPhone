//
//  GalleryViewController.m
//  PortfolioTheme
//
//  Created by Viktor Todorov on 10/14/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import "GalleryViewController.h"
#import "PhotoViewController.h"
#import "UIKit+AFNetworking.h"

@interface GalleryViewController ()

@end

@implementation GalleryViewController
@synthesize _source;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _collection.delegate = self;
    _collection.backgroundColor = [UIColor clearColor];
    _images = [NSMutableArray new];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(goBack:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
}
-(void)goBack: (UIGestureRecognizer*)recognizer {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSString* theRow = [NSString stringWithFormat:@"%li",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"offerNumber"]];
    
    return [[[_source valueForKey:theRow] valueForKey:@"Photos"] count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSString* row = [NSString stringWithFormat:@"%li",(long)indexPath.row];
    NSString* theRow = [NSString stringWithFormat:@"%li",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"offerNumber"]];
    NSLog(@"Row: %@",row);
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.layer.masksToBounds = YES;
    recipeImageView.layer.cornerRadius = 40;
    
    CALayer * l = [recipeImageView layer];
    [l setMasksToBounds:YES];
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
       [l setCornerRadius:90];
    }
    else {
       [l setCornerRadius:40];
    }
    
    
    CALayer * b = [recipeImageView layer];
    [b setMasksToBounds:YES];
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        [b setCornerRadius:90];
    }
    else {
        [b setCornerRadius:40];
    }
    [recipeImageView setImageWithURL:[NSURL URLWithString:[[[_source valueForKey:theRow] valueForKey:@"Photos"] valueForKey:row]] placeholderImage:[UIImage imageNamed:@"loadingSign.jpg"]];
    
    [_images addObject:recipeImageView];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle.png"]];
    cell.layer.cornerRadius = 25;
    cell.backgroundView.alpha = 0.6;
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
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
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    NSString* row = [NSString stringWithFormat:@"%li",(long)indexPath.row];
    NSString* theRow = [NSString stringWithFormat:@"%li",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"offerNumber"]];
    [recipeImageView setImageWithURL:[NSURL URLWithString:[[[_source valueForKey:theRow] valueForKey:@"Photos"] valueForKey:row]] placeholderImage:[UIImage imageNamed:@"loadingSign.jpg"]];
    
    UIStoryboard *storyboard = self.storyboard;
    PhotoViewController* abc = [storyboard instantiateViewControllerWithIdentifier:@"photo"];
    abc.image = recipeImageView;
    [self presentViewController:abc animated:YES completion:nil];
}
@end
