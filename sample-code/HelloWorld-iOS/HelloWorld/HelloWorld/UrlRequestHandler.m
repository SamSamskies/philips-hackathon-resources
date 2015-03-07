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
 * UrlRequestHandler.m
 *
 * Created by Himanshu Shrivastava (hshrivastava@gmail.com)
 */

#import "UrlRequestHandler.h"

@interface UrlRequestHandler ()

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, copy)   NSURL *url;
@property (nonatomic, copy) NSURLRequest *urlRequest;
@property (nonatomic, strong) NSMutableData *downloadData;
@property (nonatomic, assign) NSInteger contentLength;

@property (nonatomic, assign) float previousMilestone;

@property (nonatomic, copy) UrlRequestHandlerCompletionBlock completionBlock;

@end

@implementation UrlRequestHandler

@synthesize url;
@synthesize urlRequest;
@synthesize connection;
@synthesize contentLength;
@synthesize downloadData;
@synthesize progressThreshold;
@synthesize previousMilestone;
@synthesize lastModified;
@synthesize responseCode;

@synthesize completionBlock;

- (void)dealloc {
    url = nil;
    urlRequest = nil;
    [connection cancel], connection = nil;
    downloadData = nil;
    completionBlock = nil;
	lastModified = nil;
    
}

+ (id)connectionWithRequest:(NSURLRequest *)request
            completionBlock:(UrlRequestHandlerCompletionBlock)completion {
    return [[self alloc] initWithRequest:request
                          completionBlock:completion];
}

+ (id)connectionWithURL:(NSURL *)downloadURL
        completionBlock:(UrlRequestHandlerCompletionBlock)completion {
    return [[self alloc] initWithURL:downloadURL
                      completionBlock:completion];
}

- (id)initWithURL:(NSURL *)requestURL
  completionBlock:(UrlRequestHandlerCompletionBlock)completion {
    return [self initWithRequest:[NSURLRequest requestWithURL:requestURL]
                 completionBlock:completion];
}

- (id)initWithRequest:(NSURLRequest *)request
      completionBlock:(UrlRequestHandlerCompletionBlock)completion {
    if ((self = [super init])) {
        urlRequest = [request copy];
        completionBlock = [completion copy];
        url = [[request URL] copy];
        progressThreshold = 1.0;
    }
    return self;
}

#pragma mark -

- (void)start {
	self.connection = [NSURLConnection connectionWithRequest:self.urlRequest delegate:self];
}

- (void)stop {
    [self.connection cancel];
    self.connection = nil;
    self.downloadData = nil;
    self.contentLength = 0;
    self.completionBlock = nil;
	self.lastModified = nil;
}

- (float)percentComplete {
    if (self.contentLength <= 0) return 0;
    return (([self.downloadData length] * 1.0f) / self.contentLength) * 100;
}

#pragma mark 
#pragma mark NSURLConnectionDelegate



- (void)connection:(NSURLConnection *)connection 
didReceiveResponse:(NSURLResponse *)response {
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (([httpResponse statusCode] == 200)||([httpResponse statusCode] == 304)) {
            NSDictionary *header = [httpResponse allHeaderFields];
            NSString *contentLen = [header valueForKey:@"Content-Length"];
            NSInteger length = self.contentLength = [contentLen integerValue];
			NSString* mod = [header valueForKey:@"Last-Modified"];
			self.lastModified = mod;
            self.downloadData = [NSMutableData dataWithCapacity:length];
        }
		self.responseCode = [httpResponse statusCode];		
    }
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data {
    [self.downloadData appendData:data];
    float pctComplete = floor([self percentComplete]);
    if ((pctComplete - self.previousMilestone) >= self.progressThreshold) {
        self.previousMilestone = pctComplete;
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (self.completionBlock) self.completionBlock(self, error);
    self.connection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (self.completionBlock) self.completionBlock(self, nil);
    self.connection = nil;
}

@end