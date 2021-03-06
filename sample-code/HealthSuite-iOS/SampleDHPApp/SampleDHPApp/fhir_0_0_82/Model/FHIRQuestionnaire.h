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
 * A structured set of questions and their answers
 *
 * [FhirResource("Questionnaire")]
 * [Serializable]
 */

#import "FHIRBaseResource.h"


@class FHIRCode;
@class FHIRDateTime;
@class FHIRResource;
@class FHIRCodeableConcept;
@class FHIRIdentifier;
@class FHIRGroupComponent;

@interface FHIRQuestionnaire : FHIRBaseResource

/*
 * Lifecycle status of the questionnaire
 */
typedef enum 
{
    kQuestionnaireStatusDraft, // This Questionnaire is used as a template but the template is not ready for use or publication.
    kQuestionnaireStatusPublished, // This Questionnaire is used as a template, is published and ready for use.
    kQuestionnaireStatusRetired, // This Questionnaire is used as a template but should no longer be used for new Questionnaires.
    kQuestionnaireStatusInProgress, // This Questionnaire has been filled out with answers, but changes or additions are still expected to be made to it.
    kQuestionnaireStatusCompleted, // This Questionnaire has been filled out with answers, and the current content is regarded as definitive.
    kQuestionnaireStatusAmended, // This Questionnaire has been filled out with answers, then marked as complete, yet changes or additions have been made to it afterwards.
} kQuestionnaireStatus;

/*
 * draft | published | retired | in progress | completed | amended
 */
@property (nonatomic, strong) FHIRCode/*<code>*/ *statusElement;

@property (nonatomic) kQuestionnaireStatus status;

/*
 * Date this version was authored
 */
@property (nonatomic, strong) FHIRDateTime *authoredElement;

@property (nonatomic, strong) NSString *authored;

/*
 * The subject of the questions
 */
@property (nonatomic, strong) FHIRResource *subject;

/*
 * Person who received and recorded the answers
 */
@property (nonatomic, strong) FHIRResource *author;

/*
 * The person who answered the questions
 */
@property (nonatomic, strong) FHIRResource *source;

/*
 * Name/code for a predefined list of questions
 */
@property (nonatomic, strong) FHIRCodeableConcept *name;

/*
 * External Ids for this questionnaire
 */
@property (nonatomic, strong) NSArray/*<Identifier>*/ *identifier;

/*
 * Primary encounter during which the answers were collected
 */
@property (nonatomic, strong) FHIRResource *encounter;

/*
 * Grouped questions
 */
@property (nonatomic, strong) FHIRGroupComponent *group;

- (FHIRErrorList *)validate;

@end
