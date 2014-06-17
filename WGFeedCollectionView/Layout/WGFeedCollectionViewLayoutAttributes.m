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

#import "WGFeedCollectionViewLayoutAttributes.h"

@implementation WGFeedCollectionViewLayoutAttributes

- (void)dealloc
{
    _titleFont = nil;
    _messageFont = nil;
    _dateFont = nil;
}

#pragma mark - Setters

- (void)setTitleFont:(UIFont *)font
{
    NSParameterAssert(font);
    _titleFont = font;
}

- (void)setMessageFont:(UIFont *)font
{
    NSParameterAssert(font);
    _messageFont = font;
}

- (void)setDateFont:(UIFont *)font
{
    NSParameterAssert(font);
    _dateFont = font;
}

#pragma mark - 

- (BOOL)isEqual:(id)object
{
    if(self == object){
        return YES;
    }
    
    if(![object isKindOfClass:[self class]]){
        return NO;
    }
    
    WGFeedCollectionViewLayoutAttributes *layoutAttributes = (WGFeedCollectionViewLayoutAttributes *)object;
    if(![layoutAttributes.titleFont isEqual:self.titleFont]
       || ![layoutAttributes.messageFont isEqual:self.messageFont]
       || ![layoutAttributes.dateFont isEqual:self.dateFont]
       || !UIEdgeInsetsEqualToEdgeInsets(layoutAttributes.postContainerOuterInset, self.postContainerOuterInset)
       || !UIEdgeInsetsEqualToEdgeInsets(layoutAttributes.postContainerInnerInset, self.postContainerInnerInset))
    {
        return NO;
    }
    
    return [super isEqual:object];
}

- (NSUInteger)hash
{
    return [self.indexPath hash];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    WGFeedCollectionViewLayoutAttributes *copy = [super copyWithZone:zone];
    copy.titleFont = self.titleFont;
    copy.messageFont = self.messageFont;
    copy.dateFont = self.dateFont;
    copy.postContainerOuterInset = self.postContainerOuterInset;
    copy.postContainerInnerInset = self.postContainerInnerInset;
    return copy;
}

@end
