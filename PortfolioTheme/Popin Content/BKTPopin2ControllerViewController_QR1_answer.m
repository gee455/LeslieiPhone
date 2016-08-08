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

#import "BKTPopin2ControllerViewController_QR1_answer.h"
#import "Strings.h"
#import <AudioToolbox/AudioToolbox.h>


@interface BKTPopin2ControllerViewController_QR1_answer  ()

@end

@implementation BKTPopin2ControllerViewController_QR1_answer

- (void) viewDidLoad{
    
//    [_youTubeBackground setMediaPlaybackRequiresUserAction:NO];
//    _youTubeBackground.allowsInlineMediaPlayback=YES;
//    _youTubeBackground.scrollView.scrollEnabled = NO;
//    
//
//    if(enableHistoryVideo == YES) {
//        [self playVideoWithId:eagleVideo];
//    }
//
//
//    _youTubeBackground.userInteractionEnabled = NO;
    
    [self playMovie];
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
//                     <iframe id='playerId' type='text/html' width='%d' height='%d' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'>\
//                     </body>\
//                     </html>", 345, 194, eagleVideo];
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
//                     </html>", 345, 194, eagleVideo];
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



-(IBAction)buttonPressedWithSound:(id)sender {
    
    int randomSoundNumber = arc4random() % 1; //random number from 0 to 3
    
    NSLog(@"random sound number = %i", randomSoundNumber);
    
    NSString *effectTitle;
    
    switch (randomSoundNumber) {
        case 0:
            effectTitle = @"eagle";
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}



@end
