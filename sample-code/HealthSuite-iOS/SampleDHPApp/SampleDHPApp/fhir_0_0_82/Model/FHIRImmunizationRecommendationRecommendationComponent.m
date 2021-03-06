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
#import "FHIRImmunizationRecommendationRecommendationComponent.h"

#import "FHIRDateTime.h"
#import "FHIRCodeableConcept.h"
#import "FHIRInteger.h"
#import "FHIRImmunizationRecommendationRecommendationDateCriterionComponent.h"
#import "FHIRImmunizationRecommendationRecommendationProtocolComponent.h"
#import "FHIRResource.h"

#import "FHIRErrorList.h"

@implementation FHIRImmunizationRecommendationRecommendationComponent

- (NSString *)date
{
    if(self.dateElement)
    {
        return [self.dateElement value];
    }
    return nil;
}

- (void )setDate:(NSString *)date
{
    if(date)
    {
        [self setDateElement:[[FHIRDateTime alloc] initWithValue:date]];
    }
    else
    {
        [self setDateElement:nil];
    }
}


- (NSNumber *)doseNumber
{
    if(self.doseNumberElement)
    {
        return [self.doseNumberElement value];
    }
    return nil;
}

- (void )setDoseNumber:(NSNumber *)doseNumber
{
    if(doseNumber)
    {
        [self setDoseNumberElement:[[FHIRInteger alloc] initWithValue:doseNumber]];
    }
    else
    {
        [self setDoseNumberElement:nil];
    }
}


- (FHIRErrorList *)validate
{
    FHIRErrorList *result = [[FHIRErrorList alloc] init];
    
    [result addValidation:[super validate]];
    
    if(self.dateElement != nil )
        [result addValidationRange:[self.dateElement validate]];
    if(self.vaccineType != nil )
        [result addValidationRange:[self.vaccineType validate]];
    if(self.doseNumberElement != nil )
        [result addValidationRange:[self.doseNumberElement validate]];
    if(self.forecastStatus != nil )
        [result addValidationRange:[self.forecastStatus validate]];
    if(self.dateCriterion != nil )
        for(FHIRImmunizationRecommendationRecommendationDateCriterionComponent *elem in self.dateCriterion)
            [result addValidationRange:[elem validate]];
    if(self.protocol != nil )
        [result addValidationRange:[self.protocol validate]];
    if(self.supportingImmunization != nil )
        for(FHIRResource *elem in self.supportingImmunization)
            [result addValidationRange:[elem validate]];
    if(self.supportingPatientInformation != nil )
        for(FHIRResource *elem in self.supportingPatientInformation)
            [result addValidationRange:[elem validate]];
    
    return result;
}

@end
