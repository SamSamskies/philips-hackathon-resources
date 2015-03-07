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
 * OrganizationFeed.m
 * Extends from FeedManager, uses UrlRequestHandler to make calls to the server.
 * Keeps organization records
 *
 * Created by Himanshu Shrivastava (hshrivastava@gmail.com)
 */

#import <Foundation/Foundation.h>
#import "OrganizationFeed.h"
#import "LoginManager.h"
#import "UrlRequestHandler.h"
#import "FHIROrganization.h"
#import "FHIRParser.h"
#import "HSDPOrganization.h"

@interface OrganizationFeed ()

@end

@implementation OrganizationFeed


+ (NSString *) generateFeedUrlWithOrganizationId:(NSString *)inOrganizationUrlId
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", BASE_URL, BASE_FHIR_INFO_URL_PATH, inOrganizationUrlId];
    return urlString;
}


- (void) requestOrganizationInfoWithId: (NSString *) inOrganizationId completionBlock:(RequestCompletionBlock) inCompletion
{
    NSString *urlString = [OrganizationFeed generateFeedUrlWithOrganizationId:inOrganizationId];
    
    [self requestWithUrl: urlString completionBlock:inCompletion];
}


- (void) requestWithUrl: (NSString *)inUrlString completionBlock: (RequestCompletionBlock) inCompletion
{
    //NSLog(@"URL: %@", inUrlString);
    
    LoginManager *loginManager = [LoginManager sharedManager];
    NSString *authStringValue = [loginManager bearerAuthHeader];
    
    NSURL *url = [NSURL URLWithString:inUrlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:authStringValue forHTTPHeaderField:@"Authorization"];
    
    UrlRequestHandler *connection = [UrlRequestHandler connectionWithRequest:urlRequest
                                                             completionBlock: ^(UrlRequestHandler *inConnection, NSError *inError)
                                 {
                                     if (inConnection.responseCode != 200)
                                         inError = [NSError errorWithDomain: @"FHIR Error"
                                                                       code: inConnection.responseCode userInfo: nil];
                                     
                                     if ((inConnection.downloadData) && (inConnection.responseCode == 200))
                                     {
                                         NSDictionary* dict = [NSJSONSerialization JSONObjectWithData: inConnection.downloadData
                                                                                              options: 0 error: &inError];
                                         //NSLog (@"%@", dict);
                                         self.organizations = [[NSMutableArray alloc] init];
                                         
                                         [super updateFeedInfoWithDictionary: dict feedUrl: inUrlString];
                                         
                                         NSArray *organizationList = [dict objectForKey:@"entry"];
                                         
                                         if (organizationList == nil)
                                         {
                                             HSDPOrganization *organization = [[HSDPOrganization alloc] init];
                                             FHIROrganization *fhirOrganization = [FHIRParser loadObjectName:@"FHIROrganization" withDictionary:dict];
//                                             NSLog (@"%@", fhirOrganization.nameElement);
                                             [organization setOrganization:fhirOrganization];
                                             [self.organizations addObject:organization];
                                         }
                                         else
                                         {
                                             for (int i=0; i<organizationList.count; i++)
                                             {
                                                 NSDictionary *organizationDictionary = [organizationList objectAtIndex:i];
                                                 
                                                 HSDPOrganization *organization = [[HSDPOrganization alloc] init];
                                                 FHIROrganization *fhirOrganization = [FHIRParser loadObjectName:@"FHIROrganization" withDictionary:organizationDictionary];
//                                                 NSLog (@"%@", fhirOrganization.nameElement);
                                                 [organization setOrganization:fhirOrganization];
                                                 [self.organizations addObject:organization];
                                             }
                                         }
                                         //NSLog(@"DONE");
                                     }
                                     inCompletion(nil);
                                 }];
    [connection start];
}

@end