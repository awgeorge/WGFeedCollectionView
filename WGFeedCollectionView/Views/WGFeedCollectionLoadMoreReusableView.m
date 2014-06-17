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

#import "WGFeedCollectionLoadMoreReusableView.h"

@implementation WGFeedCollectionLoadMoreReusableView
{
    UIActivityIndicatorView *indicator;
}

+ (NSString *)reuseIdentifier
{
    NSAssert([NSStringFromClass(self) isEqualToString:@"WGFeedCollectionLoadMoreReusableView"], @"ERROR: method must be overridden in subclasses: %s", __PRETTY_FUNCTION__);
    return @"WGFeedCollectionLoadMoreReusableViewIdentifier";
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithWhite:0.954 alpha:1.0];
    }
    return self;
}

-(void)layoutSubviews
{
    [self.loadMoreButton setFrame:CGRectInset(self.bounds, 10, 5)];
}

#pragma mark - Getters

-(UIButton *)loadMoreButton
{
    if(!_loadMoreButton){
        _loadMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loadMoreButton addTarget:self action:@selector(didSelectLoadMorePosts:) forControlEvents:UIControlEventTouchUpInside];
        [_loadMoreButton setTitle:@"Load more posts..." forState:UIControlStateNormal];
        [_loadMoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _loadMoreButton.titleLabel.font = [UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody] size:0.0];
        [self addSubview:_loadMoreButton];
    }
    
    return _loadMoreButton;
}

-(void)didSelectLoadMorePosts:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (!indicator) {
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [button addSubview:indicator];
    }
    
    CGFloat halfButtonHeight = button.bounds.size.height / 2;
    CGFloat buttonWidth = button.bounds.size.width;
    indicator.center = CGPointMake(buttonWidth - halfButtonHeight , halfButtonHeight);
    [indicator startAnimating];
}

#pragma mark - Collection View Cell

-(void)prepareForReuse
{
    [indicator stopAnimating];
}

@end
