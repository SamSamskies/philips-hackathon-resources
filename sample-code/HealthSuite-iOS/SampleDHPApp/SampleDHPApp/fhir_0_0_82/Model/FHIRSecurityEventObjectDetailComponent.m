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
#import "FHIRSecurityEventObjectDetailComponent.h"

#import "FHIRString.h"
#import "FHIRBase64Binary.h"

#import "FHIRErrorList.h"

@implementation FHIRSecurityEventObjectDetailComponent

- (NSString *)type
{
    if(self.typeElement)
    {
        return [self.typeElement value];
    }
    return nil;
}

- (void )setType:(NSString *)type
{
    if(type)
    {
        [self setTypeElement:[[FHIRString alloc] initWithValue:type]];
    }
    else
    {
        [self setTypeElement:nil];
    }
}


- (NSData *)value
{
    if(self.valueElement)
    {
        return [self.valueElement value];
    }
    return nil;
}

- (void )setValue:(NSData *)value
{
    if(value)
    {
        [self setValueElement:[[FHIRBase64Binary alloc] initWithValue:value]];
    }
    else
    {
        [self setValueElement:nil];
    }
}


- (FHIRErrorList *)validate
{
    FHIRErrorList *result = [[FHIRErrorList alloc] init];
    
    [result addValidation:[super validate]];
    
    if(self.typeElement != nil )
        [result addValidationRange:[self.typeElement validate]];
    if(self.valueElement != nil )
        [result addValidationRange:[self.valueElement validate]];
    
    return result;
}

@end
