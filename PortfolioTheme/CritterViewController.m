//
//  CritterViewController.m
//  PortfolioTheme
//
//  Created by Calvin Gee on 11/8/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import "CritterViewController.h"
#import "SWRevealViewController.h"
#import "SCLAlertView.h"
//Popin
#import "BKTPopin2ControllerViewController.h"
#import "UIViewController+MaryPopin.h"

#import "BKTPopin2ControllerViewController_feature1.h"
#import "BKTPopin2ControllerViewController_feature2.h"
#import "BKTPopin2ControllerViewController_feature3.h"
#import "BKTPopin2ControllerViewController_feature4.h"

#define kTintColorHex @"#AA0000"
#import "UIColor+MBWPExtensions.h"

@interface CritterViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIView *Content;
- (void)centerScrollViewContents;
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer;
- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer;

@end

NSString *kSuccessTitle = @"Good Job!";
NSString *kSubtitle = @"You found the mouse! Great observation skills!";
NSString *kButtonTitle = @"Done";

@implementation CritterViewController


@synthesize scrollView = _scrollView;

@synthesize imageView = _imageView;




- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    // Get the location within the image view where we tapped
    CGPoint pointInView = [recognizer locationInView:self.imageView];
    
    // Get a zoom scale that's zoomed in slightly, capped at the maximum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
    
    // Figure out the rect we want to zoom to, then zoom to it
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    [self.scrollView zoomToRect:rectToZoomTo animated:YES];
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(768, 1224)];
    
    
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:kTintColorHex];
    
    self.title = @"Leslie Science & Nature Center";
    
    //self.navigationItem.leftBarButtonItem = _sidebarButton;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self.revealViewController action:@selector(revealToggle:)];
    
    self.navigationController.navigationBar.translucent = YES;

    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    
    
    // Set a nice title
    //self.title = @"Image";
    
    // Set up the image we want to scroll & zoom and add it to the scroll view
    UIImage *image = [UIImage imageNamed:@"features.png"]; //size of image we're using from PSD
    //    self.imageView = [[UIImageView alloc] initWithImage:image];
    //    self.imageView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=image.size};
    
    
    
    [self.scrollView addSubview:self.Content];
    
    // Tell the scroll view the size of the contents
    self.scrollView.contentSize = image.size;
    
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.scrollView addGestureRecognizer:twoFingerTapRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set up the minimum & maximum zoom scales
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1.0f;
    self.scrollView.zoomScale = minScale;
    
    [self centerScrollViewContents];
}


- (IBAction)presentPopinPressed1:(id)sender
{
    BKTPopin2ControllerViewController_feature1 *popin = [[BKTPopin2ControllerViewController_feature1 alloc] init];
    //Disable auto dismiss and removed semi-transparent background
    [popin setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
    
    //Configure transition direction
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
}

- (IBAction)presentPopinPressed2:(id)sender
{
    BKTPopin2ControllerViewController_feature2 *popin = [[BKTPopin2ControllerViewController_feature2 alloc] init];
    //Disable auto dismiss and removed semi-transparent background
    [popin setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
    
    //Configure transition direction
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
}

- (IBAction)presentPopinPressed3:(id)sender
{
    BKTPopin2ControllerViewController_feature3 *popin = [[BKTPopin2ControllerViewController_feature3 alloc] init];
    //Disable auto dismiss and removed semi-transparent background
    [popin setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
    
    //Configure transition direction
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
}

- (IBAction)presentPopinPressed4:(id)sender
{
    BKTPopin2ControllerViewController_feature4 *popin = [[BKTPopin2ControllerViewController_feature4 alloc] init];
    //Disable auto dismiss and removed semi-transparent background
    [popin setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
    
    //Configure transition direction
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that we want to zoom
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}




- (IBAction)presentPopinPressed:(id)sender
{
    BKTPopin2ControllerViewController *popin = [[BKTPopin2ControllerViewController alloc] init];
    //Disable auto dismiss and removed semi-transparent background
    [popin setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
    
    //Configure transition direction
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
