//
//  OffersViewController.m
//  PortfolioTheme
//
//  Created by Viktor Todorov on 9/29/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import "OffersViewController.h"
#import "Strings.h"
#import "PortfolioViewController.h"
#import "UIKit+AFNetworking.h"
#import "SWRevealViewController.h"
#import "MobileBuilder.h"

@interface OffersViewController ()
@end

@implementation OffersViewController
@synthesize _data;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    row = [NSString stringWithFormat:@"%li",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"offerNumber"]];
    _name.text = [[_data valueForKey:row] valueForKey:@"Destination"];
    [_image setImageWithURL:[NSURL URLWithString:[[_data valueForKey:row] valueForKey:@"Image"]] placeholderImage:[UIImage imageNamed:@"loadingSign.jpg"]];
    [_background setImageWithURL:[NSURL URLWithString:[[_data valueForKey:row] valueForKey:@"BackgroundImage"]] placeholderImage:[UIImage imageNamed:@"loadingSign.jpg"]];
    NSString* priceString = [NSString stringWithFormat:@"%@ %@",[[_data valueForKey:row] valueForKey:@"NormalPrice"],[[_data valueForKey:row] valueForKey:@"Currency"]];
    _price.text = priceString;
    _description.text = [[_data valueForKey:row] valueForKey:@"Description"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)readTopScorePlist
{
    _data = [[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:OffersPlistLocation]];
}
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)WriteEmail:(id)sender {
    [[NSUserDefaults standardUserDefaults]setObject:[[_data valueForKey:row] valueForKey:@"Email"] forKey:@"EmailReceiver"];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isOffer"];
    [[MobileBuilder startBuilding]ShowMail:@"" viewControoler:self];
}

- (IBAction)CallAction:(id)sender {
    NSString* phoneNumber = [NSString stringWithFormat:@"tel:%@",[[_data valueForKey:row] valueForKey:@"Phone"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

@end
