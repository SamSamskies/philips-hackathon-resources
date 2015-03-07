public class ObservationWrapper {
    private final Observations__x observation;
    
    public ObservationWrapper(Observations__x observation) {
        this.observation = observation;
    }

    public String getObservationId() {
        return observation.id__c;
    }
    
    public String getName() {
        return observation.name__c;
    }    

    public String getDisplayName() {
        return ObservationTypeMapper.getNameForCode(observation.name__c);
    } 
    
    public String getPatientId() {
        return observation.patientId__c;
    }    
    
    public String getAppliesPeriod() {
        String rtrnVal = null;
        
        if ((observation.appliesPeriodStart__c != null) && (observation.appliesPeriodEnd__c != null))  {
            rtrnVal = observation.appliesPeriodStart__c.format() + '   --   ' + observation.appliesPeriodEnd__c.format();        
        }
        else if (observation.appliesDateTime__c != null) {
            rtrnVal = observation.appliesDateTime__c.format();
        }

        return rtrnVal;
    }
    
    public String getQuantity() {
        String rtrnVal = null;
        
        if (observation.quantity__c != null) {
            rtrnVal = '' + observation.quantity__c;
        
            if (observation.units__c != null) {
               rtrnVal += ' ' + observation.units__c;
            }
        }

        return rtrnVal;
    }
    
    public String getReliability() {
        return observation.reliability__c;
    }  
    
    public String getStatus() {
        return observation.status__c;
    }       
}