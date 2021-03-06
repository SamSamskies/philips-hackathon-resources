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
 * Sample for analysis
 */
#import "FHIRSpecimen.h"

#import "FHIRIdentifier.h"
#import "FHIRCodeableConcept.h"
#import "FHIRSpecimenSourceComponent.h"
#import "FHIRResource.h"
#import "FHIRDateTime.h"
#import "FHIRSpecimenCollectionComponent.h"
#import "FHIRSpecimenTreatmentComponent.h"
#import "FHIRSpecimenContainerComponent.h"

#import "FHIRErrorList.h"

@implementation FHIRSpecimen

- (NSString *)receivedTime
{
    if(self.receivedTimeElement)
    {
        return [self.receivedTimeElement value];
    }
    return nil;
}

- (void )setReceivedTime:(NSString *)receivedTime
{
    if(receivedTime)
    {
        [self setReceivedTimeElement:[[FHIRDateTime alloc] initWithValue:receivedTime]];
    }
    else
    {
        [self setReceivedTimeElement:nil];
    }
}


- (FHIRErrorList *)validate
{
    FHIRErrorList *result = [[FHIRErrorList alloc] init];
    
    [result addValidation:[super validate]];
    
    if(self.identifier != nil )
        for(FHIRIdentifier *elem in self.identifier)
            [result addValidationRange:[elem validate]];
    if(self.type != nil )
        [result addValidationRange:[self.type validate]];
    if(self.source != nil )
        for(FHIRSpecimenSourceComponent *elem in self.source)
            [result addValidationRange:[elem validate]];
    if(self.subject != nil )
        [result addValidationRange:[self.subject validate]];
    if(self.accessionIdentifier != nil )
        [result addValidationRange:[self.accessionIdentifier validate]];
    if(self.receivedTimeElement != nil )
        [result addValidationRange:[self.receivedTimeElement validate]];
    if(self.collection != nil )
        [result addValidationRange:[self.collection validate]];
    if(self.treatment != nil )
        for(FHIRSpecimenTreatmentComponent *elem in self.treatment)
            [result addValidationRange:[elem validate]];
    if(self.container != nil )
        for(FHIRSpecimenContainerComponent *elem in self.container)
            [result addValidationRange:[elem validate]];
    
    return result;
}

@end
