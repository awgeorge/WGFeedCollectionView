//
//  ViewController.h
//  WGFeedCollectionViewTests
//
//  Created by William George on 17/06/2014.
//  Copyright (c) 2014 William George. All rights reserved.
//

#import <UIKit/UIKit.h>

//WGFeed
#import "WGFeedCollectionViewFlowLayout.h"
#import "WGFeedCollectionViewDataSource.h"

@interface ViewController : UIViewController <WGFeedCollectionViewDataSource, UICollectionViewDelegate, WGFeedCollectionViewDelegateFlowLayout>

@property(strong, nonatomic) IBOutlet WGFeedCollectionView *collectionView;

@property(assign, nonatomic) BOOL showLoadMoreView;

@end
