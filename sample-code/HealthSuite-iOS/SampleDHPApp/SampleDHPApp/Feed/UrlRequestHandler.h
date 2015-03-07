/**
 * Copyright (c) 2014-2015 Koninklijke Philips N.V.
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * UrlRequestHandler.h
 * A utility class to handle REST calls using blocks
 *
 * Created by Himanshu Shrivastava (hshrivastava@gmail.com)
 */

#import <UIKit/UIKit.h>

@class UrlRequestHandler;

typedef void (^UrlRequestHandlerCompletionBlock)(UrlRequestHandler *connection, NSError *error);

@interface UrlRequestHandler : NSObject {}

@property (nonatomic, copy, readonly) NSURL *url;
@property (nonatomic, copy, readonly) NSURLRequest *urlRequest;
@property (nonatomic, assign, readonly) NSInteger contentLength;
@property (nonatomic, strong, readonly) NSMutableData *downloadData;
@property (nonatomic, assign, readonly) float percentComplete;
@property (nonatomic, assign) NSUInteger progressThreshold;
@property (nonatomic, assign) NSInteger responseCode;
@property (nonatomic, copy) NSString* lastModified;

+ (id)connectionWithURL:(NSURL *)requestURL completionBlock:(UrlRequestHandlerCompletionBlock)completion;
+ (id)connectionWithRequest:(NSURLRequest *)request completionBlock:(UrlRequestHandlerCompletionBlock)completion;
- (id)initWithURL:(NSURL *)requestURL completionBlock:(UrlRequestHandlerCompletionBlock)completion;
- (id)initWithRequest:(NSURLRequest *)request completionBlock:(UrlRequestHandlerCompletionBlock)completion;

- (void)start;
- (void)stop;

@end