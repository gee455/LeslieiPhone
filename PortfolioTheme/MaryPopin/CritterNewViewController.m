//
//  HuntViewController.m
//  PortfolioTheme
//
//  Created by Calvin Gee on 3/12/16.
//  Copyright © 2016 Viktor Todorov. All rights reserved.
//

#import "CritterNewViewController.h"
#import "MobileBuilder.h"
#import "Strings.h"
#define kTintColorHex @"#AA0000"
#import "UIColor+MBWPExtensions.h"
#import "BKTPopinControllerViewControllerFeature1i.h"
#import "BKTPopinControllerViewControllerFeature2i.h"
#import "BKTPopinControllerViewControllerFeature3i.h"
#import "BKTPopinControllerViewControllerFeature4i.h"

#import "SWRevealViewController.h"

//Popin
#import "BKTPopin2ControllerViewController.h"
#import "UIViewController+MaryPopin.h"

@interface CritterNewViewController ()
@property (weak, nonatomic) IBOutlet UIView *Content;

@end

@implementation CritterNewViewController

@synthesize scrollView = _scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:kTintColorHex];
    
    self.title = @"Main Features";
    
    //self.navigationItem.leftBarButtonItem = _sidebarButton;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self.revealViewController action:@selector(revealToggle:)];
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.scrollView addSubview:self.Content];
    
    
    #define IDIOM    UI_USER_INTERFACE_IDIOM()
    #define IPAD     UIUserInterfaceIdiomPad
    
    if ( IDIOM == IPAD ) {
        /* do something specifically for iPad. */
        
        // Tell the scroll view the size of the contents
        self.scrollView.contentSize = CGSizeMake(720.0, 2000.0);
        
    } else {
        /* do something specifically for iPhone or iPod touch. */
        
        // Tell the scroll view the size of the contents
        self.scrollView.contentSize = CGSizeMake(320.0, 1780);
    }

    
    
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:kTintColorHex];
    
    self.title = @"Features";
    
    //self.navigationItem.leftBarButtonItem = _sidebarButton;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self.revealViewController action:@selector(revealToggle:)];
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
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

}

- (IBAction)presentPopinPressed1:(id)sender
{
    BKTPopinControllerViewControllerFeature1i *popin = [[BKTPopinControllerViewControllerFeature1i alloc] init];
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
    BKTPopinControllerViewControllerFeature2i *popin = [[BKTPopinControllerViewControllerFeature2i alloc] init];
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
    BKTPopinControllerViewControllerFeature3i *popin = [[BKTPopinControllerViewControllerFeature3i alloc] init];
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
    BKTPopinControllerViewControllerFeature4i *popin = [[BKTPopinControllerViewControllerFeature4i alloc] init];
    //Disable auto dismiss and removed semi-transparent background
    [popin setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
    
    //Configure transition direction
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
