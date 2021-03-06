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
 * [FhirComposite("MedicationPrescriptionDosageInstructionComponent")]
 * [Serializable]
 */

#import "FHIRElement.h"

#import "FHIRMedicationPrescription.h"

@class FHIRString;
@class FHIRCodeableConcept;
@class FHIRElement;
@class FHIRQuantity;
@class FHIRRatio;

@interface FHIRMedicationPrescriptionDosageInstructionComponent : FHIRElement

/*
 * Dosage instructions expressed as text
 */
@property (nonatomic, strong) FHIRString *textElement;

@property (nonatomic, strong) NSString *text;

/*
 * Supplemental instructions - e.g. "with meals"
 */
@property (nonatomic, strong) FHIRCodeableConcept *additionalInstructions;

/*
 * When medication should be administered
 */
@property (nonatomic, strong) FHIRElement *timing;

/*
 * Take "as needed" f(or x)
 */
@property (nonatomic, strong) FHIRElement *asNeeded;

/*
 * Body site to administer to
 */
@property (nonatomic, strong) FHIRCodeableConcept *site;

/*
 * How drug should enter body
 */
@property (nonatomic, strong) FHIRCodeableConcept *route;

/*
 * Technique for administering medication
 */
@property (nonatomic, strong) FHIRCodeableConcept *method;

/*
 * Amount of medication per dose
 */
@property (nonatomic, strong) FHIRQuantity *doseQuantity;

/*
 * Amount of medication per unit of time
 */
@property (nonatomic, strong) FHIRRatio *rate;

/*
 * Upper limit on medication per unit of time
 */
@property (nonatomic, strong) FHIRRatio *maxDosePerPeriod;

- (FHIRErrorList *)validate;

@end
