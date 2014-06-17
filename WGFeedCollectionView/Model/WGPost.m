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

#import "WGPost.h"

@implementation WGPost

-(id)initWithID:(NSString *)ID
{
    if(self = [super init]){
        self.ID = ID;
    }
    return self;
}

#pragma mark - Getters

-(NSString *)description
{
    return [NSString stringWithFormat:@"ID: %@ Title: %@ Date: %@", self.ID, self.title, self.postedDate];
}

#pragma mark -

-(NSInteger)refresh
{
    return 1;
}

-(BOOL)isEqual:(id)object
{
    return [object isKindOfClass:[self class]] && [self.ID isEqualToString:((WGPost *)object).ID];
}

-(NSUInteger)hash
{
    return [self.ID hash];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    if(self = [super init]){
        self.ID = [decoder decodeObjectForKey:@"ID"];
        self.remoteID = [decoder decodeObjectForKey:@"remoteID"];
        self.pinned = [decoder decodeIntegerForKey:@"pinned"];
        self.ownerID = [decoder decodeObjectForKey:@"ownerID"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.message = [decoder decodeObjectForKey:@"message"];
        self.images = [decoder decodeObjectForKey:@"images"];
        self.comments = [decoder decodeObjectForKey:@"comments"];
        self.urls = [decoder decodeObjectForKey:@"urls"];
        self.type = [decoder decodeIntegerForKey:@"type"];
        self.createdDate = [decoder decodeObjectForKey:@"createdDate"];
        self.postedDate = [decoder decodeObjectForKey:@"postedDate"];
        self.modifiedDate = [decoder decodeObjectForKey:@"modifiedDate"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.ID forKey:@"ID"];
    [encoder encodeObject:self.remoteID forKey:@"remoteID"];
    [encoder encodeInteger:self.pinned forKey:@"pinned"];
    [encoder encodeObject:self.ownerID forKey:@"ownerID"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.message forKey:@"message"];
    [encoder encodeObject:self.images forKey:@"images"];
    [encoder encodeObject:self.comments forKey:@"comments"];
    [encoder encodeObject:self.urls forKey:@"urls"];
    [encoder encodeInteger:self.type forKey:@"type"];
    [encoder encodeObject:self.createdDate forKey:@"createdDate"];
    [encoder encodeObject:self.postedDate forKey:@"postedDate"];
    [encoder encodeObject:self.modifiedDate forKey:@"modifiedDate"];
}

@end
