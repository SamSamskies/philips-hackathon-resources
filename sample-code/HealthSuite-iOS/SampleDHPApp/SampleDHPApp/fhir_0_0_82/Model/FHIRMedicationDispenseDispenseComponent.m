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
#import "FHIRMedicationDispenseDispenseComponent.h"

#import "FHIRIdentifier.h"
#import "FHIRCode.h"
#import "FHIRCodeableConcept.h"
#import "FHIRQuantity.h"
#import "FHIRResource.h"
#import "FHIRDateTime.h"
#import "FHIRMedicationDispenseDispenseDosageComponent.h"

#import "FHIRErrorList.h"

@implementation FHIRMedicationDispenseDispenseComponent

- (kMedicationDispenseStatus )status
{
    return [FHIREnumHelper parseString:[self.statusElement value] enumType:kEnumTypeMedicationDispenseStatus];
}

- (void )setStatus:(kMedicationDispenseStatus )status
{
    [self setStatusElement:[[FHIRCode/*<code>*/ alloc] initWithValue:[FHIREnumHelper enumToString:status enumType:kEnumTypeMedicationDispenseStatus]]];
}


- (NSString *)whenPrepared
{
    if(self.whenPreparedElement)
    {
        return [self.whenPreparedElement value];
    }
    return nil;
}

- (void )setWhenPrepared:(NSString *)whenPrepared
{
    if(whenPrepared)
    {
        [self setWhenPreparedElement:[[FHIRDateTime alloc] initWithValue:whenPrepared]];
    }
    else
    {
        [self setWhenPreparedElement:nil];
    }
}


- (NSString *)whenHandedOver
{
    if(self.whenHandedOverElement)
    {
        return [self.whenHandedOverElement value];
    }
    return nil;
}

- (void )setWhenHandedOver:(NSString *)whenHandedOver
{
    if(whenHandedOver)
    {
        [self setWhenHandedOverElement:[[FHIRDateTime alloc] initWithValue:whenHandedOver]];
    }
    else
    {
        [self setWhenHandedOverElement:nil];
    }
}


- (FHIRErrorList *)validate
{
    FHIRErrorList *result = [[FHIRErrorList alloc] init];
    
    [result addValidation:[super validate]];
    
    if(self.identifier != nil )
        [result addValidationRange:[self.identifier validate]];
    if(self.statusElement != nil )
        [result addValidationRange:[self.statusElement validate]];
    if(self.type != nil )
        [result addValidationRange:[self.type validate]];
    if(self.quantity != nil )
        [result addValidationRange:[self.quantity validate]];
    if(self.medication != nil )
        [result addValidationRange:[self.medication validate]];
    if(self.whenPreparedElement != nil )
        [result addValidationRange:[self.whenPreparedElement validate]];
    if(self.whenHandedOverElement != nil )
        [result addValidationRange:[self.whenHandedOverElement validate]];
    if(self.destination != nil )
        [result addValidationRange:[self.destination validate]];
    if(self.receiver != nil )
        for(FHIRResource *elem in self.receiver)
            [result addValidationRange:[elem validate]];
    if(self.dosage != nil )
        for(FHIRMedicationDispenseDispenseDosageComponent *elem in self.dosage)
            [result addValidationRange:[elem validate]];
    
    return result;
}

@end
