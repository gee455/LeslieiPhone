//
//  CritterViewController.h
//  PortfolioTheme
//
//  Created by Calvin Gee on 11/8/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CritterViewController : UIViewController  <UIScrollViewDelegate>{
    IBOutlet UIScrollView *scroller;
}

@property (strong, nonatomic) IBOutlet UIButton *critterBtn;
- (IBAction)showSuccess:(id)sender;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@end
