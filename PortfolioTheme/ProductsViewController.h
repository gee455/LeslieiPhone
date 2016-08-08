//
//  ProductsViewController.h
//  PortfolioTheme
//
//  Created by Viktor Todorov on 9/2/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import <MapKit/MapKit.h>
#import <MessageUI/MessageUI.h>
#import "Reachability.h"

@interface ProductsViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate> {
    IBOutlet UILabel* _phone;
    IBOutlet UILabel* _adress;

}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic, retain) CLLocationManager *locationManager;
- (IBAction)zoomIn:(id)sender;
- (IBAction)changeMapType:(id)sender;

-(IBAction)openFacebook:(id)sender;
-(IBAction)openTwitter:(id)sender;
-(IBAction)openGoogle:(id)sender;
-(IBAction)openYoutube:(id)sender;
-(IBAction)openWriteEmail:(id)sender;
-(IBAction)callPhone:(id)sender;
-(IBAction)openMaps:(id)sender;
@end
