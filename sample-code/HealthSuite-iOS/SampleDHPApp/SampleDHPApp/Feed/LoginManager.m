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
 * LoginManager.m
 * Responsible for login/logout and keeping the token information.
 *
 * Created by Himanshu Shrivastava (hshrivastava@gmail.com)
 */

#import <Foundation/Foundation.h>
#import "LoginManager.h"
#import "UrlRequestHandler.h"

@interface LoginManager ()

@end

@implementation LoginManager

@synthesize accessToken, patientUrlIdString, organizationUrlIdString;

+ (id) sharedManager
{
    static LoginManager *sharedLoginManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLoginManager = [[self alloc] init];
    });
    return sharedLoginManager;
}



- (id) init
{
    if (self == [super init])
    {
        self.accessToken = nil;
        self.patientUrlIdString = nil;
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



- (void) requestAccessTokenAndLoginForUser: (NSString *)inUser
                                  password: (NSString *)inPassword
                      tokenCompletionBlock: (RequestCompletionBlock) inTokenRequestCompletionBlock
                      loginCompletionBlock: (RequestCompletionBlock) inLoginCompletionBlock
{
    NSString *tokenUrl = [NSString stringWithFormat:@"%@%@%@", BASE_URL, BASE_URL_AUTH_URL_PATH, BASE_URL_AUTH_TOKEN_PATH];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:tokenUrl]];
//    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [urlRequest setValue: [LoginManager authHeader] forHTTPHeaderField: @"Authorization"];
    [urlRequest setHTTPMethod:@"POST"];
    
    UrlRequestHandlerCompletionBlock urlReqCompletionBlock = ^(UrlRequestHandler *inConnection, NSError *inError)
    {
        if (inConnection.responseCode != 200)
        {
            inError = [NSError errorWithDomain: @"FHIR Error" code: inConnection.responseCode userInfo: nil];
            inTokenRequestCompletionBlock(inError);
        }
        
        if ((inConnection.downloadData) && (inConnection.responseCode == 200))
        {
            NSDictionary* dict = [NSJSONSerialization JSONObjectWithData: inConnection.downloadData options: 0 error: &inError];
            
            //NSLog(@"Dict: %@", dict);
            [self setAccessToken:[dict valueForKey:@"access_token"]];
            
            inTokenRequestCompletionBlock(nil);
            
            [self authenticateUserWithTokenForUser:inUser password:inPassword completionBlock: inLoginCompletionBlock];
        }
    };
    
    UrlRequestHandler *urlReq = [UrlRequestHandler connectionWithRequest:urlRequest
                                                        completionBlock: urlReqCompletionBlock
                                    ];
    [urlReq start];
}



- (void) authenticateUserWithTokenForUser: (NSString *)inUser
                                 password: (NSString *)inPwd
                          completionBlock: (RequestCompletionBlock)inLoginRequestCompletionBlock
{
    NSError *error;
    NSDictionary *requestData = [[NSDictionary alloc] initWithObjectsAndKeys: inUser, @"username",
                                 inPwd, @"password",
                                 nil];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestData options:0 error:&error];
    
    NSString *loginUrl = [NSString stringWithFormat:@"%@%@%@", BASE_URL, BASE_URL_AUTH_URL_PATH, BASE_URL_AUTH_LOGIN_PATH];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:loginUrl]];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [urlRequest setValue: [self bearerAuthHeader] forHTTPHeaderField: @"Authorization"];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:postData];
    
    UrlRequestHandlerCompletionBlock urlRequestCompletionBlock = ^(UrlRequestHandler *inConnection, NSError *inError)
    {
        if (inConnection.responseCode != 200)
        {
            inError = [NSError errorWithDomain: @"FHIR Error" code: inConnection.responseCode userInfo: nil];
            
            inLoginRequestCompletionBlock (inError);
        }
        
        if ((inConnection.downloadData) && (inConnection.responseCode == 200))
        {
            NSDictionary* dict = [NSJSONSerialization JSONObjectWithData: inConnection.downloadData options: 0 error: &inError];
            
            //NSLog(@"Dict: %@", dict);
            LoginManager *loginManager = [LoginManager sharedManager];
            
            [loginManager setPatientUrlIdString:[[dict valueForKey:@"user"] valueForKey:@"fhir_patient_id"]];
            [loginManager setOrganizationUrlIdString:[[dict valueForKey:@"user"] valueForKey:@"fhir_organization_id"]];
            
            inLoginRequestCompletionBlock (nil);
        }
    };
    
    UrlRequestHandler *urlReq = [UrlRequestHandler connectionWithRequest:urlRequest
                                                        completionBlock: urlRequestCompletionBlock
                                    ];
    [urlReq start];
    
}

- (void) logout:(RequestCompletionBlock)inLogoutRequestCompletionBlock
{
    NSString *logoutUrl = [NSString stringWithFormat:@"%@%@%@", BASE_URL, BASE_URL_AUTH_URL_PATH, BASE_URL_AUTH_LOGOUT_PATH];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:logoutUrl]];
//    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [urlRequest setValue: [self bearerAuthHeader] forHTTPHeaderField: @"Authorization"];
    [urlRequest setHTTPMethod:@"DELETE"];
    
    UrlRequestHandlerCompletionBlock urlRequestCompletionBlock = ^(UrlRequestHandler *inConnection, NSError *inError)
    {
        if (inConnection.responseCode != 200)
        {
            inError = [NSError errorWithDomain: @"FHIR Error" code: inConnection.responseCode userInfo: nil];
            
            inLogoutRequestCompletionBlock (inError);
        }
        else
        {
            accessToken = nil;
            patientUrlIdString=nil;
            organizationUrlIdString = nil;
            
            inLogoutRequestCompletionBlock (nil);
        }
    };
    
    UrlRequestHandler *urlRequestHandler = [UrlRequestHandler connectionWithRequest:urlRequest
                                                        completionBlock: urlRequestCompletionBlock
                                    ];
    [urlRequestHandler start];
}



@end