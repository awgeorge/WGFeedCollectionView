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

#import <UIKit/UIKit.h>

/**
 *  Positioning Enum
 */
typedef enum {
    WGPostPositionPositionLeft = -1,
    WGPostPositionPositionCenter = 0, // Not Implemented
    WGPostPositionPositionRight = 1
} _WGPostPosition;
typedef signed short WGPostPosition;

@protocol WGFeedCollectionViewCellDelegate <NSObject>



@end

@class WGPost;
@class WGFeedCollectionViewLayoutAttributes;
@interface WGFeedCollectionViewCell : UICollectionViewCell

/**
 *  Public Properties
 */
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *message;
@property(nonatomic, retain) UIImage *icon;
@property(nonatomic, retain) NSDate *date;
@property(nonatomic, copy) NSString *dateFormat;
@property(nonatomic, assign) WGPostPosition position;

@property(nonatomic, retain) UILabel *titleLabel;
@property(nonatomic, retain) UITextView *messageTextView;
@property(nonatomic, retain) UILabel *dateLabel;
@property(nonatomic, retain) UIImageView *iconImageView;

/**
 *  Class Methods
 */
+ (NSString *)cellReuseIdentifier;
+ (NSValue *)sizeWithPost:(WGPost *)post attributes:(WGFeedCollectionViewLayoutAttributes *)layoutAttributes constrainedToSize:(CGSize)size;

@end
