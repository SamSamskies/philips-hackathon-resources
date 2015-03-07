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
#import "FHIRProfileMappingComponent.h"

#import "FHIRId.h"
#import "FHIRUri.h"
#import "FHIRString.h"

#import "FHIRErrorList.h"

@implementation FHIRProfileMappingComponent

- (NSString *)identity
{
    if(self.identityElement)
    {
        return [self.identityElement value];
    }
    return nil;
}

- (void )setIdentity:(NSString *)identity
{
    if(identity)
    {
        [self setIdentityElement:[[FHIRId alloc] initWithValue:identity]];
    }
    else
    {
        [self setIdentityElement:nil];
    }
}


- (NSString *)uri
{
    if(self.uriElement)
    {
        return [self.uriElement value];
    }
    return nil;
}

- (void )setUri:(NSString *)uri
{
    if(uri)
    {
        [self setUriElement:[[FHIRUri alloc] initWithValue:uri]];
    }
    else
    {
        [self setUriElement:nil];
    }
}


- (NSString *)name
{
    if(self.nameElement)
    {
        return [self.nameElement value];
    }
    return nil;
}

- (void )setName:(NSString *)name
{
    if(name)
    {
        [self setNameElement:[[FHIRString alloc] initWithValue:name]];
    }
    else
    {
        [self setNameElement:nil];
    }
}


- (NSString *)comments
{
    if(self.commentsElement)
    {
        return [self.commentsElement value];
    }
    return nil;
}

- (void )setComments:(NSString *)comments
{
    if(comments)
    {
        [self setCommentsElement:[[FHIRString alloc] initWithValue:comments]];
    }
    else
    {
        [self setCommentsElement:nil];
    }
}


- (FHIRErrorList *)validate
{
    FHIRErrorList *result = [[FHIRErrorList alloc] init];
    
    [result addValidation:[super validate]];
    
    if(self.identityElement != nil )
        [result addValidationRange:[self.identityElement validate]];
    if(self.uriElement != nil )
        [result addValidationRange:[self.uriElement validate]];
    if(self.nameElement != nil )
        [result addValidationRange:[self.nameElement validate]];
    if(self.commentsElement != nil )
        [result addValidationRange:[self.commentsElement validate]];
    
    return result;
}

@end