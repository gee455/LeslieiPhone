//
//  PhotoViewController.h
//  PortfolioTheme
//
//  Created by Viktor Todorov on 10/14/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController {
    IBOutlet UIImageView* _photo;
}
@property (nonatomic,retain) UIImageView* image;
-(IBAction)back:(id)sender;
@end
