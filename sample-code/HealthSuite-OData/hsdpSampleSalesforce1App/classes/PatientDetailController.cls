public with sharing class PatientDetailController {
    private final Patients__x patient; 
    private final String patientId;
    
    private List<ObservationWrapper> relatedObservations;
    private Integer obvListCounter = 0;
    private Integer obvListPageSize = 10;
    private Integer obvListTotalSize = 0;

    public PatientDetailController() {
        patientId = ApexPages.currentPage().getParameters().get('externalId');
        patient = getPatientById(patientId); 
        
        obvFilterType = 'MDC_PAIN_LEVEL';
        prepareObservationList(); 
    }

    public String obvFilterType { get; set; } 

    public Patients__x getPatient() {
        return patient;
    }

    public Patients__x getRecord() {
        return patient;
    }
    
    public List<ObservationWrapper> getRelatedObservations() {
        return relatedObservations;
    }
     
    public Boolean getShowPrev() {
        if (obvListCounter > 0) {
            return true;        
        }
        else {
            return false;
        }         
    }
    
    public Boolean getShowNext() {
        if ((obvListCounter + obvListPageSize) < obvListTotalSize) {
            return true;        
        }
        else {
            return false;
        }        
    }
    
    public PageReference Previous() { 
        if ((obvListCounter - obvListPageSize) > 0) {
            obvListCounter -= obvListPageSize;        
        }
        else {
            obvListCounter = 0;
        }

        prepareObservationList();
        
        return null;
    }
  
    public PageReference Next() {
        if ((obvListCounter + obvListPageSize) < obvListTotalSize) {
            obvListCounter += obvListPageSize;        
        }

        prepareObservationList();
        
        return null;
    }        

    public List<selectOption> getObservationTypes() {            
        List<selectOption> options = new List<selectOption>(); 

        options.add(new selectOption('MDC_PRESS_BLD', 'Blood Pressure'));
        options.add(new selectOption('MDC_TEMP_BODY', 'Body Temperature'));
        options.add(new selectOption('MDC_ HF_ENERGY', 'Energy Expended'));
        options.add(new selectOption('MDC_CONC_GLU_UNDETERMINED_WHOLEBLOOD', 'Glucose'));
        options.add(new selectOption('MDC_CONC_HBA1C', 'Glycated Hemoglobin'));
        options.add(new selectOption('MDC_HF_HR', 'Heart Rate'));
        options.add(new selectOption('MDC_PHYSIO_MOOD', 'Mood'));
        options.add(new selectOption('MDC_PAIN_LEVEL', 'Pain Level'));      
        options.add(new selectOption('MDC_RATIO_INR_COAG', 'Prothrombin Time'));
        options.add(new selectOption('MDC_PULS_RATE_NON_INV', 'Pulse Rate (taken with blood pressure)'));
        options.add(new selectOption('MDC_PULS_OXIM_PULS_RATE', 'Pulse Rate (taken with oximeter)'));
        options.add(new selectOption('MDC_HF_ACT_SLEEP', 'Sleep'));
        options.add(new selectOption('MDC_RESP_RATE', 'Respiratory Rate'));
        options.add(new selectOption('MDC_SLEEP_EFFICIENCY', 'Sleep Efficiency'));
        options.add(new selectOption('MDC_PULS_OXIM_SAT_O2', 'SPO2 Oxygen'));
        options.add(new selectOption('MDC_HF_DISTANCE', 'Steps'));
        options.add(new selectOption('MDC_MASS_BODY_ACTUAL', 'Weight'));

        return options;
    }
    
    public PageReference Filter() { 
        obvListCounter = 0;

        // reset the list count        
        obvListTotalSize = 0;        
        
        prepareObservationList();
        
        return null;
    }
    
    public PageReference ClearFilter() { 
        obvFilterType = 'MDC_PAIN_LEVEL';
        obvListCounter = 0;

        // reset the list count
        obvListTotalSize = 0;        
        
        prepareObservationList();
        
        return null;
    }

    private void prepareObservationList() {
        List<ObservationWrapper> owList = null;
        List<Observations__x> obsvList = null;

        try {
            obsvList = [ SELECT ExternalId, id__c, name__c, quantity__c, 
                            units__c, appliesDateTime__c, appliesPeriodStart__c, 
                            appliesPeriodEnd__c, patientId__c, 
                            relatedObservationId1__c, relatedObservationId2__c, 
                            relatedObservationId3__c, status__c, reliability__c
                          from Observations__x 
                          where patientId__c = :patientId and name__c = :obvFilterType
                            LIMIT :obvListPageSize OFFSET :obvListCounter ];  
        }
        catch (Exception ex) {
            // put logic for handling exceptions here
        } 

        if (obsvList != null) {
            owList = new List<ObservationWrapper>();
            
            for (Observations__x ox : obsvList) {
                owList.add(new ObservationWrapper(ox));
            }
            
            // hack to workaround not having a way to get total count
            if (owList.size() >= obvListPageSize) {
                 obvListTotalSize = obvListCounter + obvListPageSize + 1;
            }
            else {
                 obvListTotalSize = obvListCounter + owList.size();
            }
        }
        else {
            obvListTotalSize = 0;
        }
    
        relatedObservations = owList;
    }
 
    private Patients__x getPatientById(String patientId) {
      List<Patients__x> ptntList = [ SELECT ExternalId, active__c, address__c, birthdate__c, city__c, country__c, email__c, given__c, gender__c, 
                                          healthsuite_identifier__c, family__c, managingOrganization__c, maritalStatus__c, id__c, phone__c, state__c, zip__c 
                                             from Patients__x where externalId = :patientId LIMIT 1 ];

          if (ptntList.size() > 0) {
              return ptntList[0];
          }
          else {
              return null;
          }    
    }    
}