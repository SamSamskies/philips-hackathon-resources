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
 * HelloWorldManager.m
 * Singleton that contains following calls used for interacting with server
 * - Get Bearer Token by using the consumer key and secret
 * - Get HelloWorld message from server
 *
 * Created by Himanshu Shrivastava (hshrivastava@gmail.com)
 */

#import <Foundation/Foundation.h>
#import "HelloWorldManager.h"
#import "UrlRequestHandler.h"

@interface HelloWorldManager ()

@end

@implementation HelloWorldManager

@synthesize accessToken;

+ (id) sharedManager
{
    static HelloWorldManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}



- (id) init
{
    if (self == [super init])
    {
        self.accessToken = nil;
    }
    return self;
}



+ (NSString *) authHeader
{
    NSString *authString = [NSString stringWithFormat:@"%@:%@", CLIENT_ID, CLIENT_SECRET];
    NSData *authorizatontionData = [authString dataUsingEncoding:NSASCIIStringEncoding];
    NSString *base64EncodedAuthData = [authorizatontionData base64EncodedStringWithOptions:0];
    NSString *authHeader = [NSString stringWithFormat:@"Basic %@", base64EncodedAuthData];
    
    return authHeader;
}



- (NSString *) bearerAuthHeader
{
    return [NSString stringWithFormat:@"Bearer %@", accessToken];
}



- (void) requestAccessTokenWithCompletionBlock: (RequestCompletionBlock) inTokenRequestCompletionBlock
{
    NSString *tokenUrl = [NSString stringWithFormat:@"%@%@%@", BASE_URL, BASE_URL_AUTH_URL_PATH, BASE_URL_AUTH_TOKEN_PATH];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:tokenUrl]];
    [urlRequest setValue: [HelloWorldManager authHeader] forHTTPHeaderField: @"Authorization"];
    [urlRequest setHTTPMethod:@"POST"];
    
    UrlRequestHandlerCompletionBlock urlReqCompletionBlock = ^(UrlRequestHandler *inConnection, NSError *inError)
    {
        if (inConnection.responseCode != 200)
        {
            inError = [NSError errorWithDomain: @"FHIR Error" code: inConnection.responseCode userInfo: nil];
            inTokenRequestCompletionBlock(inError, @"Error");
        }
        
        if ((inConnection.downloadData) && (inConnection.responseCode == 200))
        {
            NSDictionary* dict = [NSJSONSerialization JSONObjectWithData: inConnection.downloadData options: 0 error: &inError];
            
//            NSLog(@"Dict: %@", dict);
            [self setAccessToken:[dict valueForKey:@"access_token"]];
            
            inTokenRequestCompletionBlock(nil, [dict valueForKey:@"access_token"]);
        }
    };
    
    UrlRequestHandler *urlReq = [UrlRequestHandler connectionWithRequest:urlRequest
                                                        completionBlock: urlReqCompletionBlock
                                    ];
    [urlReq start];
}

- (void) requestHelloWorldCompletionBlock: (RequestCompletionBlock) inHelloWorldRequestCompletionBlock
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", BASE_URL, BASE_URL_HELLO_WORLD_PATH];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlString]];
    [urlRequest setValue: [[HelloWorldManager sharedManager] bearerAuthHeader] forHTTPHeaderField: @"Authorization"];
    [urlRequest setValue:@"text/plain" forHTTPHeaderField:@"Accept"];
    [urlRequest setHTTPMethod:@"GET"];

    
    UrlRequestHandlerCompletionBlock urlReqCompletionBlock = ^(UrlRequestHandler *inConnection, NSError *inError)
    {
        if (inConnection.responseCode != 200)
        {
            inError = [NSError errorWithDomain: @"FHIR Error" code: inConnection.responseCode userInfo: nil];
            inHelloWorldRequestCompletionBlock(inError, @"Error");
        }
        
        if ((inConnection.downloadData) && (inConnection.responseCode == 200))
        {
            NSString *response = [[NSString alloc] initWithData:inConnection.downloadData encoding:NSNonLossyASCIIStringEncoding];
            inHelloWorldRequestCompletionBlock(nil, response);
        }
    };
    
    UrlRequestHandler *urlReq = [UrlRequestHandler connectionWithRequest:urlRequest
                                                         completionBlock: urlReqCompletionBlock
                                 ];
    [urlReq start];
}


@end