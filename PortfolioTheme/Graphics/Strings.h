/*
 *  Strings.h
 *  duudleJump
 *
 *  Created by Viktor Todorov on 24.03.14.
 *  Copyright 2014 Viktor Todorov. All rights reserved.
 *
 */


#define SYSTEM_VERSION_LESS_THAN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define IS_IPHONE5 (fabs ( (double) [ [UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
static NSMutableDictionary* _dataa;


//WORDPRESS LINK
static NSString* WordPressLink = @"http://www.lesliesnc.org/rss.xml";


//Push Notifications Parse Setup
//Set the correct application ID and client key. If you dont have please visit Parse.com and create one.
static NSString* applicationID = @"gRB9xKUqwkmJ6X0Sd3XJAGlnVwX734o7C0mcYxzj";
static NSString* clientKey = @"9Z4MOWdBEVEEXgRHrFLnKr85Ztl4Li9ykcaIwgD4";


//YouTube ID e.g.www.youtube.com/watch?v=tDvBwPzJ7dY <- the final symbols: tDvBwPzJ7dY
static NSString* youTubeVideo = @"oay6QVdoyjM";

//YouTube ID e.g.www.youtube.com/watch?v=tDvBwPzJ7dY <- the final symbols: tDvBwPzJ7dY
static NSString* critterVideo = @"a922H9p7zUo";

//YouTube ID e.g.www.youtube.com/watch?v=tDvBwPzJ7dY <- the final symbols: tDvBwPzJ7dY
static NSString* raptorVideo = @"ZlQ256KMdxA";

//YouTube ID e.g.www.youtube.com/watch?v=tDvBwPzJ7dY <- the final symbols: tDvBwPzJ7dY
static NSString* historyVideo = @"lAk-VwoXZ_Y";

//YouTube ID e.g.www.youtube.com/watch?v=tDvBwPzJ7dY <- the final symbols: tDvBwPzJ7dY
static NSString* invertVideo = @"AiB5Jakw26w";

//YouTube ID e.g.www.youtube.com/watch?v=tDvBwPzJ7dY <- the final symbols: tDvBwPzJ7dY
static NSString* eagleVideo = @"NISTI64gsow";

//Enable YouTube Video
static BOOL enableYouTubeVideo = YES;

//Enable YouTube Video
static BOOL enableHistoryVideo = YES;

//Plist Locations on your server. For example www.myserver.com/plistname.plist
static NSString* OffersPlistLocation = @"";

//About Page Description
static NSString* descriptionTextLabel = @"Leslie Science & Nature Center educates and inspires children and adults to discover, understand, and respect their natural environment.";

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>ONLY FOR IPAD !!!!!!!!!!!!!!! <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//About Page First Column Text
static NSString* firstColumnText = @"Our History";

//About Page Second Column Text
static NSString* secondColumnText = @"Our Reach";

//About Page Third Column Text
static NSString* thirdColumnText = @"Get involved";
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

//Contact Page

//Location
static float latitude = 42.300999;
static float longitude = -83.730207;

//Phone
static NSString* phone = @"(734) 997-1553";

//Adress
static NSString* adress = @"1831 Traver Rd, Ann Arbor, MI 48105";

//Email
static NSString* email = @"myemail@lesliescience.org";

//Facebook
static NSString* facebook = @"https://www.facebook.com/lesliesnc";

//Twitter
static NSString* twitter = @"https://twitter.com/lesliesnc";

//Google+
static NSString* google = @"http://www.pinterest.com/lesliesnc/";

//YouTuve
static NSString* youtube = @"https://www.youtube.com/user/LSNC48105";







