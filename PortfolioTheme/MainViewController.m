//
//  ViewController.m
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"

#import "MYCustomPanel.h"
#import "CritterViewController.h"

//Pop In
#import "UIViewController+MaryPopin.h"
#import "BKTPopinControllerViewController.h"
#import "BKTPopinControllerViewController2.h"
#import "BKTPopinControllerViewController3.h"
#import "BKTPopinControllerViewController4.h"
#import "BKTPopinControllerViewController5.h"
#import "BKTPopinControllerViewController6.h"
#import "BKTPopinControllerViewController7.h"
#import "BKTPopinControllerViewController8.h"
#import "BKTPopinControllerViewController9.h"
#import "BKTPopinControllerViewController10.h"
#import "BKTPopinControllerViewController11.h"
#import "BKTPopinControllerViewController12.h"
#import "BKTPopinControllerViewController13.h"
#import "BKTPopinControllerViewController14.h"
#import "BKTPopinControllerViewController15.h"

//Map Popin
#import "BKTPopin2ControllerViewController_map1.h"
#import "BKTPopin2ControllerViewController_map2.h"
#import "BKTPopin2ControllerViewController_map3.h"
#import "BKTPopin2ControllerViewController_map4.h"
#import "BKTPopin2ControllerViewController_map5.h"
#import "BKTPopin2ControllerViewController_map6.h"
#import "BKTPopin2ControllerViewController_map7.h"
#import "BKTPopin2ControllerViewController_map8.h"
#import "BKTPopin2ControllerViewController_map9.h"
#import "BKTPopin2ControllerViewController_map10.h"
#import "BKTPopin2ControllerViewController_map11.h"
#import "BKTPopin2ControllerViewController_map12.h"
#import "BKTPopin2ControllerViewController_map13.h"
#import "BKTPopin2ControllerViewController_map14.h"
#import "BKTPopin2ControllerViewController_map15.h"
#import "BKTPopin2ControllerViewController_map16.h"
#import "BKTPopin2ControllerViewController_map17.h"
#import "BKTPopin2ControllerViewController_map18.h"


#import <QuartzCore/QuartzCore.h>

//Mapbox
#import "Mapbox.h"
#import "MBWPDetailViewController.h"
#define kMapboxMapID @"cgee.klegg5i6"
#import "UIColor+MBWPExtensions.h"
#define kTintColorHex @"#AA0000"


//Example
#define kRegularGeographyClassMapID @"examples.map-zmy97flj"
#define kRetinaGeographyClassMapID  @"examples.1fjyxmhi"



@interface MainViewController ()

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

//Mapbox
@property (weak, nonatomic) IBOutlet RMMapView *mapView;
@property (strong) NSArray *activeFilterTypes;

//WebView
@property (weak, nonatomic) IBOutlet UIWebView *wv;

//Scaleable Scrollview
@property (nonatomic, strong) UIImageView *imageView;

- (void)centerScrollViewContents;
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer;
- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer;

@end

@implementation MainViewController

