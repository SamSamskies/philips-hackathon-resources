public class ObservationTypeMapper {

   static Map<String, String> typeMap = new Map<String, String>();

    static {
        typeMap.put('MDC_PRESS_BLD', 'Blood Pressure');
        typeMap.put('MDC_TEMP_BODY', 'Body Temperature');
        typeMap.put('MDC_PRESS_BLD_DIA', 'Diastolic Blood Pressure');
        typeMap.put('MDC_ HF_ENERGY', 'Energy Expended');
        typeMap.put('MDC_CONC_GLU_UNDETERMINED_WHOLEBLOOD', 'Glucose');
        typeMap.put('MDC_CONC_HBA1C', 'Glycated Hemoglobin');
        typeMap.put('MDC_HF_HR', 'Heart Rate');
        typeMap.put('MDC_PRESS_BLD_MEAN', 'Mean Blood Pressure');
        typeMap.put('MDC_PHYSIO_MOOD', 'Mood');
        typeMap.put('MDC_PAIN_LEVEL', 'Pain Level'); 
        typeMap.put('MDC_RATIO_INR_COAG', 'Prothrombin Time');
        typeMap.put('MDC_PULS_RATE_NON_INV', 'Pulse Rate (taken with blood pressure)');
        typeMap.put('MDC_PULS_OXIM_PULS_RATE', 'Pulse Rate (taken with oximeter)');
        typeMap.put('MDC_RESP_RATE', 'Respiratory Rate');
        typeMap.put('MDC_HF_ACT_SLEEP', 'Sleep');
        typeMap.put('MDC_SLEEP_EFFICIENCY', 'Sleep Efficiency');
        typeMap.put('MDC_PULS_OXIM_SAT_O2', 'SPO2 Oxygen');
        typeMap.put('MDC_HF_DISTANCE', 'Steps');
        typeMap.put('MDC_PRESS_BLD_SYS', 'Systolic Blood Pressure');
        typeMap.put('MDC_MASS_BODY_ACTUAL', 'Weight');
    }
    
    public static String getNameForCode(String code) {
        String rtrnVal = null;
        
        if (typeMap.containsKey(code)) {
            rtrnVal = typeMap.get(code);
        }
        
        return rtrnVal;
    }
}