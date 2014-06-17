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

#import "WGFeedCollectionViewFlowLayout.h"

#import "WGFeedCollectionView.h"
#import "WGFeedCollectionViewCell.h"
#import "WGFeedCollectionViewDataSource.h"
#import "WGFeedCollectionViewLayoutAttributes.h"


@class WGFeedCollectionViewDataSource;
@interface WGFeedCollectionViewFlowLayout (){
    
    struct {
        UIEdgeInsets insets;
        BOOL initialized;
    } _postContainerInnerInset;
    
    struct {
        UIEdgeInsets insets;
        BOOL initialized;
    } _postContainerOuterInset;
    
}
    @property (strong, nonatomic) NSMutableDictionary *cachedPostSizes;
@end

@implementation WGFeedCollectionViewFlowLayout
@dynamic postContainerInnerInset;
@dynamic postContainerOuterInset;

+ (Class)layoutAttributesClass
{
    return [WGFeedCollectionViewLayoutAttributes class];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.minimumLineSpacing = 5.0;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.minimumLineSpacing = 0.0;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:rect];
    [layoutAttributes enumerateObjectsUsingBlock:^(WGFeedCollectionViewLayoutAttributes *layoutAttributes, NSUInteger idx, BOOL *stop) {
        [self configureMessageCellLayoutAttributes:layoutAttributes];
    }];
    
    return layoutAttributes;
}

- (WGFeedCollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WGFeedCollectionViewLayoutAttributes *layoutAttributes = (WGFeedCollectionViewLayoutAttributes *)[super layoutAttributesForItemAtIndexPath:indexPath];
    [self configureMessageCellLayoutAttributes:layoutAttributes];
    return layoutAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    
    return NO;
}

#pragma mark - Setters

- (void)setPostContainerInnerInset:(UIEdgeInsets)postContainerInnerInset
{
    _postContainerInnerInset.insets = postContainerInnerInset;
    _postContainerInnerInset.initialized = YES;
}

- (void)setPostContainerOuterInset:(UIEdgeInsets)postContainerOuterInset
{
    _postContainerOuterInset.insets = postContainerOuterInset;
    _postContainerOuterInset.initialized = YES;
}

#pragma mark - Getters

- (UIFont *)titleFont
{
    if(!_titleFont){
        _titleFont = [UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleHeadline] size:0.0];
    }
    
    return _titleFont;
}

- (UIFont *)messageFont
{
    if(!_messageFont){
        _messageFont = [UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody] size:0.0];
    }
    
    return _messageFont;
}

- (UIFont *)dateFont
{
    if(!_dateFont){
        _dateFont = [UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleFootnote] size:0.0];
    }
    
    return _dateFont;
}

- (UIEdgeInsets)postContainerInnerInset
{
    if(!_postContainerInnerInset.initialized){
        self.postContainerInnerInset = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    
    return _postContainerInnerInset.insets;
}

- (UIEdgeInsets)postContainerOuterInset
{
    if(!_postContainerOuterInset.initialized){
        self.postContainerOuterInset = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    
    return _postContainerOuterInset.insets;
}

- (NSMutableDictionary *)cachedPostSizes
{
    if(!_cachedPostSizes){
        _cachedPostSizes = [[NSMutableDictionary alloc] init];
    }
    
    return _cachedPostSizes;
}

#pragma mark -

- (CGFloat)heightForItemCell:(Class)cellClass atIndexPath:(NSIndexPath *)indexPath constrainedToSize:(CGSize)size
{
    NSNumber *cachedHeight = [self.cachedPostSizes objectForKey:indexPath];
    if(cachedHeight){
        return [cachedHeight floatValue];
    }
    
    CGFloat postHeight = 0.0f;
    if(cellClass){
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wundeclared-selector"
        //if([cellClass resolveClassMethod:@selector(sizeWithPost:attributes:constrainedToSize:)]){
            WGPost *post = [self.collectionView.dataSource collectionView:self.collectionView postForItemAtIndexPath:indexPath];
            postHeight = [(NSValue *)[cellClass sizeWithPost:post attributes:[self layoutAttributesForItemAtIndexPath:indexPath] constrainedToSize:size] CGSizeValue].height;
        //}
//#pragma clang diagnostic pop
    }
    
    [self.cachedPostSizes setObject:@(postHeight) forKey:indexPath];
    return postHeight;
}

#pragma mark - Internal Helpers

- (void)configureMessageCellLayoutAttributes:(WGFeedCollectionViewLayoutAttributes *)layoutAttributes
{
    layoutAttributes.titleFont = self.titleFont;
    layoutAttributes.messageFont = self.messageFont;
    layoutAttributes.dateFont = self.dateFont;
    
    layoutAttributes.postContainerOuterInset = self.postContainerOuterInset;
    layoutAttributes.postContainerInnerInset = self.postContainerInnerInset;
}

@end
