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

#import "BKTPopinControllerViewController13i.h"

#import "UIViewController+MaryPopin.h"

//#import "SWRevealViewController.h"
#import "SCLAlertView.h"

//Popin Content
#import "BKTPopin2ControllerViewController_critter1.h"
#import "BKTPopin2ControllerViewController_critter2.h"
#import "BKTPopin2ControllerViewController_critter3.h"
#import "BKTPopin2ControllerViewController_critter4.h"
#import "BKTPopin2ControllerViewController_unlock1i.h"
#import "BKTPopin2ControllerViewController_unlock2.h"

//Feature Pop-in Content
#import "BKTPopinControllerViewControllerUnlock1i.h"
#import "BKTPopinControllerViewControllerUnlock2i.h"
#import "BKTPopinControllerViewControllerCritter1i.h"
#import "BKTPopinControllerViewControllerCritter2i.h"
#import "BKTPopinControllerViewControllerCritter3i.h"
#import "BKTPopinControllerViewControllerCritter4i.h"

@interface BKTPopinControllerViewController13i ()
@property (nonatomic, strong) UIImageView *imageView;

- (IBAction)closeButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIView *Content;


@end


@implementation BKTPopinControllerViewController13i


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
  
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_scrollView setScrollEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(320, 2138)];
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

- (IBAction)presentPopinPressed1:(id)sender
{
    BKTPopinControllerViewControllerCritter1i *popin = [[BKTPopinControllerViewControllerCritter1i alloc] init];
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
    BKTPopinControllerViewControllerCritter2i *popin = [[BKTPopinControllerViewControllerCritter2i alloc] init];
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
    BKTPopinControllerViewControllerCritter3i *popin = [[BKTPopinControllerViewControllerCritter3i alloc] init];
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
    BKTPopinControllerViewControllerCritter4i *popin = [[BKTPopinControllerViewControllerCritter4i alloc] init];
    //Disable auto dismiss and removed semi-transparent background
    [popin setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
    
    //Configure transition direction
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
}

- (IBAction)presentPopinPressed5:(id)sender
{
    BKTPopinControllerViewControllerUnlock1i *popin = [[BKTPopinControllerViewControllerUnlock1i alloc] init];
    //Disable auto dismiss and removed semi-transparent background
    [popin setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
    
    //Configure transition direction
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
}

- (IBAction)presentPopinPressed6:(id)sender
{
    BKTPopinControllerViewControllerUnlock2i *popin = [[BKTPopinControllerViewControllerUnlock2i alloc] init];
    //Disable auto dismiss and removed semi-transparent background
    [popin setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
    
    //Configure transition direction
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
}



@end
