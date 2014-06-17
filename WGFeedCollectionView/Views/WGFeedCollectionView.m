/**
 *  Copyright (c) 2013 William George.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 *
 *  @author William George
 *  @package WGFramework
 *  @category Feed
 *  @date 17/06/2014
 */

#import "WGFeedCollectionView.h"

//WGFeed
#import "WGFeedCollectionLoadMoreReusableView.h"

@interface WGFeedCollectionView ()
    @property (strong, nonatomic) NSMutableDictionary *classForCellReuseIdentifier;
    @property (strong, nonatomic) NSMutableDictionary *nibForCellReuseIdentifier;
@end

@implementation WGFeedCollectionView

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        // Initialization code
        
        [self registerClass:[WGFeedCollectionLoadMoreReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[WGFeedCollectionLoadMoreReusableView reuseIdentifier]];
    }
    return self;
}

#pragma mark -

-(Class)classForCellReuseIdentifier:(NSString *)identifier
{
    return [[self.classForCellReuseIdentifier objectForKey:identifier] nonretainedObjectValue];
}

-(UINib *)nibForCellReuseIdentifier:(NSString *)identifier
{
    return [self.nibForCellReuseIdentifier objectForKey:identifier];
}

#pragma mark -

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier
{
    [super registerClass:cellClass forCellWithReuseIdentifier:identifier];
    [self.classForCellReuseIdentifier setObject:[NSValue valueWithNonretainedObject:cellClass] forKey:identifier];
}

- (void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier
{
    [super registerNib:nib forCellWithReuseIdentifier:identifier];
    [self.nibForCellReuseIdentifier setObject:nib forKey:identifier];
}

#pragma mark - Getters

- (NSMutableDictionary *)classForCellReuseIdentifier
{
    if(!_classForCellReuseIdentifier){
        _classForCellReuseIdentifier = [[NSMutableDictionary alloc] init];
    }
    
    return _classForCellReuseIdentifier;
}

- (NSMutableDictionary *)nibForCellReuseIdentifier
{
    if(!_nibForCellReuseIdentifier){
        _nibForCellReuseIdentifier = [[NSMutableDictionary alloc] init];
    }
    
    return _nibForCellReuseIdentifier;
}

#pragma mark - Load More Button

- (WGFeedCollectionLoadMoreReusableView *)dequeueReusableLoadMoreViewForIndexPath:(NSIndexPath *)indexPath
{
    WGFeedCollectionLoadMoreReusableView *headerView = [super dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[WGFeedCollectionLoadMoreReusableView reuseIdentifier] forIndexPath:indexPath];
    return headerView;
}

@end
