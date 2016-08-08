//
//  RadioStreamViewController.m
//  PortfolioTheme
//
//  Created by Viktor Todorov on 10/14/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import "RadioStreamViewController.h"

@interface RadioStreamViewController ()

@end

@implementation RadioStreamViewController
@synthesize source;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isPlaying = NO;
    NSString* row = [NSString stringWithFormat:@"%li",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"offerNumber"]];
    _radioName.text = [[source valueForKey:row] valueForKey:@"RadioName"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)playMusic:(id)sender {
    if(_isPlaying == NO) {
        NSString* row = [NSString stringWithFormat:@"%li",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"offerNumber"]];
        
        NSString* passUrl = [[source valueForKey:row] valueForKey:@"RadioStationLink"];
        NSLog(@"%@",passUrl);
        player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:passUrl]];
        player.movieSourceType = MPMovieSourceTypeStreaming;
        player.view.hidden = YES;
        [player prepareToPlay];
        [player play];
        [_playButton setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        _isPlaying = YES;
    }
    else {
        
        [player stop];
        [_playButton setImage:[UIImage imageNamed:@"play-button-png.png"] forState:UIControlStateNormal];
        _isPlaying = NO;
    }
}
-(IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
