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
 *
 * [FhirResource("Resource")]
 * [Serializable]
 * [Abstract]
 */

#import "FHIREnumHelper.h"
@class FHIRErrorList;

@class FHIRExtension;
@class FHIRCode;
@class FHIRNarrative;
@class FHIRBaseResource;
@class FHIRId;

@interface FHIRBaseResource : NSObject

/*
 * Additional Content defined by implementations
 */
@property (nonatomic, strong) NSArray/*<Extension>*/ *extension;

/*
 * Extensions that cannot be ignored
 */
@property (nonatomic, strong) NSArray/*<Extension>*/ *modifierExtension;

/*
 * Language of the resource content
 */
@property (nonatomic, strong) FHIRCode *languageElement;

@property (nonatomic, strong) NSString *language;

/*
 * Text summary of the resource, for human interpretation
 */
@property (nonatomic, strong) FHIRNarrative *text;

/*
 * Contained, inline Resources
 */
@property (nonatomic, strong) NSArray/*<Resource>*/ *contained;

/*
 * Local id for element
 */
@property (nonatomic, strong) FHIRId *idElement;

@property (nonatomic, strong) NSString *id;

- (FHIRErrorList *)validate;

@end
