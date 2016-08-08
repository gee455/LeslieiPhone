//
//  RadioStreamViewController.h
//  PortfolioTheme
//
//  Created by Viktor Todorov on 10/14/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface RadioStreamViewController : UIViewController {
    IBOutlet UIButton* _playButton;
    IBOutlet UILabel* _radioName;
    BOOL _isPlaying;
    MPMoviePlayerController *player;
    
}
-(IBAction)playMusic:(id)sender;
-(IBAction)back:(id)sender;
@property (nonatomic)NSMutableDictionary* source;
@end
