public with sharing class ObservationDetailController {
    private Observations__x obsv;
    private List<ObservationWrapper> relatedObservations;
    private ObservationWrapper observationWrapper;
    

    public ObservationDetailController() {
        obsv = getObservationFromDB(ApexPages.currentPage().getParameters().get('ExternalId'));

        relatedObservations = wrapObservationList(getRelatedObservationsFromDB());
        
        observationWrapper = new ObservationWrapper(obsv);
    }

    public Observations__x getObservation() {
        return obsv;
    }

    public ObservationWrapper getObservationWrapper() {
        return observationWrapper;
    }

    public List<ObservationWrapper> getRelatedObservations() {
        return relatedObservations;    
    }
    
    private Observations__x getObservationFromDB(String externalId) {
        List<Observations__x> obsvList = [ SELECT ExternalId, id__c, name__c, quantity__c, units__c, appliesDateTime__c, appliesPeriodStart__c, appliesPeriodEnd__c, 
                                            patientId__c, relatedObservationId1__c, relatedObservationId2__c, relatedObservationId3__c, status__c, reliability__c
                                             from Observations__x where externalId = :externalId LIMIT 1 ];

          if (obsvList.size() > 0) {
              return obsvList[0];
          }
          else {
              return null;
          }    
    }
    
    private List<Observations__x> getRelatedObservationsFromDB() {
        List<Observations__x> obsvList = null;
        List<String> obvIdList = new List<String>();

        if (String.isNotEmpty(obsv.relatedObservationId1__c)) {
            obvIdList.add(obsv.relatedObservationId1__c);
        }

        if (String.isNotEmpty(obsv.relatedObservationId2__c)) {
            obvIdList.add(obsv.relatedObservationId2__c);
        }

        if (String.isNotEmpty(obsv.relatedObservationId3__c)) {
            obvIdList.add(obsv.relatedObservationId3__c);
        }

        if (obvIdList.size() > 0) {
            obsvList = [ SELECT ExternalId, id__c, name__c, quantity__c, units__c, appliesDateTime__c, appliesPeriodStart__c, appliesPeriodEnd__c, 
                                            patientId__c, relatedObservationId1__c, relatedObservationId2__c, relatedObservationId3__c, status__c, reliability__c
                                             from Observations__x where externalId in :obvIdList LIMIT 3 ];
        }
        
        return obsvList;
    }
    
    private List<ObservationWrapper> wrapObservationList(List<Observations__x> originalList) {
        List<ObservationWrapper> owList = null;
    
        if (originalList != null) {
            owList = new List<ObservationWrapper>();
            
            for (Observations__x ox : originalList) {
                owList.add(new ObservationWrapper(ox));
            }
        }
    
        return owList;
    }
}