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

#import "BKTPopinControllerViewControllerFeatures.h"
#import "Strings.h"
#import "UIViewController+MaryPopin.h"

#import "SWRevealViewController.h"
#import "SCLAlertView.h"

@interface BKTPopinControllerViewControllerFeatures ()
@property (nonatomic, strong) UIImageView *imageView;

- (void)centerScrollViewContents;
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer;
- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer;

- (IBAction)closeButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end


@implementation BKTPopinControllerViewControllerFeatures


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
    self.navigationController.navigationBar.hidden = YES;
    
    // Set a nice title
    self.title = @"Image";
    
    // Set up the image we want to scroll & zoom and add it to the scroll view
    UIImage *image = [UIImage imageNamed:@"photo1.png"];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=image.size};
    [self.scrollView addSubview:self.imageView];
    
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
    
//    _youTubeBackground.userInteractionEnabled = YES;
//    [_youTubeBackground setMediaPlaybackRequiresUserAction:YES];
//    _youTubeBackground.allowsInlineMediaPlayback=YES;
//    //_youTubeBackground.scrollView.scrollEnabled = NO;
//    if(enableHistoryVideo == YES) {
//        [self playVideoWithId:invertVideo];
//    }
//    
//    _youTubeBackground1.userInteractionEnabled = YES;
//    [_youTubeBackground1 setMediaPlaybackRequiresUserAction:YES];
//    _youTubeBackground1.allowsInlineMediaPlayback=YES;
//    //_youTubeBackground1.scrollView.scrollEnabled = NO;
//    if(enableHistoryVideo == YES) {
//        [self playVideoWithId1:invertVideo];
//    }
//
//    
//    
//    _youTubeBackground2.userInteractionEnabled = YES;
//    [_youTubeBackground2 setMediaPlaybackRequiresUserAction:YES];
//    _youTubeBackground2.allowsInlineMediaPlayback=YES;
//    //_youTubeBackground2.scrollView.scrollEnabled = NO;
//    if(enableHistoryVideo == YES) {
//        [self playVideoWithId2:invertVideo];
//    }

    
}


- (void) playMovie1 {
    
    NSString*thePath=[[NSBundle mainBundle] pathForResource:@"History" ofType:@"mp4"];
    NSURL*theurl=[NSURL fileURLWithPath:thePath];
    MPMoviePlayerController *controller = [[MPMoviePlayerController alloc]
                                           initWithContentURL:theurl];
    
    self.mc = controller; //Super important
    controller.view.frame =  CGRectMake(100, 55, 500, 360);//Set the size
    
    
    [self.view addSubview:controller.view]; //Show the view
    [controller play]; //Start playing
}

