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

#import "WGFeedCollectionViewCell.h"

//WGFeed
#import "WGPost.h"
#import "WGFeedCollectionViewLayoutAttributes.h"

@interface WGFeedCollectionViewCell ()
    @property(nonatomic, strong, readonly) UIFont *titleFont;
    @property(nonatomic, strong, readonly) UIFont *messageFont;
    @property(nonatomic, strong, readonly) UIFont *dateFont;
    @property(nonatomic, assign, readonly) UIEdgeInsets postContainerOuterInset;
    @property(nonatomic, assign, readonly) UIEdgeInsets postContainerInnerInset;
    @property(nonatomic, assign, readonly) CGFloat maxWidth;


    @property(nonatomic, assign) BOOL calculateSize;
@end

@implementation WGFeedCollectionViewCell
@synthesize postContainerOuterInset = _postContainerOuterInset;
@synthesize postContainerInnerInset = _postContainerInnerInset;

+ (NSString *)cellReuseIdentifier
{
    NSAssert([NSStringFromClass(self) isEqualToString:@"WGFeedCollectionViewCell"], @"ERROR: method must be overridden in subclasses: %s", __PRETTY_FUNCTION__);
    return @"WGFeedCollectionViewCellIdentifier";
}

#pragma mark -

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        self.contentMode = UIViewContentModeRedraw;
        
        //Make Cell Content View
        self.contentView.frame = CGRectZero;
        self.contentView.layer.cornerRadius = 10.0f;
    }
    
    return self;
}

#pragma mark - Getters

-(UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = self.titleFont;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

-(UITextView *)messageTextView
{
    if(!_messageTextView){
        _messageTextView = [[UITextView alloc] init];
        _messageTextView.font = self.messageFont;
        _messageTextView.backgroundColor = [UIColor clearColor];
        _messageTextView.textAlignment = NSTextAlignmentLeft;
        _messageTextView.editable = NO;
        _messageTextView.selectable = YES;
        _messageTextView.userInteractionEnabled = YES;
        _messageTextView.dataDetectorTypes = UIDataDetectorTypeNone;
        _messageTextView.showsHorizontalScrollIndicator = NO;
        _messageTextView.showsVerticalScrollIndicator = NO;
        _messageTextView.scrollEnabled = NO;
        _messageTextView.textContainer.lineFragmentPadding = 0;
        _messageTextView.contentInset = UIEdgeInsetsZero;
        _messageTextView.textContainerInset = UIEdgeInsetsZero;
        _messageTextView.scrollIndicatorInsets = UIEdgeInsetsZero;
        _messageTextView.contentOffset = CGPointZero;
        _messageTextView.linkTextAttributes = @{
            NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid)
        };
        
        [self.contentView addSubview:_messageTextView];
        
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognizer:)];
        longPressGestureRecognizer.minimumPressDuration = 0.4f;
        [self addGestureRecognizer:longPressGestureRecognizer];
    }
    
    return _messageTextView;
}

-(UILabel *)dateLabel
{
    if(!_dateLabel){
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = self.dateFont;
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.numberOfLines = 1;
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_dateLabel];
    }
    
    return _dateLabel;
}
-(UIImageView *)iconImageView
{
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc] init];
        [self addSubview:_iconImageView];
    }
    
    return _iconImageView;
}

-(NSString *)dateFormat
{
    if(!_dateFormat){
        _dateFormat = @"HH:mm, dd MMM yyyy jj";
    }
    return _dateFormat;
}

-(CGFloat)maxWidth
{
    return CGRectGetWidth(self.frame) - self.postContainerOuterInset.left - self.postContainerOuterInset.right;
}

-(UIEdgeInsets)postContainerOuterInset
{
    if(self.position == WGPostPositionPositionRight){
        return UIEdgeInsetsMake(_postContainerOuterInset.top, _postContainerOuterInset.right, _postContainerOuterInset.bottom, _postContainerOuterInset.left);
    }
    
    return _postContainerOuterInset;
}

-(UIEdgeInsets)postContainerInnerInset
{
    if(self.position == WGPostPositionPositionRight){
        return UIEdgeInsetsMake(_postContainerInnerInset.top, _postContainerInnerInset.right, _postContainerInnerInset.bottom, _postContainerInnerInset.left);
    }
    
    return _postContainerInnerInset;
}

#pragma mark - Setters

-(void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

-(void)setMessage:(NSString *)message
{
    _message = message;
    self.messageTextView.text = message;
}

-(void)setDate:(NSDate *)date
{
    _date = date;
    self.dateLabel.text = [self.date description];//[self.date stringWithLocalisedFormat:self.dateFormat];
}

-(void)setIcon:(UIImage *)icon
{
    _icon = icon;
    self.iconImageView.image = icon;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:[UIColor clearColor]];
    self.contentView.backgroundColor = backgroundColor;
}

#pragma mark -

