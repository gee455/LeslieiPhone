//
// The MIT License (MIT)
//
// Copyright (c) 2013 Backelite
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "BKTPopinControllerViewControllerFeature1i.h"

#import "UIViewController+MaryPopin.h"

//#import "SWRevealViewController.h"
#import "SCLAlertView.h"

@interface BKTPopinControllerViewControllerFeature1i ()
@property (nonatomic, strong) UIImageView *imageView;

- (IBAction)closeButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIView *Content;


@end


@implementation BKTPopinControllerViewControllerFeature1i


@synthesize scrollView = _scrollView;

@synthesize imageView = _imageView;





- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    // Set a nice title
    self.title = @"Image";
    
    // Set up the image we want to scroll & zoom and add it to the scroll view
    UIImage *image = [UIImage imageNamed:@"leslieHouse.png"]; //size of image we're using from PSD
//    self.imageView = [[UIImageView alloc] initWithImage:image];
//    self.imageView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=image.size};
    
    
    
    [self.scrollView addSubview:self.Content];
    
    // Tell the scroll view the size of the contents
    self.scrollView.contentSize = image.size;
    
    [self playMovie];
  
}

- (void) playMovie {
    
    NSString*thePath=[[NSBundle mainBundle] pathForResource:@"RaptorVideo" ofType:@"mov"];
    NSURL*theurl=[NSURL fileURLWithPath:thePath];
    MPMoviePlayerController *controller = [[MPMoviePlayerController alloc]
                                           initWithContentURL:theurl];
    
    self.mc = controller; //Super important
    controller.view.frame =  CGRectMake(0, 71, 318, 169);//Set the size
    
    
    [self.scrollView addSubview:controller.view]; //Show the view
    [controller play]; //Start playing
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_scrollView setScrollEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(320, 682)];
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


- (IBAction)closeButtonPressed:(id)sender {
    [self.presentingPopinViewController dismissCurrentPopinControllerAnimated:YES completion:^{
        NSLog(@"Popin dismissed !");
    }];
}


@end
