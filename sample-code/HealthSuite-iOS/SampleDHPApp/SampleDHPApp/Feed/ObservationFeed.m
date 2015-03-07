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
 * ObservationFeed.m
 * Extends from FeedManager, uses UrlRequestHandler to make calls to the server. 
 * Keeps observation records
 *
 * Created by Himanshu Shrivastava (hshrivastava@gmail.com)
 */

#import <Foundation/Foundation.h>
#import "ObservationFeed.h"
#import "LoginManager.h"
#import "UrlRequestHandler.h"
#import "HSDPObservation.h"
#import "FHIRParser.h"

@interface ObservationFeed ()

@end

@implementation ObservationFeed



- (NSString *) generateObservationFeedUrlForPatientId: (NSString *) inPatientId
                         withObservation: (NSString *) inObservations
                               withDate1: (NSString *) inDate1
                               withDate2: (NSString *) inDate2
{
    NSMutableString *urlString = [[ NSMutableString alloc] initWithString: BASE_URL];
    [urlString appendString:BASE_FHIR_INFO_URL_PATH];
    [urlString appendString:BASE_FHIR_INFO_OBSERVATION_PATH];
    [urlString appendString:@"?subject._id="];
    [urlString appendString:inPatientId];
    
    if (inObservations.length != 0)
    {
        [urlString appendString:@"&name="];
        [urlString appendString:[inObservations stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    if (inDate1.length != 0)
    {
        [urlString appendString:@"&date="];
        [urlString appendString:[inDate1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    if (inDate2.length != 0)
    {
        [urlString appendString:@"&date="];
        [urlString appendString:[inDate2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    return urlString;
}



- (void) requestObservationsForPatientId: (NSString *) inPatientId
                         withObservation: (NSString *) inObservations
                               withDate1: (NSString *) inDate1
                               withDate2: (NSString *) inDate2
                         completionBlock: (RequestCompletionBlock) inCompletion
{
    NSString *urlString = [self generateObservationFeedUrlForPatientId:inPatientId
                                                       withObservation:inObservations
                                                             withDate1:inDate1
                                                             withDate2:inDate2];
    
    [self requestWithUrl: urlString completionBlock:inCompletion];
}


- (void) requestWithUrl: (NSString *)inUrlString completionBlock: (RequestCompletionBlock) inCompletion
{
    LoginManager *loginManager = [LoginManager sharedManager];
    NSString *authStringValue = [loginManager bearerAuthHeader];
    
    if (self.observations == nil)
        self.observations = [[NSMutableArray alloc] init];
    
    //NSLog(@"URL: %@", inUrlString);
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
                                             [self.observations removeAllObjects];
                                         
                                             [super updateFeedInfoWithDictionary: dict feedUrl: inUrlString];
                                             
                                             NSArray *observationList = [dict objectForKey:@"entry"];
                                             
                                             if (observationList == nil)
                                             {
                                                 HSDPObservation *hspdObservation = [[HSDPObservation alloc] init];
                                                 FHIRObservation *fhirObs = [FHIRParser loadObjectName: @"FHIRObservation" withDictionary: dict];
                                                 [hspdObservation setObservation:fhirObs];
                                                 [self.observations addObject:hspdObservation];
                                             }
                                             else
                                             {
                                                 for (int i=0; i<observationList.count; i++)
                                                 {
                                                     NSDictionary *observationDictionary = [observationList objectAtIndex:i];
                                                     
                                                     HSDPObservation *hspdObservation = [[HSDPObservation alloc] init];
                                                     
                                                     FHIRObservation *fhirObs = [FHIRParser loadObjectName: @"FHIRObservation" withDictionary: [observationDictionary objectForKey: @"content"]];
                                                     
                                                     [hspdObservation setObservation:fhirObs];
                                                     [self.observations addObject:hspdObservation];
                                                 }
                                             }
                                             
                                             //NSLog(@"DONE");
                                         
                                         }
                                         inCompletion (nil);
                                     }
                                 ];
    
    [connection start];
}



@end