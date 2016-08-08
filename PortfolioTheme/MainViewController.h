//
//  ViewController.h
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYBlurIntroductionView.h"
#import <AVFoundation/AVFoundation.h>

//Mapbox
//#import "Mapbox.h"
//#import "RMMapViewDelegate.h"
#import "MBXMapKit.h"
@import MapKit;
@import UIKit;



@interface MainViewController : UIViewController  <MYIntroductionDelegate,AVCaptureMetadataOutputObjectsDelegate,UIActionSheetDelegate, MKMapViewDelegate, MBXRasterTileOverlayDelegate, MBXOfflineMapDownloaderDelegate, UIAlertViewDelegate, UIScrollViewDelegate>

{
    IBOutlet UINavigationItem* _topBar;
    IBOutlet UIImageView* _background;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

//QR Code
@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *bbitemStart;
@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;




@end
