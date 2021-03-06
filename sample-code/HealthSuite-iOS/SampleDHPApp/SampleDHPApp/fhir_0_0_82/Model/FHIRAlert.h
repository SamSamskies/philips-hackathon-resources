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
 * Key information to flag to healthcare providers
 *
 * [FhirResource("Alert")]
 * [Serializable]
 */

#import "FHIRBaseResource.h"


@class FHIRIdentifier;
@class FHIRCodeableConcept;
@class FHIRCode;
@class FHIRResource;
@class FHIRString;

@interface FHIRAlert : FHIRBaseResource

/*
 * Indicates whether this alert is active and needs to be displayed to a user, or whether it is no longer needed or entered in error
 */
typedef enum 
{
    kAlertStatusActive, // A current alert that should be displayed to a user. A system may use the category to determine which roles should view the alert.
    kAlertStatusInactive, // The alert does not need to be displayed any more.
    kAlertStatusEnteredInError, // The alert was added in error, and should no longer be displayed.
} kAlertStatus;

/*
 * Business identifier
 */
@property (nonatomic, strong) NSArray/*<Identifier>*/ *identifier;

/*
 * Clinical, administrative, etc.
 */
@property (nonatomic, strong) FHIRCodeableConcept *category;

/*
 * active | inactive | entered in error
 */
@property (nonatomic, strong) FHIRCode/*<code>*/ *statusElement;

@property (nonatomic) kAlertStatus status;

/*
 * Who is alert about?
 */
@property (nonatomic, strong) FHIRResource *subject;

/*
 * Alert creator
 */
@property (nonatomic, strong) FHIRResource *author;

/*
 * Text of alert
 */
@property (nonatomic, strong) FHIRString *noteElement;

@property (nonatomic, strong) NSString *note;

- (FHIRErrorList *)validate;

@end