@synthesize mapView;
@synthesize activeFilterTypes;
@synthesize wv;
@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:kTintColorHex];
    
    self.navigationItem.rightBarButtonItem = [[RMUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    self.navigationItem.rightBarButtonItem.tintColor = self.navigationController.navigationBar.tintColor;
    
    //self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStyleBordered target:nil action:nil];


    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];

    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    //self.navigationItem.leftBarButtonItem = _sidebarButton;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self.revealViewController action:@selector(revealToggle:)];

    self.navigationController.navigationBar.translucent = YES;
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.view.backgroundColor = [UIColor colorWithRed:36/255.0
                                                green:38/255.0
                                                 blue:44/255.0
                                                alpha:1.0];
    
    //QR Code
    // Initially make the captureSession object nil.
    _captureSession = nil;
	
    // Begin loading the sound effect so to have it ready for playback when it's needed.
    NSError *error;
    
    // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
    // as the media type parameter.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        // If any error occurs, simply log the description of it and don't continue any more.
        NSLog(@"%@", [error localizedDescription]);
    }
    
    // Initialize the captureSession object.
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
	
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //Array of QR Code Object Types
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    //Calling this methods builds the intro and adds it to the screen. See below.
    [self buildIntro];
    
    //Scroll View
    // 1
    UIImage *image = [UIImage imageNamed:@"bigMap.png"];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=image.size};
    
    //Pin #1 Leslie Center (L)
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"pinL"] forState:UIControlStateNormal];
    button.frame = CGRectMake(487.0, 379.0, 30.0, 55.0);
    [button addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button.tag = 0;
    [self.imageView addSubview: button];
    
    //Pin #2 Critter House (C)
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button1 setBackgroundImage:[UIImage imageNamed:@"pinC"] forState:UIControlStateNormal];
//    button1.frame = CGRectMake(422.0, 368.0, 30.0, 55.0);
//    [button1 addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
//    button1.tag = 199;
//    [self.imageView addSubview: button1];
    
    //Pin #3 Flower Garden (Flower)
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setBackgroundImage:[UIImage imageNamed:@"pinFlower"] forState:UIControlStateNormal];
    button2.frame = CGRectMake(543.0, 373.0, 30.0, 55.0);
    [button2 addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button2.tag = 2;
    [self.imageView addSubview: button2];
    
    //Pin #4 Post 1
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setBackgroundImage:[UIImage imageNamed:@"pin1"] forState:UIControlStateNormal];
    button3.frame = CGRectMake(565.0, 327.0, 30.0, 55.0);
    [button3 addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button3.tag = 3;
    [self.imageView addSubview: button3];
    
    //Pin #5 Post 2
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setBackgroundImage:[UIImage imageNamed:@"pin2"] forState:UIControlStateNormal];
    button4.frame = CGRectMake(543.0, 303.0, 30.0, 55.0);
    [button4 addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button4.tag = 4;
    [self.imageView addSubview: button4];
    
    //Pin #6 Post 3
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button5 setBackgroundImage:[UIImage imageNamed:@"pin3"] forState:UIControlStateNormal];
    button5.frame = CGRectMake(585.0, 299.0, 30.0, 55.0);
    [button5 addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button5.tag = 5;
    [self.imageView addSubview: button5];
    
    //Pin #7 Post 4
    UIButton *button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button6 setBackgroundImage:[UIImage imageNamed:@"pin4"] forState:UIControlStateNormal];
    button6.frame = CGRectMake(549.0, 236.0, 30.0, 55.0);
    [button6 addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button6.tag = 6;
    [self.imageView addSubview: button6];
    
    //Pin #8 Post 5
    UIButton *button7 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button7 setBackgroundImage:[UIImage imageNamed:@"pin5"] forState:UIControlStateNormal];
    button7.frame = CGRectMake(543.0, 132.0, 30.0, 55.0);
    [button7 addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button7.tag = 7;
    [self.imageView addSubview: button7];
    
    //Pin #9 Black Woods Pond (P)
    UIButton *button8 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button8 setBackgroundImage:[UIImage imageNamed:@"pinP"] forState:UIControlStateNormal];
    button8.frame = CGRectMake(516.0, 159.0, 30.0, 55.0);
    [button8 addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button8.tag = 8;
    [self.imageView addSubview: button8];
    
    //Pin #10 Post 6
    UIButton *button9 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button9 setBackgroundImage:[UIImage imageNamed:@"pin6"] forState:UIControlStateNormal];
    button9.frame = CGRectMake(469.0, 132.0, 30.0, 55.0);
    [button9 addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button9.tag = 9;
    [self.imageView addSubview: button9];
    
    //Pin #11 Post 7
    UIButton *button10 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button10 setBackgroundImage:[UIImage imageNamed:@"pin7"] forState:UIControlStateNormal];
    button10.frame = CGRectMake(431.0, 173.0, 30.0, 55.0);
    [button10 addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button10.tag = 10;
    [self.imageView addSubview: button10];
    
    //Pin #12 Post 8
    UIButton *button11 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button11 setBackgroundImage:[UIImage imageNamed:@"pin8"] forState:UIControlStateNormal];
    button11.frame = CGRectMake(424.0, 236.0, 30.0, 55.0);
    [button11 addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button11.tag = 11;
    [self.imageView addSubview: button11];
    
    //Pin #13 Post 9
    UIButton *button11a = [UIButton buttonWithType:UIButtonTypeCustom];
    [button11a setBackgroundImage:[UIImage imageNamed:@"pin9"] forState:UIControlStateNormal];
    button11a.frame = CGRectMake(419.0, 299.0, 30.0, 55.0);
    [button11a addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button11a.tag = 20;
    [self.imageView addSubview: button11a];
    
    //Pin #18 Sensory Trail (Star)
    UIButton *button16 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button16 setBackgroundImage:[UIImage imageNamed:@"pinStar"] forState:UIControlStateNormal];
    button16.frame = CGRectMake(602.0, 335.0, 30.0, 55.0);
    [button16 addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button16.tag = 16;
    [self.imageView addSubview: button16];
    
    //Pin #14 S
    UIButton *button12 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button12 setBackgroundImage:[UIImage imageNamed:@"pinS"] forState:UIControlStateNormal];
    button12.frame = CGRectMake(602.0, 395.0, 30.0, 55.0);
    [button12 addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button12.tag = 12;
    [self.imageView addSubview: button12];
    
    //Pin #15 H
    UIButton *button13 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button13 setBackgroundImage:[UIImage imageNamed:@"pinH"] forState:UIControlStateNormal];
    button13.frame = CGRectMake(645.0, 335.0, 30.0, 55.0);
    [button13 addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button13.tag = 13;
    [self.imageView addSubview: button13];
    
    //Pin #16 E
    UIButton *button14 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button14 setBackgroundImage:[UIImage imageNamed:@"pinE"] forState:UIControlStateNormal];
    button14.frame = CGRectMake(630.0, 370.0, 30.0, 55.0);
    [button14 addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button14.tag = 14;
    [self.imageView addSubview: button14];
    
    //Pin #17 T
    UIButton *button15 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button15 setBackgroundImage:[UIImage imageNamed:@"pinT"] forState:UIControlStateNormal];
    button15.frame = CGRectMake(575.0, 410.0, 30.0, 55.0);
    [button15 addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button15.tag = 15;
    [self.imageView addSubview: button15];
    
    
    //Pin #2 Critter House (C)
    UIButton *button17 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button17 setBackgroundImage:[UIImage imageNamed:@"pinC"] forState:UIControlStateNormal];
    button17.frame = CGRectMake(422.0, 368.0, 30.0, 55.0);
    [button17 addTarget:self action:@selector(buttonPopin:)forControlEvents:UIControlEventTouchUpInside];
    button17.tag = 19;
    [self.imageView addSubview: button17];
    
  
    
  
    
    self.imageView.userInteractionEnabled = YES;
    
    [self.scrollView addSubview:self.imageView];
    
    // 2
    self.scrollView.contentSize = image.size;
    
    // 3
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.scrollView addGestureRecognizer:twoFingerTapRecognizer];
	
}

