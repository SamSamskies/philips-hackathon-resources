﻿/*
  Copyright (c) 2011-2013, HL7, Inc.
  All rights reserved.
  
  Redistribution and use in source and binary forms, with or without modification, 
  are permitted provided that the following conditions are met:
  
   * Redistributions of source code must retain the above copyright notice, this 
     list of conditions and the following disclaimer.
   * Redistributions in binary form must reproduce the above copyright notice, 
     this list of conditions and the following disclaimer in the documentation 
     and/or other materials provided with the distribution.
   * Neither the name of HL7 nor the names of its contributors may be used to 
     endorse or promote products derived from this software without specific 
     prior written permission.
  
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
  IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT 
  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
  POSSIBILITY OF SUCH DAMAGE.
  

 * Generated on Tue, Sep 30, 2014 18:08+1000 for FHIR v0.0.82
 */
/*
 * null
 */
#import "FHIRTypeRefComponent.h"

#import "FHIRCode.h"
#import "FHIRUri.h"

#import "FHIRErrorList.h"

@implementation FHIRTypeRefComponent

- (NSString *)code
{
    if(self.codeElement)
    {
        return [self.codeElement value];
    }
    return nil;
}

- (void )setCode:(NSString *)code
{
    if(code)
    {
        [self setCodeElement:[[FHIRCode alloc] initWithValue:code]];
    }
    else
    {
        [self setCodeElement:nil];
    }
}


- (NSString *)profile
{
    if(self.profileElement)
    {
        return [self.profileElement value];
    }
    return nil;
}

- (void )setProfile:(NSString *)profile
{
    if(profile)
    {
        [self setProfileElement:[[FHIRUri alloc] initWithValue:profile]];
    }
    else
    {
        [self setProfileElement:nil];
    }
}


- (NSArray /*<kAggregationMode>*/ *)aggregation
{
    if(self.aggregationElement)
    {
        NSMutableArray *array = [NSMutableArray new];
        for(FHIRCode *elem in self.aggregationElement)
            [array addObject:[NSNumber numberWithInt:[FHIREnumHelper parseString:[elem value] enumType:kEnumTypeAggregationMode]]];
        return [NSArray arrayWithArray:array];
    }
    return nil;
}

- (void )setAggregation:(NSArray /*<kAggregationMode>*/ *)aggregation
{
    if(aggregation)
    {
        NSMutableArray *array = [NSMutableArray new];
        for(NSNumber *value in self.aggregation)
            [array addObject:[FHIREnumHelper enumToString:[value intValue] enumType:kEnumTypeAggregationMode]];
        [self setAggregationElement:[NSArray arrayWithArray:array]];
    }
    else
    {
        [self setAggregationElement:nil];
    }
}


- (FHIRErrorList *)validate
{
    FHIRErrorList *result = [[FHIRErrorList alloc] init];
    
    [result addValidation:[super validate]];
    
    if(self.codeElement != nil )
        [result addValidationRange:[self.codeElement validate]];
    if(self.profileElement != nil )
        [result addValidationRange:[self.profileElement validate]];
    if(self.aggregationElement != nil )
        for(FHIRCode *elem in self.aggregationElement)
            [result addValidationRange:[elem validate]];
    
    return result;
}

@end
