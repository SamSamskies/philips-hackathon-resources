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
 * FeedManager.m
 * Base class for accessing resources from server, has following subclasses
 * - PatientFeed
 * - ObservationFeed
 * - OrganizationFeed
 * This keeps the information related to the feed, like total records, pagination info.
 *
 * Created by Himanshu Shrivastava (hshrivastava@gmail.com)
 */

#import <Foundation/Foundation.h>
#import "FeedManager.h"

@interface FeedManager ()

@property (nonatomic, strong) NSDictionary *returnedLinks;
@property (nonatomic) int totalNoOfRecords, currentPageNo, recordsPerPage, totalNoPages;

@end


@implementation FeedManager


- (void) updateFeedInfoWithDictionary: (NSDictionary *) inDictionary feedUrl: (NSString *)inFeedUrl
{
    self.totalNoOfRecords = 0;
    self.currentPageNo = 1;
    self.recordsPerPage = 0;
    self.totalNoPages = 1;
    
    [self updateReturnedLinks:[inDictionary objectForKey:@"link"]];
    [self updateTotalNoOfRecords: [[inDictionary objectForKey:@"totalResults"] intValue]];
    
    NSRange range = [inFeedUrl rangeOfString:@"?"];
    if (range.length != 0)
    {
        NSString *str = [inFeedUrl substringFromIndex:range.location];

        int pageOffset = 0;
        NSArray *keyValues = [str componentsSeparatedByString:@"&"];
        for (int i=0; i<keyValues.count; i++)
        {
            NSArray *keyValue = [[keyValues objectAtIndex:i] componentsSeparatedByString:@"="];
            if ([[keyValue objectAtIndex:0] isEqualToString:@"_getpagesoffset"])
                pageOffset = [[keyValue objectAtIndex:1] intValue];
            if ([[keyValue objectAtIndex:0] isEqualToString:@"_count"])
                self.recordsPerPage = [[keyValue objectAtIndex:1] intValue];
        }
        
        if (self.recordsPerPage != 0)
            self.currentPageNo = (pageOffset/self.recordsPerPage) + 1;
        else
            self.recordsPerPage = 10;
        
        self.totalNoPages = (self.totalNoOfRecords/self.recordsPerPage)
                            + (self.totalNoOfRecords%self.recordsPerPage == 0 ? 0 : 1);
        
        //NSLog (@"Here: %@", str);
    }
    
}

- (void) updateReturnedLinks:(NSArray *)responseLinks
{
    NSMutableDictionary *links = [[NSMutableDictionary alloc] init];
    
    for (int i=0; i<responseLinks.count; i++)
    {
        NSString *key = [[responseLinks objectAtIndex:i] objectForKey:@"rel"];
        NSString *value = [[responseLinks objectAtIndex:i] objectForKey:@"href"];
        [links setObject:value forKey:key];
    }
    
    self.returnedLinks = links;
}

- (void) updateTotalNoOfRecords: (int) noOfRecords
{
    self.totalNoOfRecords = noOfRecords;
}

- (int) getTotalNumberOfRecords
{
    return self.totalNoOfRecords;
}

- (int) getCurrentPageNo
{
    return self.currentPageNo;
}

- (int) getTotalNoPages
{
    return self.totalNoPages;
}

- (NSString *) getNextLink
{
    if (self.returnedLinks != nil)
        return [self.returnedLinks objectForKey:@"next"];
    return nil;
}

- (NSString *) getPreviousLink
{
    if (self.returnedLinks != nil)
        return [self.returnedLinks objectForKey:@"previous"];
    return nil;
}

@end