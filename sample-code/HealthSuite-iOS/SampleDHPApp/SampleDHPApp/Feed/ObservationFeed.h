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
 * ObservationFeed.h
 * Extends from FeedManager, uses UrlRequestHandler to make calls to the server.
 * Keeps observation records
 *
 * Created by Himanshu Shrivastava (hshrivastava@gmail.com)
 */

#ifndef SampleDHPApp_Observation_h
#define SampleDHPApp_Observation_h

#import "Constants.h"
#import "FeedManager.h"

@interface ObservationFeed : FeedManager

@property (nonatomic, strong) NSMutableArray *observations;

// Used for the first page call to get the data from server.
- (void) requestObservationsForPatientId: (NSString *) inPatientId
                         withObservation: (NSString *) inObservations
                               withDate1: (NSString *) inDate1
                               withDate2: (NSString *) inDate2
                         completionBlock:(RequestCompletionBlock) inCompletion;

// Used for next/previous page calls that comes in the feed response
- (void) requestWithUrl: (NSString *)inUrlString completionBlock: (RequestCompletionBlock) inCompletion;

@end


#endif
