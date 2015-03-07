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
 * An action that is performed on a patient
 *
 * [FhirResource("Procedure")]
 * [Serializable]
 */

#import "FHIRBaseResource.h"


@class FHIRIdentifier;
@class FHIRResource;
@class FHIRCodeableConcept;
@class FHIRProcedurePerformerComponent;
@class FHIRPeriod;
@class FHIRString;
@class FHIRProcedureRelatedItemComponent;

@interface FHIRProcedure : FHIRBaseResource

/*
 * The nature of the relationship with this procedure
 */
typedef enum 
{
    kProcedureRelationshipTypeCausedBy, // This procedure had to be performed because of the related one.
    kProcedureRelationshipTypeBecauseOf, // This procedure caused the related one to be performed.
} kProcedureRelationshipType;

/*
 * External Ids for this procedure
 */
@property (nonatomic, strong) NSArray/*<Identifier>*/ *identifier;

/*
 * Who procedure was performed on
 */
@property (nonatomic, strong) FHIRResource *subject;

/*
 * Identification of the procedure
 */
@property (nonatomic, strong) FHIRCodeableConcept *type;

/*
 * Precise location details
 */
@property (nonatomic, strong) NSArray/*<CodeableConcept>*/ *bodySite;

/*
 * Reason procedure performed
 */
@property (nonatomic, strong) NSArray/*<CodeableConcept>*/ *indication;

/*
 * The people who performed the procedure
 */
@property (nonatomic, strong) NSArray/*<ProcedurePerformerComponent>*/ *performer;

/*
 * The date the procedure was performed
 */
@property (nonatomic, strong) FHIRPeriod *date;

/*
 * The encounter when procedure performed
 */
@property (nonatomic, strong) FHIRResource *encounter;

/*
 * What was result of procedure?
 */
@property (nonatomic, strong) FHIRString *outcomeElement;

@property (nonatomic, strong) NSString *outcome;

/*
 * Any report that results from the procedure
 */
@property (nonatomic, strong) NSArray/*<ResourceReference>*/ *report;

/*
 * Complication following the procedure
 */
@property (nonatomic, strong) NSArray/*<CodeableConcept>*/ *complication;

/*
 * Instructions for follow up
 */
@property (nonatomic, strong) FHIRString *followUpElement;

@property (nonatomic, strong) NSString *followUp;

/*
 * A procedure that is related to this one
 */
@property (nonatomic, strong) NSArray/*<ProcedureRelatedItemComponent>*/ *relatedItem;

/*
 * Additional information about procedure
 */
@property (nonatomic, strong) FHIRString *notesElement;

@property (nonatomic, strong) NSString *notes;

- (FHIRErrorList *)validate;

@end
