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
 * HSDPPatient.m
 *
 * Created by Himanshu Shrivastava (hshrivastava@gmail.com)
 */

#import <Foundation/Foundation.h>
#import "HSDPPatient.h"
#import "FHIRCodeableConcept.h"
#import "FHIRCoding.h"
#import "FHIRString.h"
#import "FHIRCode.h"
#import "FHIRHumanName.h"
#import "FHIRAddress.h"
#import "FHIRContact.h"


@interface HSDPPatient ()

@end

@implementation HSDPPatient

@synthesize patient, title, lastUpdatedDateString, urlLink;

- (NSString *) getGender
{
    NSString *returnVal = nil;
    FHIRCoding *gender = [patient.gender.coding objectAtIndex:0];
    returnVal = (NSString *)gender.displayElement;
    
    return returnVal;
}



- (NSString *) getGenderShortForm
{
    NSString *returnVal = nil;
    FHIRCoding *gender = [patient.gender.coding objectAtIndex:0];
    returnVal = (NSString *)gender.codeElement;
    
    return returnVal;
}



- (NSString *) getBirthdate
{
    NSString *returnVal = nil;
    
    returnVal = (NSString *) patient.birthDateElement;
    
    return returnVal;
}



- (NSString *) getStatus
{
    NSString *returnVal = nil;
    
    returnVal = (BOOL)patient.activeElement == YES ? @"Active" : @"Notactive";
    
    return returnVal;
}



- (NSString *) getNameForIndex: (int) inIndex
{
    NSString *returnVal = nil;
    
    FHIRHumanName *name = [patient.name objectAtIndex:inIndex];
    
    if (name.givenElement.count > 0 || name.familyElement.count > 0)
    {
//        NSString *nm = @"";
        NSMutableString *nm = [[NSMutableString alloc] initWithString:@""];
        for (int i=0; i<name.givenElement.count; i++)
        {
            NSString *tmp = [name.givenElement objectAtIndex:i];
            [nm appendFormat:@"%@ ", (tmp == nil ? @"" : tmp)];
        }
        for (int i=0; i<name.familyElement.count; i++)
        {
            NSString *tmp = [name.familyElement objectAtIndex:i];
            [nm appendFormat:@"%@ ", (tmp == nil ? @"" : tmp)];
        }
        returnVal = [nm stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    }
    
    return returnVal;
}



- (NSString *) getName
{
    NSString *returnVal = [self getNameForIndex:0];
    
    return returnVal;
}


- (NSArray *) getNames
{
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<patient.name.count; i++)
    {
        NSString *nm = [self getNameForIndex:i];
        if (nm != nil)
            [returnArray addObject:nm];
    }
    
    return returnArray;
}



- (NSArray *) getAddresses
{
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<patient.address.count; i++)
    {
        FHIRAddress * address = [patient.address objectAtIndex:i];
        
        NSMutableString *addressString = [[NSMutableString alloc] initWithString:[address.lineElement componentsJoinedByString:@" "]];
        
        if (address.cityElement != nil)
            [addressString appendFormat:@" %@",(NSString *)address.cityElement];
        if (address.stateElement != nil)
            [addressString appendFormat:@" %@",(NSString *)address.stateElement];
        if (address.zipElement != nil)
            [addressString appendFormat:@" %@",(NSString *)address.zipElement];
        if (address.countryElement != nil)
            [addressString appendFormat:@" %@",(NSString *)address.countryElement];
        if (address.useElement != nil)
            [addressString appendFormat:@" (%@)",(NSString *)address.useElement];
        
        [returnArray addObject:[addressString stringByReplacingOccurrencesOfString:@"  " withString:@" "]];
    }
    
    return returnArray;
}



- (NSArray *) getPhones
{
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<patient.telecom.count; i++)
    {
        FHIRContact *contact = [patient.telecom objectAtIndex:i];
        
        if (contact.valueElement != nil)
        {
            NSMutableString *phoneString = [[NSMutableString alloc] initWithString:(NSString *)contact.valueElement];
            if (contact.useElement != nil)
                [phoneString appendFormat:@" (%@)", contact.useElement];

            [returnArray addObject:phoneString];
        }
    }
    
    return returnArray;
}



@end
