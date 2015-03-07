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
 * FeedManager.h
 * Base class for accessing resources from server, has following subclasses
 * - PatientFeed
 * - ObservationFeed
 * - OrganizationFeed
 * This keeps the information related to the feed, like total records, pagination info.
 *
 * Created by Himanshu Shrivastava (hshrivastava@gmail.com)
 */

#ifndef SampleDHPApp_FeedManager_h
#define SampleDHPApp_FeedManager_h

#import "Constants.h"

@interface FeedManager : NSObject

- (void) updateFeedInfoWithDictionary: (NSDictionary *) inDictionary feedUrl: (NSString *)inFeedUrl;
- (NSString *) getNextLink;
- (NSString *) getPreviousLink;
- (int) getTotalNumberOfRecords;
- (int) getCurrentPageNo;
- (int) getTotalNoPages;


@end

#endif