-(void)viewDidAppear:(BOOL)animated{
    
    // Start video capture.
    [_captureSession startRunning];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    //ScrollView
    // 4
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    self.scrollView.minimumZoomScale = minScale;
    
    // 5
    self.scrollView.maximumZoomScale = 1.0f;
    self.scrollView.zoomScale = minScale;
    
    // 6
    [self centerScrollViewContents];
    

}



-(void)viewWillDisappear:(BOOL)animated
{
	[_captureSession stopRunning];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)print_Message {
    NSLog(@"Eh up, someone just pressed the button!");
}



-(void)buildIntro{
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    
    //BOOL downloaded = [[NSUserDefaults standardUserDefaults] boolForKey: @"downloaded"];
    //if (!downloaded) {
        //download code here
        
        //Create Stock Panel with header
        //UIView *headerView = [[NSBundle mainBundle] loadNibNamed:@"TestHeader" owner:nil options:nil][0];
        MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) nibNamed:@"TestPanel1"];
        
        //Create Stock Panel With Image
        MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) nibNamed:@"TestPanel2"];
        
        //Create Panel From Nib
        MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) nibNamed:@"TestPanel3"];
        
        //Create custom panel with events
        MYCustomPanel *panel4 = [[MYCustomPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) nibNamed:@"TestPanel4"];
    
        //Create custom panel with events
        MYCustomPanel *panel5 = [[MYCustomPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) nibNamed:@"TestPanel5"];
    
        //Add panels to an array
        NSArray *panels = @[panel1, panel2, panel3, panel4, panel5];
        
        //Create the introduction view and set its delegate
        MYBlurIntroductionView *introductionView = [[MYBlurIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        introductionView.delegate = self;
        introductionView.BackgroundImageView.image = [UIImage imageNamed:@"grid.png"];
        [introductionView setBackgroundColor:[UIColor colorWithRed:90.0f/255.0f green:175.0f/255.0f blue:113.0f/255.0f alpha:0.65]];
        //introductionView.LanguageDirection = MYLanguageDirectionRightToLeft;
        
        //Build the introduction with desired panels
        [introductionView buildIntroductionWithPanels:panels];
        
        //Add the introduction to your view
        [self.view addSubview:introductionView];
    
        self.navigationController.navigationBar.hidden = NO;
    
         self.title = @"Leslie Science & Nature Center";
    
    //[[NSUserDefaults standardUserDefaults] setBool:YES forKey: @"downloaded"];
    //}
    
    
    
}

-(void)introduction:(MYBlurIntroductionView *)introductionView didFinishWithType:(MYFinishType)finishType {
    
    /* When the introduction finishes up, the map will load. This is to prevent it from loading too many times and breaking,*/
    
     self.title = @"Leslie Science & Nature Center";
    
    NSURL *htmlFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"mapView" ofType:@"html"] isDirectory:NO];
    [wv loadRequest:[NSURLRequest requestWithURL:htmlFile]];

    /* Commenting out native mapbox */
    
    /*
    // this auto-enables annotations based on simplestyle data for this map (see http://mapbox.com/developers/simplestyle/ for more info)
    //
    self.mapView.tileSource = [[RMMapboxSource alloc] initWithMapID:kMapboxMapID enablingDataOnMapView:self.mapView];
    
    self.mapView.zoom = 8;
    
    [self.mapView setConstraintsSouthWest:[self.mapView.tileSource latitudeLongitudeBoundingBox].southWest
                                northEast:[self.mapView.tileSource latitudeLongitudeBoundingBox].northEast];
    
    self.mapView.showsUserLocation = YES;
    
    if ([UIView instancesRespondToSelector:@selector(setTintColor:)])
        self.mapView.tintColor = self.navigationController.navigationBar.tintColor;
    
    // zoom in to markers after launch
    //
    __weak RMMapView *weakMap = self.mapView; // avoid block-based memory leak
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC), dispatch_get_main_queue(), ^(void)
                   {
                       float degreeRadius = 500.f / 110000.f; // (9000m / 110km per degree latitude)
                       
                       CLLocationCoordinate2D centerCoordinate = [((RMMapboxSource *)self.mapView.tileSource) centerCoordinate];
                       
                       RMSphericalTrapezium zoomBounds = {
                           .southWest = {
                               .latitude  = centerCoordinate.latitude  - degreeRadius,
                               .longitude = centerCoordinate.longitude - degreeRadius
                           },
                           .northEast = {
                               .latitude  = centerCoordinate.latitude  + degreeRadius,
                               .longitude = centerCoordinate.longitude + degreeRadius
                           }
                       };
                       
                       [weakMap zoomWithLatitudeLongitudeBoundsSouthWest:zoomBounds.southWest
                                                               northEast:zoomBounds.northEast
                                                                animated:YES];
                   });
     
     */
    
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark -


- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation
{
    if (annotation.isUserLocationAnnotation)
        return nil;
    
    RMMarker *marker = [[RMMarker alloc] initWithMapboxMarkerImage:[annotation.userInfo objectForKey:@"marker-symbol"]
                                                      tintColorHex:[annotation.userInfo objectForKey:@"marker-color"]
                                                        sizeString:[annotation.userInfo objectForKey:@"marker-size"]];
    
    marker.canShowCallout = YES;
    
    marker.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"depot.jpg"]];
    
    marker.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    if (self.activeFilterTypes)
        marker.hidden = ! [self.activeFilterTypes containsObject:[annotation.userInfo objectForKey:@"marker-symbol"]];
    
    return marker;
}

- (void)tapOnCalloutAccessoryControl:(UIControl *)control forAnnotation:(RMAnnotation *)annotation onMap:(RMMapView *)map
{
    MBWPDetailViewController *detailController = [[MBWPDetailViewController alloc] initWithNibName:nil bundle:nil];
    
    detailController.detailTitle       = [annotation.userInfo objectForKey:@"title"];
    detailController.detailDescription = [annotation.userInfo objectForKey:@"description"];
    
    [self.navigationController pushViewController:detailController animated:YES];
}


- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    // 1
    CGPoint pointInView = [recognizer locationInView:self.imageView];
    
    // 2
    CGFloat newZoomScale = self.scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
    
    // 3
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    // 4
    [self.scrollView zoomToRect:rectToZoomTo animated:YES];
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that you want to zoom
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so you need to re-center the contents
    [self centerScrollViewContents];
}


