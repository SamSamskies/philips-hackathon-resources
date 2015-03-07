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
#import "FHIRSecurityEventEventComponent.h"

#import "FHIRCodeableConcept.h"
#import "FHIRCode.h"
#import "FHIRInstant.h"
#import "FHIRString.h"

#import "FHIRErrorList.h"

@implementation FHIRSecurityEventEventComponent

- (kSecurityEventAction )action
{
    return [FHIREnumHelper parseString:[self.actionElement value] enumType:kEnumTypeSecurityEventAction];
}

- (void )setAction:(kSecurityEventAction )action
{
    [self setActionElement:[[FHIRCode/*<code>*/ alloc] initWithValue:[FHIREnumHelper enumToString:action enumType:kEnumTypeSecurityEventAction]]];
}


- (NSDate *)dateTime
{
    if(self.dateTimeElement)
    {
        return [self.dateTimeElement value];
    }
    return nil;
}

- (void )setDateTime:(NSDate *)dateTime
{
    if(dateTime)
    {
        [self setDateTimeElement:[[FHIRInstant alloc] initWithValue:dateTime]];
    }
    else
    {
        [self setDateTimeElement:nil];
    }
}


- (kSecurityEventOutcome )outcome
{
    return [FHIREnumHelper parseString:[self.outcomeElement value] enumType:kEnumTypeSecurityEventOutcome];
}

- (void )setOutcome:(kSecurityEventOutcome )outcome
{
    [self setOutcomeElement:[[FHIRCode/*<code>*/ alloc] initWithValue:[FHIREnumHelper enumToString:outcome enumType:kEnumTypeSecurityEventOutcome]]];
}


- (NSString *)outcomeDesc
{
    if(self.outcomeDescElement)
    {
        return [self.outcomeDescElement value];
    }
    return nil;
}

- (void )setOutcomeDesc:(NSString *)outcomeDesc
{
    if(outcomeDesc)
    {
        [self setOutcomeDescElement:[[FHIRString alloc] initWithValue:outcomeDesc]];
    }
    else
    {
        [self setOutcomeDescElement:nil];
    }
}


- (FHIRErrorList *)validate
{
    FHIRErrorList *result = [[FHIRErrorList alloc] init];
    
    [result addValidation:[super validate]];
    
    if(self.type != nil )
        [result addValidationRange:[self.type validate]];
    if(self.subtype != nil )
        for(FHIRCodeableConcept *elem in self.subtype)
            [result addValidationRange:[elem validate]];
    if(self.actionElement != nil )
        [result addValidationRange:[self.actionElement validate]];
    if(self.dateTimeElement != nil )
        [result addValidationRange:[self.dateTimeElement validate]];
    if(self.outcomeElement != nil )
        [result addValidationRange:[self.outcomeElement validate]];
    if(self.outcomeDescElement != nil )
        [result addValidationRange:[self.outcomeDescElement validate]];
    
    return result;
}

@end
