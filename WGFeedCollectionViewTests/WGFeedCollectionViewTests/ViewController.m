//
//  ViewController.m
//  WGFeedCollectionViewTests
//
//  Created by William George on 17/06/2014.
//  Copyright (c) 2014 William George. All rights reserved.
//

#import "ViewController.h"

//WGFeed
#import "WGPost.h"
#import "WGFeedCollectionView.h"
#import "WGFeedCollectionViewCell.h"
#import "WGFeedCollectionLoadMoreReusableView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [_collectionView registerClass:[WGFeedCollectionViewCell class] forCellWithReuseIdentifier:[WGFeedCollectionViewCell cellReuseIdentifier]];
    _collectionView.collectionViewLayout.titleFont = [UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleCaption2] size:40.0];
    
    _collectionView.collectionViewLayout.postContainerOuterInset = UIEdgeInsetsMake(5, 5, 5, 30);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setShowLoadMoreView:(BOOL)showLoadMoreView
{
    if(_showLoadMoreView != showLoadMoreView){
        _showLoadMoreView = showLoadMoreView;
        
        [self.collectionView.collectionViewLayout invalidateLayout];
    }
}


#pragma mark - UICollectionViewDataSource & Delegate

-(WGPost *)collectionView:(UICollectionView *)collectionView postForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WGPost *post = [[WGPost alloc] initWithID:@"1"];
    post.title = @"Hello";
    post.message = @"This is the message, This is the message, This is the message. The mess";
    post.postedDate = [NSDate date];
    return post;
}

-(NSString *)collectionView:(UICollectionView *)collectionView cellReuseIdentifierForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [WGFeedCollectionViewCell cellReuseIdentifier];
}

-(CGSize)collectionView:(WGFeedCollectionView *)collectionView layout:(WGFeedCollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets sectionInset  = [self collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:indexPath.section];
    CGFloat cellWidth = CGRectGetWidth(collectionView.frame) - sectionInset.left - sectionInset.right;
    
    NSString *cellReuseIdentifier = [self collectionView:collectionView cellReuseIdentifierForItemAtIndexPath:indexPath];
    CGFloat cellHeight = [collectionViewLayout heightForItemCell:[collectionView classForCellReuseIdentifier:cellReuseIdentifier]
                                                     atIndexPath:indexPath
                                               constrainedToSize:CGSizeMake(cellWidth, CGFLOAT_MAX)];
    
    return CGSizeMake(cellWidth, cellHeight);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WGFeedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self collectionView:collectionView cellReuseIdentifierForItemAtIndexPath:indexPath] forIndexPath:indexPath];
    WGPost *post = [self collectionView:collectionView postForItemAtIndexPath:indexPath];
    
    //Add Data
    cell.title = post.title;
    cell.message = post.message;
    cell.date = post.postedDate;
    cell.backgroundColor = [UIColor redColor];
    cell.position = (indexPath.row % 2 == 0)?WGPostPositionPositionRight:WGPostPositionPositionLeft;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(WGFeedCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(self.showLoadMoreView && kind == UICollectionElementKindSectionHeader){
        WGFeedCollectionLoadMoreReusableView *reusableView = [collectionView dequeueReusableLoadMoreViewForIndexPath:indexPath];
        [[reusableView loadMoreButton] addTarget:self action:@selector(didSelectLoadMoreButton:) forControlEvents:UIControlEventTouchUpInside];
        return reusableView;
    }
    
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat spacing = [(UICollectionViewFlowLayout *)collectionViewLayout minimumLineSpacing];
    return UIEdgeInsetsMake(0, 5, spacing, 5);
}

@end
