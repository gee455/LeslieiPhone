//
//  GalleryViewController.h
//  PortfolioTheme
//
//  Created by Viktor Todorov on 10/14/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    IBOutlet UICollectionView* _collection;
    NSMutableArray* _images;
}
@property (nonatomic) NSMutableDictionary* _source;

@end


