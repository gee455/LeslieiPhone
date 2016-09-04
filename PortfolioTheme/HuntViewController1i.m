//
//  HuntViewController.m
//  PortfolioTheme
//
//  Created by Calvin Gee on 3/12/16.
//  Copyright © 2016 Viktor Todorov. All rights reserved.
//

#import "HuntViewController1.h"
#import "MobileBuilder.h"
#import "Strings.h"
#define kTintColorHex @"#AA0000"
#import "UIColor+MBWPExtensions.h"

@interface HuntViewController1 ()
@property (weak, nonatomic) IBOutlet UIView *Content;

@end

@implementation HuntViewController1

@synthesize scrollView = _scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:kTintColorHex];
    
    self.title = @"Scavenger Hunter";
    
    //self.navigationItem.leftBarButtonItem = _sidebarButton;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self.revealViewController action:@selector(revealToggle:)];
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.scrollView addSubview:self.Content];
    
    // Tell the scroll view the size of the contents
    self.scrollView.contentSize = CGSizeMake(720.0, 2000.0);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self.segControl setSelectedSegmentIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"segControl"]];
    [self.segControl1 setSelectedSegmentIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"segControl1"]];
    [self.segControl2 setSelectedSegmentIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"segControl2"]];
    [self.segControl3 setSelectedSegmentIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"segControl3"]];
    [self.segControl4 setSelectedSegmentIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"segControl4"]];
    [self.segControl5 setSelectedSegmentIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"segControl5"]];
    [self.segControl6 setSelectedSegmentIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"segControl6"]];
    [self.segControl7 setSelectedSegmentIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"segControl7"]];
    [self.segControl8 setSelectedSegmentIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"segControl8"]];
    [self.segControl9 setSelectedSegmentIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"segControl9"]];
    
}

- (IBAction)changeState1:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:[sender selectedSegmentIndex] forKey:@"segControl"];
}
- (IBAction)changeState2:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:[sender selectedSegmentIndex] forKey:@"segControl1"];
}
- (IBAction)changeState3:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:[sender selectedSegmentIndex] forKey:@"segControl2"];
}
- (IBAction)changeState4:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:[sender selectedSegmentIndex] forKey:@"segControl3"];
}
- (IBAction)changeState5:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:[sender selectedSegmentIndex] forKey:@"segControl4"];
}
- (IBAction)changeState6:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:[sender selectedSegmentIndex] forKey:@"segControl5"];
}
- (IBAction)changeState7:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:[sender selectedSegmentIndex] forKey:@"segControl6"];
}
- (IBAction)changeState8:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:[sender selectedSegmentIndex] forKey:@"segControl7"];
}
- (IBAction)changeState9:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:[sender selectedSegmentIndex] forKey:@"segControl8"];
}
- (IBAction)changeState10:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:[sender selectedSegmentIndex] forKey:@"segControl9"];
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