-(void)layoutSubviews
{
    CGFloat postContentWidth = self.maxWidth - self.postContainerInnerInset.left - self.postContainerInnerInset.right;
    
    //Set Up Title Size
    CGSize titleLabelSize = [_titleLabel sizeThatFits:CGSizeMake(postContentWidth, CGFLOAT_MAX)];
    _titleLabel.frame = CGRectMake(self.postContainerInnerInset.left, self.postContainerInnerInset.top, titleLabelSize.width, titleLabelSize.height);
    self.contentView.frame = CGRectUnion(_titleLabel.frame, self.contentView.frame);
    
    //Set Up Message Size
    CGSize messageLabelSize = [_messageTextView sizeThatFits:CGSizeMake(postContentWidth, CGFLOAT_MAX)];
    _messageTextView.frame = CGRectMake(self.postContainerInnerInset.left, CGRectGetMaxY(_titleLabel.frame), messageLabelSize.width, messageLabelSize.height);
    self.contentView.frame = CGRectUnion(_messageTextView.frame, self.contentView.frame);
    
    //Set Up Icon
    _iconImageView.frame = CGRectMake(self.postContainerOuterInset.left, 0, _iconImageView.image.size.width, _iconImageView.image.size.height);
    CGPoint iconOffset = {MAX(0, CGRectGetWidth(_iconImageView.frame) - 10), MAX(0, CGRectGetWidth(_iconImageView.frame) - 15)};
    self.contentView.frame = CGRectOffset(self.contentView.frame, CGRectGetWidth(_iconImageView.frame) / 2, 0);
    
    //Add Right + Bottom Padding.
    CGRect contentViewFrame = self.contentView.frame;
    contentViewFrame.origin.x = self.postContainerOuterInset.left;
    contentViewFrame.origin.y = self.postContainerOuterInset.top;
    contentViewFrame.size.width += self.postContainerInnerInset.right;
    contentViewFrame.size.height += self.postContainerInnerInset.bottom;
    self.contentView.frame = contentViewFrame;
    
    //Set Up Date
    CGSize dateLabelSize = [_dateLabel sizeThatFits:CGSizeMake(postContentWidth, CGFLOAT_MAX)];
    _dateLabel.frame = CGRectMake(self.postContainerOuterInset.left, CGRectGetMaxY(self.contentView.frame), dateLabelSize.width, dateLabelSize.height);
    
    //
    CGFloat contentViewWidth = CGRectGetWidth(self.contentView.frame);
    switch(self.position){
        case WGPostPositionPositionLeft:
            self.contentView.frame = CGRectMake(self.postContainerOuterInset.left + iconOffset.x, iconOffset.y, contentViewWidth, CGRectGetHeight(self.contentView.frame));
            _dateLabel.frame = CGRectOffset(_dateLabel.frame, iconOffset.x, iconOffset.y);
            break;
        case WGPostPositionPositionRight:{
            CGFloat contentViewXOffset = self.maxWidth - contentViewWidth;
            self.contentView.frame = CGRectMake(self.postContainerOuterInset.left + contentViewXOffset - iconOffset.x, iconOffset.y, contentViewWidth, CGRectGetHeight(self.contentView.frame));
            _iconImageView.frame = CGRectOffset(_iconImageView.frame, contentViewWidth - CGRectGetWidth(_iconImageView.frame) + contentViewXOffset, 0);
            _dateLabel.frame = CGRectOffset(_dateLabel.frame, contentViewWidth - CGRectGetWidth(_dateLabel.frame) + contentViewXOffset - iconOffset.x, iconOffset.y);
        }
        break;
    }
    
    //Set Frame -
    if(self.calculateSize){
        CGRect cellFrame = self.frame;
        cellFrame.size.height = CGRectGetHeight(CGRectUnion(CGRectUnion(_iconImageView.frame, _dateLabel.frame), self.contentView.frame))
                                + self.postContainerOuterInset.top
                                + self.postContainerOuterInset.bottom;
        self.frame = cellFrame;
    }
}

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)becomeFirstResponder
{
    return [super becomeFirstResponder];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return (action == @selector(copy:));
}

- (void)copy:(id)sender
{
    [[UIPasteboard generalPasteboard] setString:self.message];
    [self resignFirstResponder];
}

#pragma mark - Gesture recognizers

- (void)longPressGestureRecognizer:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state != UIGestureRecognizerStateBegan || ![self becomeFirstResponder]) {
        return;
    }
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    CGRect targetRect = [self convertRect:self.contentView.frame fromView:self.contentView];
    
    [self setHighlighted:YES];
    
    [menu setTargetRect:CGRectInset(targetRect, 0.0f, 4.0f) inView:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillShowNotification:) name:UIMenuControllerWillShowMenuNotification object:menu];
    
    [menu setMenuVisible:YES animated:YES];
}


#pragma mark - Notifications

- (void)menuWillHideNotification:(NSNotification *)notification
{
    [self setHighlighted:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillHideMenuNotification object:nil];
}

- (void)menuWillShowNotification:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillShowMenuNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillHideNotification:) name:UIMenuControllerWillHideMenuNotification object:notification.object];
}

#pragma mark - Collection View Cell

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    self.contentView.frame = CGRectZero;
    self.title = nil;
    self.message = nil;
    self.date = nil;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    WGFeedCollectionViewLayoutAttributes *customAttributes = (WGFeedCollectionViewLayoutAttributes *)layoutAttributes;
    
    //Fonts
    _titleFont = customAttributes.titleFont;
    _messageFont = customAttributes.messageFont;
    _dateFont = customAttributes.dateFont;
    
    //Layout
    _postContainerInnerInset = customAttributes.postContainerInnerInset;
    _postContainerOuterInset = customAttributes.postContainerOuterInset;
}


+(NSValue *)sizeWithPost:(WGPost *)post attributes:(WGFeedCollectionViewLayoutAttributes *)layoutAttributes constrainedToSize:(CGSize)size
{
    WGFeedCollectionViewCell *tempCell = [[WGFeedCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [tempCell applyLayoutAttributes:layoutAttributes];
    tempCell.title = post.title;
    tempCell.message = post.message;
    tempCell.date = post.postedDate;
    tempCell.calculateSize = YES;
    [tempCell layoutIfNeeded];
    
    return [NSValue valueWithCGSize:(CGSize){CGRectGetWidth(tempCell.contentView.frame), CGRectGetHeight(tempCell.frame)}];
}


@end
