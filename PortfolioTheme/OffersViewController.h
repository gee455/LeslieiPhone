//
//  OffersViewController.h
//  PortfolioTheme
//
//  Created by Viktor Todorov on 9/29/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OffersViewController : UIViewController {
    
     IBOutlet UILabel *_name;
     IBOutlet UIImageView *_image;
     IBOutlet UITextView* _description;
     IBOutlet UIButton *_askUs;
     IBOutlet UIButton *_callUs;
     IBOutlet UILabel *_price;
     IBOutlet UIButton *backButton;
     IBOutlet UIImageView *_background;
     IBOutlet UIImageView* _textBackground;
    IBOutlet UIImageView* _priceBack;
     NSString* row;
}
@property (nonatomic, retain)  NSMutableDictionary* _data;
- (IBAction)backButton:(id)sender;
- (IBAction)WriteEmail:(id)sender;
- (IBAction)CallAction:(id)sender;

@end
