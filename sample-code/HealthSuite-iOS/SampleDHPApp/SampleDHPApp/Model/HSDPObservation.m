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
 * HSDPObservation.m
 *
 * Created by Himanshu Shrivastava (hshrivastava@gmail.com)
 */

#import <Foundation/Foundation.h>
#import "HSDPObservation.h"
#import "FHIRCodeableConcept.h"
#import "FHIRCoding.h"
#import "FHIRQuantity.h"
#import "FHIRElement.h"
#import "FHIRString.h"
#import "FHIRCode.h"
#import "FHIRPeriod.h"


@interface HSDPObservation ()

@end

@implementation HSDPObservation



-( NSString *) getObservationName
{
    NSString *returnVal = nil;
    
    FHIRCoding *coding = [self.observation.name.coding objectAtIndex:1] == nil
                                ? [self.observation.name.coding objectAtIndex:0]
                                : [self.observation.name.coding objectAtIndex:1];
    returnVal = (NSString *) coding.displayElement;

    return returnVal;
}



- (NSString *) getObservationValue
{
    NSString *returnVal = nil;

    if (self.observation.valueQuantity != nil)
    {
        FHIRQuantity *quantity = (FHIRQuantity *)self.observation.valueQuantity;
        returnVal = [NSString stringWithFormat: @"%@ %@", quantity.valueElement, quantity.unitsElement];
    }
    
    return returnVal;
}



- (NSString *) getAppliedDateTimeHumanReadableString
{
    NSString *returnVal = nil;
    
    returnVal = (NSString *) self.observation.appliesDateTime;
    
    if (returnVal == nil)
    {
        FHIRPeriod *period = (FHIRPeriod *)self.observation.appliesPeriod;
        
        if (period.startElement != nil && period.endElement != nil)
            returnVal = [NSString stringWithFormat: @"%@ to %@",period.startElement, period.endElement];
        else
        {
            if (period.startElement != nil)
                returnVal = (NSString *)period.startElement;
            else
                returnVal = (NSString *)period.endElement;
        }
    }
    
    return returnVal;
}



- (NSString *) getStatus
{
    NSString *returnVal = nil;
    
    returnVal = (NSString *) self.observation.statusElement;
    
    return returnVal;
}



- (NSString *) getReliability
{
    NSString *returnVal = nil;
    
    returnVal = (NSString *) self.observation.reliabilityElement;
    
    return returnVal;
}

@end