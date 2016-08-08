//
//  AboutViewController.m
//  PortfolioTheme
//
//  Created by Viktor Todorov on 9/2/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import "AboutViewController.h"
#import "MobileBuilder.h"
#import "Strings.h"
#define kTintColorHex @"#AA0000"
#import "UIColor+MBWPExtensions.h"
//Popin
#import "BKTPopin2ControllerViewController_about2.h"
#import "BKTPopin2ControllerViewController_about1.h"
#import "BKTPopin2ControllerViewController.h"
#import "UIViewController+MaryPopin.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:kTintColorHex];

    self.title = @"Leslie Science & Nature Center";
    
    //self.navigationItem.leftBarButtonItem = _sidebarButton;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self.revealViewController action:@selector(revealToggle:)];
    
    self.navigationController.navigationBar.translucent = YES;

    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    _name.center = CGPointMake(_name.center.x, _name.center.y - 1000);
    _subTitle.center = CGPointMake(_subTitle.center.x, _subTitle.center.y - 1000);
   // _youTubeBackground.center = CGPointMake(_youTubeBackground.center.x, _youTubeBackground.center.y+2000);
    _mainText.center = CGPointMake(_mainText.center.x+1000, _mainText.center.y);
    _hiLabel.center = CGPointMake(_hiLabel.center.x + 1000, _hiLabel.center.y);
    _logo.center = CGPointMake(_logo.center.x - 1000, _logo.center.y);
    _firstImage.center = CGPointMake(_firstImage.center.x - 1000, _firstImage.center.y);
    _firstImageLabel.center = CGPointMake(_firstImageLabel.center.x - 1000, _firstImageLabel.center.y);
    _secondImage.center = CGPointMake(_secondImage.center.x, _secondImage.center.y + 1000);
    _secondImageLabel.center = CGPointMake(_secondImageLabel.center.x, _secondImageLabel.center.y + 1000);
    _thirdImage.center = CGPointMake(_thirdImage.center.x + 1000, _thirdImage.center.y);
    _thirdImageLabel.center = CGPointMake(_thirdImageLabel.center.x + 1000, _thirdImageLabel.center.y);
    
    _firstImageLabel.text = firstColumnText;
    _secondImageLabel.text = secondColumnText;
    _thirdImageLabel.text = thirdColumnText;
    _mainText.text = descriptionTextLabel;
    
    [UIView animateWithDuration:0.4
                          delay:0
                        options: UIViewAnimationOptionTransitionFlipFromTop
                     animations:^{
                         _name.center = CGPointMake(_name.center.x, _name.center.y + 1000);
                         _subTitle.center = CGPointMake(_subTitle.center.x, _subTitle.center.y + 1000);
                         _mainText.center = CGPointMake(_mainText.center.x-1000, _mainText.center.y);
                         _hiLabel.center = CGPointMake(_hiLabel.center.x - 1000, _hiLabel.center.y);
                         _logo.center = CGPointMake(_logo.center.x + 1000, _logo.center.y);
                         
                         _firstImage.center = CGPointMake(_firstImage.center.x + 1000, _firstImage.center.y);
                         _firstImageLabel.center = CGPointMake(_firstImageLabel.center.x + 1000, _firstImageLabel.center.y);
                         _secondImage.center = CGPointMake(_secondImage.center.x, _secondImage.center.y - 1000);
                         _secondImageLabel.center = CGPointMake(_secondImageLabel.center.x, _secondImageLabel.center.y - 1000);
                         _thirdImage.center = CGPointMake(_thirdImage.center.x - 1000, _thirdImage.center.y);
                         _thirdImageLabel.center = CGPointMake(_thirdImageLabel.center.x - 1000, _thirdImageLabel.center.y);
                         
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.4
                                               delay:2
                                             options: UIViewAnimationOptionTransitionFlipFromTop
                                          animations:^{
                                             // _youTubeBackground.center = CGPointMake(_youTubeBackground.center.x, _youTubeBackground.center.y-2000);
                                          }
                                          completion:^(BOOL finished){
                                              
                                          }];

                     }];
    
/* Removing Youtube player in favor of embedding local video */
    
//    [_youTubeBackground setMediaPlaybackRequiresUserAction:NO];
//    _youTubeBackground.allowsInlineMediaPlayback=YES;
//    _youTubeBackground.scrollView.scrollEnabled = NO;
    
//    if(enableYouTubeVideo == YES) {
//        [self playVideoWithId:youTubeVideo];
//    }
//    
//    _scroll.scrollEnabled = YES;
//    _youTubeBackground.userInteractionEnabled = YES;
    
    [self playMovie];
    
}


- (void) playMovie {
    
    NSString*thePath=[[NSBundle mainBundle] pathForResource:@"About" ofType:@"mp4"];
    NSURL*theurl=[NSURL fileURLWithPath:thePath];
    MPMoviePlayerController *controller = [[MPMoviePlayerController alloc]
                                           initWithContentURL:theurl];
    
    self.mc = controller; //Super important
    controller.view.frame =  CGRectMake(0, 0, 768, 288);//Set the size
    
    
    [self.view addSubview:controller.view]; //Show the view
    [controller play]; //Start playing
}

//- (void)playVideoWithId:(NSString *)videoId {
//    
//    NSString* embedHTML;
//    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
//    {
//        embedHTML = [NSString stringWithFormat:@"\
//                     <html>\
//                     <body style='margin:0px;padding:0px;'>\
//                     <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
//                     <script type='text/javascript'>\
//                     function onYouTubeIframeAPIReady()\
//                     {\
//                     ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
//                     }\
//                     function onPlayerReady(a)\
//                     { \
//                     a.target.playVideo(); \
//                     }\
//                     </script>\
//                     <iframe id='playerId' type='text/html' width='%d' height='%d' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=0' frameborder='0'>\
//                     </body>\
//                     </html>", 768, 400, youTubeVideo];
//        
//        
//    }
//    else {
//        embedHTML = [NSString stringWithFormat:@"\
//                     <html>\
//                     <body style='margin:0px;padding:0px;'>\
//                     <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
//                     <script type='text/javascript'>\
//                     function onYouTubeIframeAPIReady()\
//                     {\
//                     ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
//                     }\
//                     function onPlayerReady(a)\
//                     { \
//                     a.target.playVideo(); \
//                     }\
//                     </script>\
//                     <iframe id='playerId' type='text/html' width='%d' height='%d' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'>\
//                     </body>\
//                     </html>", 320, 250, youTubeVideo];
//    }
//    
//    
//    NSString *html = [NSString stringWithFormat:embedHTML, videoId];
//    
//    _youTubeBackground.backgroundColor = [UIColor clearColor];
//    _youTubeBackground.opaque = NO;
//    //videoView.delegate = self;
//    
//    _youTubeBackground.mediaPlaybackRequiresUserAction = NO;
//    
//    [_youTubeBackground loadHTMLString:html baseURL:[[NSBundle mainBundle] resourceURL]];
//}


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

- (IBAction)presentPopinPressed1:(id)sender
{
    BKTPopin2ControllerViewController_about1 *popin = [[BKTPopin2ControllerViewController_about1 alloc] init];
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
    BKTPopin2ControllerViewController_about2 *popin = [[BKTPopin2ControllerViewController_about2 alloc] init];
    //Disable auto dismiss and removed semi-transparent background
    [popin setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
    
    //Configure transition direction
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