- (void) playMovie2 {
    
    NSString*thePath=[[NSBundle mainBundle] pathForResource:@"History" ofType:@"mp4"];
    NSURL*theurl=[NSURL fileURLWithPath:thePath];
    MPMoviePlayerController *controller = [[MPMoviePlayerController alloc]
                                           initWithContentURL:theurl];
    
    self.mc = controller; //Super important
    controller.view.frame =  CGRectMake(100, 55, 500, 360);//Set the size
    
    
    [self.view addSubview:controller.view]; //Show the view
    [controller play]; //Start playing
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

- (void)playVideoWithId:(NSString *)videoId {
    
    NSString* embedHTML;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        embedHTML = [NSString stringWithFormat:@"\
                     <html>\
                     <body style='margin:0px;padding:0px;'>\
                     <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
                     <script type='text/javascript'>\
                     function onYouTubeIframeAPIReady()\
                     {\
                     ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
                     }\
                     function onPlayerReady(a)\
                     { \
                     a.target.playVideo(); \
                     }\
                     </script>\
                     <iframe id='playerId' type='text/html' width='%d' height='%d' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'>\
                     </body>\
                     </html>", 640, 360, invertVideo];
        
        
    }
    else {
        embedHTML = [NSString stringWithFormat:@"\
                     <html>\
                     <body style='margin:0px;padding:0px;'>\
                     <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
                     <script type='text/javascript'>\
                     function onYouTubeIframeAPIReady()\
                     {\
                     ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
                     }\
                     function onPlayerReady(a)\
                     { \
                     a.target.playVideo(); \
                     }\
                     </script>\
                     <iframe id='playerId' type='text/html' width='%d' height='%d' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'>\
                     </body>\
                     </html>", 320, 250, invertVideo];
    }
    
    
    NSString *html = [NSString stringWithFormat:embedHTML, videoId];
    
    _youTubeBackground.backgroundColor = [UIColor clearColor];
    _youTubeBackground.opaque = NO;
    //videoView.delegate = self;
    
    _youTubeBackground.mediaPlaybackRequiresUserAction = NO;
    
    [_youTubeBackground loadHTMLString:html baseURL:[[NSBundle mainBundle] resourceURL]];
}

- (void)playVideoWithId1:(NSString *)videoId {
    
    NSString* embedHTML;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        embedHTML = [NSString stringWithFormat:@"\
                     <html>\
                     <body style='margin:0px;padding:0px;'>\
                     <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
                     <script type='text/javascript'>\
                     function onYouTubeIframeAPIReady()\
                     {\
                     ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
                     }\
                     function onPlayerReady(a)\
                     { \
                     a.target.playVideo(); \
                     }\
                     </script>\
                     <iframe id='playerId' type='text/html' width='%d' height='%d' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'>\
                     </body>\
                     </html>", 640, 360, invertVideo];
        
        
    }
    else {
        embedHTML = [NSString stringWithFormat:@"\
                     <html>\
                     <body style='margin:0px;padding:0px;'>\
                     <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
                     <script type='text/javascript'>\
                     function onYouTubeIframeAPIReady()\
                     {\
                     ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
                     }\
                     function onPlayerReady(a)\
                     { \
                     a.target.playVideo(); \
                     }\
                     </script>\
                     <iframe id='playerId' type='text/html' width='%d' height='%d' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'>\
                     </body>\
                     </html>", 320, 250, invertVideo];
    }
    
    
    NSString *html = [NSString stringWithFormat:embedHTML, videoId];
    
    _youTubeBackground.backgroundColor = [UIColor clearColor];
    _youTubeBackground.opaque = NO;
    //videoView.delegate = self;
    
    _youTubeBackground.mediaPlaybackRequiresUserAction = NO;
    
    [_youTubeBackground loadHTMLString:html baseURL:[[NSBundle mainBundle] resourceURL]];
}


- (void)playVideoWithId2:(NSString *)videoId {
    
    NSString* embedHTML;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        embedHTML = [NSString stringWithFormat:@"\
                     <html>\
                     <body style='margin:0px;padding:0px;'>\
                     <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
                     <script type='text/javascript'>\
                     function onYouTubeIframeAPIReady()\
                     {\
                     ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
                     }\
                     function onPlayerReady(a)\
                     { \
                     a.target.playVideo(); \
                     }\
                     </script>\
                     <iframe id='playerId' type='text/html' width='%d' height='%d' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'>\
                     </body>\
                     </html>", 640, 360, invertVideo];
        
        
    }
    else {
        embedHTML = [NSString stringWithFormat:@"\
                     <html>\
                     <body style='margin:0px;padding:0px;'>\
                     <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
                     <script type='text/javascript'>\
                     function onYouTubeIframeAPIReady()\
                     {\
                     ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
                     }\
                     function onPlayerReady(a)\
                     { \
                     a.target.playVideo(); \
                     }\
                     </script>\
                     <iframe id='playerId' type='text/html' width='%d' height='%d' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'>\
                     </body>\
                     </html>", 320, 250, invertVideo];
    }
    
    
    NSString *html = [NSString stringWithFormat:embedHTML, videoId];
    
    _youTubeBackground.backgroundColor = [UIColor clearColor];
    _youTubeBackground.opaque = NO;
    //videoView.delegate = self;
    
    _youTubeBackground.mediaPlaybackRequiresUserAction = NO;
    
    [_youTubeBackground loadHTMLString:html baseURL:[[NSBundle mainBundle] resourceURL]];
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



- (IBAction)closeButtonPressed:(id)sender {
    [self.presentingPopinViewController dismissCurrentPopinControllerAnimated:YES completion:^{
        NSLog(@"Popin dismissed !");
    }];
}



- (IBAction)showSuccess:(id)sender
{
    
    NSString *kSuccessTitle = @"Good Job!";
    NSString *kSubtitle = @"You found the mouse! Great observation skills!";
    NSString *kButtonTitle = @"Done";
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    //    SCLButton *button = [alert addButton:@"First Button" target:self selector:@selector(firstButton)];
    //
    //    button.layer.borderWidth = 2.0f;
    //
    //    button.buttonFormatBlock = ^NSDictionary* (void)
    //    {
    //        NSMutableDictionary *buttonConfig = [[NSMutableDictionary alloc] init];
    //
    //        [buttonConfig setObject:[UIColor whiteColor] forKey:@"backgroundColor"];
    //        [buttonConfig setObject:[UIColor blackColor] forKey:@"textColor"];
    //        [buttonConfig setObject:[UIColor greenColor] forKey:@"borderColor"];
    //
    //        return buttonConfig;
    //    };
    
    //    [alert addButton:@"Second Button" actionBlock:^(void) {
    //        NSLog(@"Second button tapped");
    //    }];
    
    alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/right_answer.mp3", [[NSBundle mainBundle] resourcePath]]];
    
    [alert showSuccess:self title:kSuccessTitle subTitle:kSubtitle closeButtonTitle:kButtonTitle duration:0.0f];
}


- (void)firstButton
{
    NSLog(@"First button tapped");
}

@end