-(void)buttonPopin:(id)sender {
    NSInteger tid = ((UIControl *) sender).tag;
    
    if (tid == 0) {
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map1 *popin1 = [[BKTPopin2ControllerViewController_map1 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
    }
    
    
    if (tid == 19) {
        
        NSLog(@"C button pressed !");
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map18 *popinA = [[BKTPopin2ControllerViewController_map18 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popinA setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popinA setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popinA setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popinA animated:YES completion:^{
            NSLog(@"Popin C presented !");
        }];
        
    }


    
    if (tid == 2) {
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map3 *popin1 = [[BKTPopin2ControllerViewController_map3 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
    }

    
    
    if (tid == 3) {
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map4 *popin1 = [[BKTPopin2ControllerViewController_map4 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
    }
    
    if (tid == 4) {
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map5 *popin1 = [[BKTPopin2ControllerViewController_map5 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
    }
    
    if (tid == 5) {
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map6 *popin1 = [[BKTPopin2ControllerViewController_map6 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
    }
    
    if (tid == 6) {
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map7 *popin1 = [[BKTPopin2ControllerViewController_map7 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
    }
    
    if (tid == 7) {
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map8 *popin1 = [[BKTPopin2ControllerViewController_map8 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
    }
    
    if (tid == 8) {
        
        NSLog(@"Button 8 tapped!");
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map9 *popin1 = [[BKTPopin2ControllerViewController_map9 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
    }
    
    if (tid == 9) {
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map10 *popin1 = [[BKTPopin2ControllerViewController_map10 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
    }
    
    if (tid == 10) {
        
        NSLog(@"C button pressed !");
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map11 *popin1 = [[BKTPopin2ControllerViewController_map11 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
    }
    
    
    if (tid == 11) {
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map12 *popin1 = [[BKTPopin2ControllerViewController_map12 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
    }
    
    
    
    if (tid == 12) {
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map17 *popin1 = [[BKTPopin2ControllerViewController_map17 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
    }
    
    if (tid == 13) {
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map14 *popin1 = [[BKTPopin2ControllerViewController_map14 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
    }
    
    if (tid == 14) {
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map15 *popin1 = [[BKTPopin2ControllerViewController_map15 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
    }
    
    if (tid == 15) {
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map16 *popin1 = [[BKTPopin2ControllerViewController_map16 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
    }
    
    if (tid == 16) {
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map13 *popin1 = [[BKTPopin2ControllerViewController_map13 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
    }
    
    if (tid == 17) {
        // deal with downButton event here ..
        BKTPopin2ControllerViewController_map3 *popin1 = [[BKTPopin2ControllerViewController_map3 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
    }
}



-(void)popinMethod:(id)qrCode {
    //BKTPopinControllerViewController *popin = [[BKTPopinControllerViewController alloc] init];
    
   // BKTPopinControllerViewController2 *popin1 = [[BKTPopinControllerViewController2 alloc] init];
    
    if ([qrCode isEqual: @"1"]) {
        
        BKTPopinControllerViewController3 *popin1 = [[BKTPopinControllerViewController3 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];


    };
    
    if ([qrCode isEqual: @"2"]) {
        
        
        BKTPopinControllerViewController4 *popin1 = [[BKTPopinControllerViewController4 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
    
        
    };
    
    
    if ([qrCode isEqual: @"3"]) {
        
        
        BKTPopinControllerViewController5 *popin1 = [[BKTPopinControllerViewController5 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
        
    };
    
    if ([qrCode isEqual: @"4"]) {
        
        
        BKTPopinControllerViewController6 *popin1 = [[BKTPopinControllerViewController6 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
        
    };
    
    if ([qrCode isEqual: @"5"]) {
        
        
        BKTPopinControllerViewController7 *popin1 = [[BKTPopinControllerViewController7 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
        
    };
    if ([qrCode isEqual: @"6"]) {
        
        
        BKTPopinControllerViewController8 *popin1 = [[BKTPopinControllerViewController8 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
        
    };
    
    if ([qrCode isEqual: @"7"]) {
        
        
        BKTPopinControllerViewController9 *popin1 = [[BKTPopinControllerViewController9 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
        
    };
    
    if ([qrCode isEqual: @"8"]) {
        
        
        BKTPopinControllerViewController10 *popin1 = [[BKTPopinControllerViewController10 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
        
    };
    
    if ([qrCode isEqual: @"9"]) {
        
        
        BKTPopinControllerViewController11 *popin1 = [[BKTPopinControllerViewController11 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
        
    };
    
    if ([qrCode isEqual: @"10"]) {
        
        
        BKTPopinControllerViewController12 *popin1 = [[BKTPopinControllerViewController12 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
        
    };
    
    if ([qrCode isEqual: @"11"]) {
        
        
        BKTPopinControllerViewController13 *popin1 = [[BKTPopinControllerViewController13 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
        
    };
    
    if ([qrCode isEqual: @"12"]) {
        
        
        BKTPopinControllerViewController14 *popin1 = [[BKTPopinControllerViewController14 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
        
    };
    
    if ([qrCode isEqual: @"13"]) {
        
        
        BKTPopinControllerViewController15 *popin1 = [[BKTPopinControllerViewController15 alloc] init];
        
        //Disable auto dismiss and removed semi-transparent background
        [popin1 setPopinOptions:BKTPopinDisableAutoDismiss|BKTPopinDimmingViewStyleNone];
        [popin1 setPopinOptions:BKTPopinDisableParallaxEffect];
        
        //Configure transition direction
        [popin1 setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
        [self presentPopinController:popin1 animated:YES completion:^{
            NSLog(@"Popin presented !");
        }];
        
        
    };
    
}


-(void)stopReading{
    // Stop video capture and make the capture session object nil.
    [_captureSession stopRunning];
}

-(void)handleMetadata:(id)metadata {
	NSString *qrCode = [metadata stringValue];
    
    
    //[self popinMethod];
    
    [self performSelectorOnMainThread:@selector(popinMethod:) withObject:qrCode waitUntilDone:NO];
    
    // Start video capture.
    [_captureSession startRunning];
    
    
	NSLog(@"%@", qrCode);
}



#pragma mark - AVCaptureMetadataOutputObjectsDelegate method implementation

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        // Get the metadata object.
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
			
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
			[self performSelectorOnMainThread:@selector(handleMetadata:) withObject:metadataObj waitUntilDone:NO];
			
                    }
    }
}





@end