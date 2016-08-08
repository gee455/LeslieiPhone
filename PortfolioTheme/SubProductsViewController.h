//
//  SubProductsViewController.h
//  PortfolioTheme
//
//  Created by Viktor Todorov on 10/6/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubProductsViewController : UIViewController {
    IBOutlet UIImageView* _mainImage;
    IBOutlet UIImageView* _backgroundImage;
    IBOutlet UILabel* _description;
    IBOutlet UILabel* _titleText;
    IBOutlet UIButton* _facebook;
    IBOutlet UIButton* _google;
    IBOutlet UIButton* _twitter;
    NSString* row;
}
- (IBAction)openFacebook:(id)sender;
- (IBAction)openGoogle:(id)sender;
- (IBAction)openTwitter:(id)sender;
- (IBAction)backAction:(id)sender;
@property (nonatomic, retain)  NSMutableDictionary* _data;
@end
