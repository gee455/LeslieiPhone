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

#import "BKTPopin2ControllerViewController_QR3i_answer.h"
#import "BKTPopin2ControllerViewController_QR1_answer.h"
#import <AudioToolbox/AudioToolbox.h>
#import "UIViewController+MaryPopin.h"

//#import "SWRevealViewController.h"
#import "SCLAlertView.h"

@interface BKTPopin2ControllerViewController_QR3i_answer ()
@property (nonatomic, strong) UIImageView *imageView;

- (IBAction)closeButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIView *Content;
//QR Code Reader
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;


@end


@implementation BKTPopin2ControllerViewController_QR3i_answer


@synthesize scrollView = _scrollView;

@synthesize imageView = _imageView;





- (void)viewDidLoad {
   
     [self playMovie];
    
    [self.scrollView addSubview:self.Content];
    
    // Tell the scroll view the size of the contents
   // self.scrollView.contentSize = image.size;
  
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_scrollView setScrollEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(320, 479)];
}

-(void)viewDidAppear:(BOOL)animated{
    
    // Start video capture.
    [_captureSession startRunning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_captureSession stopRunning];
}
- (void) playMovie {
    
    NSString*thePath=[[NSBundle mainBundle] pathForResource:@"Eagle" ofType:@"mp4"];
    NSURL*theurl=[NSURL fileURLWithPath:thePath];
    MPMoviePlayerController *controller = [[MPMoviePlayerController alloc]
                                           initWithContentURL:theurl];
    
    self.mc = controller; //Super important
    controller.view.frame =  CGRectMake(355, 175, 350, 194);//Set the size
    
    
    [self.view addSubview:controller.view]; //Show the view
    [controller play]; //Start playing
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(IBAction)buttonPressedWithSound:(id)sender {
    
    int randomSoundNumber = arc4random() % 1; //random number from 0 to 3
    
    NSLog(@"random sound number = %i", randomSoundNumber);
    
    NSString *effectTitle;
    
    switch (randomSoundNumber) {
        case 0:
            effectTitle = @"owl";
            break;
            
        default:
            break;
    }
    
    SystemSoundID soundID;
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:effectTitle ofType:@"wav"];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)soundUrl, &soundID);
    AudioServicesPlaySystemSound(soundID);
}




- (IBAction)closeButtonPressed:(id)sender {
    [self.presentingPopinViewController dismissCurrentPopinControllerAnimated:YES completion:^{
        NSLog(@"Popin dismissed !");
    }];
}


@end
