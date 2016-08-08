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

#import "BKTPopin2ControllerViewController_QR2.h"
#import "BKTPopin2ControllerViewController_QR2_answer.h"
#import "Strings.h"
//Pop In
#import "UIViewController+MaryPopin.h"


@interface BKTPopin2ControllerViewController_QR2  ()

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation BKTPopin2ControllerViewController_QR2

- (void) viewDidLoad{
    
    //QR Code
    // Initially make the captureSession object nil.
    _captureSession = nil;
    
    // Begin loading the sound effect so to have it ready for playback when it's needed.
    NSError *error;
    
    // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
    // as the media type parameter.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        // If any error occurs, simply log the description of it and don't continue any more.
        NSLog(@"%@", [error localizedDescription]);
    }
    
    // Initialize the captureSession object.
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
    
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //Array of QR Code Object Types
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    // Start video capture.
    [_captureSession startRunning];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [_captureSession stopRunning];
}

-(void)popinMethod:(id)qrCode {
    //BKTPopinControllerViewController *popin = [[BKTPopinControllerViewController alloc] init];
    
    // BKTPopinControllerViewController2 *popin1 = [[BKTPopinControllerViewController2 alloc] init];
    
    if ([qrCode isEqual: @"b"]) {
        
        BKTPopin2ControllerViewController_QR2_answer *popin1 = [[BKTPopin2ControllerViewController_QR2_answer alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
        
    };
};

-(void)stopReading{
    // Stop video capture and make the capture session object nil.
    [_captureSession stopRunning];
}

-(void)handleMetadata:(id)metadata {
    NSString *qrCode = [metadata stringValue];
    
    
    //[self popinMethod];
    
    [self performSelectorOnMainThread:@selector(popinMethod:) withObject:qrCode waitUntilDone:NO];
    
    // Start video capture.
    [_captureSession startRunning];
    
    
    NSLog(@"%@", qrCode);
}



#pragma mark - AVCaptureMetadataOutputObjectsDelegate method implementation

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        // Get the metadata object.
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            [self performSelectorOnMainThread:@selector(handleMetadata:) withObject:metadataObj waitUntilDone:NO];
            
        }
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}



@end
