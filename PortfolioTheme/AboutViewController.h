//
//  AboutViewController.h
//  PortfolioTheme
//
//  Created by Viktor Todorov on 9/2/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "DDProgressView.h"
#import <MediaPlayer/MediaPlayer.h>

@interface AboutViewController : UIViewController {
    IBOutlet UIImage* title;
    IBOutlet UIImageView* _background;
    IBOutlet UIWebView* _youTubeBackground;
    IBOutlet UIScrollView* _scroll;
    IBOutlet UILabel* _name;
    IBOutlet UILabel* _subTitle;
    IBOutlet UIImageView* _logo;
    IBOutlet UILabel* _mainText;
    IBOutlet UILabel* _hiLabel;
    
    
    
    //Only for iPad
    IBOutlet UIImageView* _firstImage;
    IBOutlet UIImageView* _secondImage;
    IBOutlet UIImageView* _thirdImage;
    
    IBOutlet UILabel* _firstImageLabel;
    IBOutlet UILabel* _secondImageLabel;
    IBOutlet UILabel* _thirdImageLabel;
    
    
}

@property (nonatomic,strong) MPMoviePlayerController* mc;


@end
