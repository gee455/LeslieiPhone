//
//  SubProductsViewController.m
//  PortfolioTheme
//
//  Created by Viktor Todorov on 10/6/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import "SubProductsViewController.h"
#import "UIKit+AFNetworking.h"
#import "MobileBuilder.h"

@interface SubProductsViewController ()

@end

@implementation SubProductsViewController
@synthesize _data;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    row = [NSString stringWithFormat:@"%li",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"subNumber"]];
    _titleText.text = [[_data valueForKey:row] valueForKey:@"Name"];
    [_mainImage setImageWithURL:[NSURL URLWithString:[[_data valueForKey:row] valueForKey:@"Image"]] placeholderImage:[UIImage imageNamed:@"loadingSign.jpg"]];
    [_backgroundImage setImageWithURL:[NSURL URLWithString:[[_data valueForKey:row] valueForKey:@"Background"]] placeholderImage:[UIImage imageNamed:@"loadingSign.jpg"]];
    _description.text = [[_data valueForKey:row] valueForKey:@"Description"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)openFacebook:(id)sender {
    NSLog(@"FB");
    NSString* msg = [NSString stringWithFormat:@"%@ is a great place to visit. Learn more on www.mywebsite.com",_titleText.text];
    [[MobileBuilder startBuilding]ShowFacebook:0 viewControoler:self image:_mainImage.image url:@"google.com" message:msg];
}

- (IBAction)openGoogle:(id)sender {
    NSLog(@"Mail");
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isOffer"];
    NSString* msg = [NSString stringWithFormat:@"%@ is a great place to visit. Learn more on www.mywebsite.com",_titleText.text];
    [[MobileBuilder startBuilding]ShowMail:msg viewControoler:self];
}

- (IBAction)openTwitter:(id)sender {
    NSLog(@"TW");
    NSString* msg = [NSString stringWithFormat:@"%@ is a great place to visit. Learn more on www.mywebsite.com",_titleText.text];
    [[MobileBuilder startBuilding]ShowTwitter:0 viewControoler:self image:_mainImage.image url:@"google.com" message:msg];
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
