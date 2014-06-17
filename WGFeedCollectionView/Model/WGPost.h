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

#import <Foundation/Foundation.h>

/**
 *  Positioning Enum
 */
typedef enum {
    WGPostTypeDefault = 0
} _WGPostType;
typedef signed short WGPostType;

@interface WGPost : NSObject

/**
 *  Public Properties
 */
@property(nonatomic, copy) NSString *ID;
@property(nonatomic, retain) NSNumber *remoteID;
@property(nonatomic, assign) WGPostType type;
@property(nonatomic, assign) BOOL pinned;

@property(nonatomic, copy) NSString *ownerID;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *message;
@property(nonatomic, copy) NSArray *images;
@property(nonatomic, copy) NSArray *comments;
@property(nonatomic, copy) NSArray *urls;

@property(nonatomic, retain) NSDate *createdDate;
@property(nonatomic, retain) NSDate *postedDate;
@property(nonatomic, retain) NSDate *modifiedDate;

/**
 *  Public Methods
 */
-(id)initWithID:(NSString *)ID;

@end
