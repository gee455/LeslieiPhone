//
//  PhotoViewController.m
//  PortfolioTheme
//
//  Created by Viktor Todorov on 10/14/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import "PhotoViewController.h"
#import "MobileBuilder.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController
@synthesize image;
- (void)viewDidLoad {
    [super viewDidLoad];
    _photo.image = image.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)openFacebook:(id)sender {
    NSLog(@"FB");
    NSString* msg = [NSString stringWithFormat:@"View more on our webpage www.mywebpage.com"];
    [[MobileBuilder startBuilding]ShowFacebook:0 viewControoler:self image:_photo.image url:@"google.com" message:msg];
}
- (IBAction)openTwitter:(id)sender {
    NSLog(@"TW");
    NSString* msg = [NSString stringWithFormat:@"View more on our webpage www.mywebpage.com"];
    [[MobileBuilder startBuilding]ShowTwitter:0 viewControoler:self image:_photo.image url:@"google.com" message:msg];
}
@end
