Philips HealthSuite Digital Platform (HSDP) 
Salesforce1 OData Application

  What is it?
  -----------

  The Philips Salesforce1 sample application demonstrates core capabilities of 
  the Philips HealthSuite OData API. This sample app represents the perspective 
  of a healthcare organization so it demonstrates access to multiple patients. 
  Basic concepts including acquiring an OAuth token and retrieving patient 
  demographic information. The key concept of retrieving observations is 
  highlighted as well as the ability to page back and forth over a set of 
  observations. The application can be used as a starting point for additional 
  feature build-out. 
  
  

  The Latest Version
  ------------------

  The latest version of the sample code can be downloaded from the Philips 
  HealthSuite Developer portal at 
  https://portal.api.pcftest.com/sites/default/files/samplesalesforce.zip
  
  
  
  Operations
  -----------
  
  - OAuth authentication
  - Get Patient(s)
  - Get Observation(s)
  - Observation Filtering and Pagination
  
  
    
  Pre-requisite
  --------------
  
  You need to have an account on the dev portal to build the application. See:
  https://portal.api.pcftest.com/getting-started

  1. Create an account

  2. Wait for the approval (within 24 hours)
  
  3. Create an application with 
      App Name: "Sample OData App", 
      Callback URL: "localhost"
      Product: "VHR API - OData Wrapper to FHIR"
  
  4. Once the application is created, make a note of the "Consumer Secret"
     and "Consumer Key". This is going to be used in step 9 in the 
     "Setup, Install & Run" section.
	 
  5. If you don't already have access to a Salesforce1 Developer Edition org, 
     go to https://developer.salesforce.com/signup and create a new account.
	 For more details see the "Request a Salesforce1 developer environment" 
	 section of the OData Cookbook on the dev portal.
	 https://portal.api.pcftest.com/getting-started/api-documentation/odata-api/cookbook

	 
   Documentation
  -------------

  Additional documentation for the OData API as well as the Philips HealthSuite 
  may be found at https://portal.api.pcftest.com/
  
 
  Setup, Install & Run
  ---------------------
  
  1. Extract the contents from ZIP file to a folder on your local storage. 
  
  2. Login to your Salesforce1 platform Developer Edition (DE) org. By default 
     your user account should be associated with the System Administrator 
	 profile. You'll need to be logged in as a Sys Admin for rest of the steps.

  3. From your Salesforce1 org, download the Force.com Migration Tool and 
     install it on your system. Note that Java and Apache Ant are required for 
	 the Force.com Migration Tool to work. Instructions can be found here:
	 http://www.salesforce.com/us/developer/docs/daas/Content/forcemigrationtool_install.htm

  4. From your Salesforce1 org, complete the steps to reset your security token.
     https://help.salesforce.com/apex/HTViewHelpDoc?id=user_security_token.htm

  5. Open the build.properties file and replace the following
       "person.name@mail.com" & "MyPassword+SecurityToken" 
	   
     5.1. The sf.username property ("person.name@mail.com") should be set to 
	      your username for for the Salesforce1 DE org.

     5.2. The sf.password property ("MyPassword+SecurityToken") should be a 
	      concatenation of your Salesforce1 DE org password AND the security 
		  token you got in step # 4.	   
	   
  6. From the directory where you the build.xml file is located, open a command 
     prompt and type: "ant deployUnpackaged". This *should* start the process 
	 of deploying the sample code to your Salesforce1 DE org. Note that errors 
	 can occur at this step due to any number of reasons:
       - Java, Ant, or the Force.com Migration Tool library weren't installed 
	     correctly.
       - Valid credentials weren't specified in the build.properties file.
	   - There are conflicting components in the target Salesforce1 org, 
	     perhaps due to the sample app being installed previously.
		 
  7. If the previous step results in a "BUILD SUCCESSFUL" message then the 
     sample app components were deployed to your Salesforce1 DE org.	 

  8. As a System Administrator, login to your Salesforce1 DE org (if you're not 
     already logged in) and navigate to the Setup console.
	 
  9. Navigate to the "Auth. Providers" section of the Setup console 
     ("Administer" -> "Security Controls" -> "Auth. Providers").
	 
     9.1. Click "Edit" for the "Philips AP" authentication provider.
	 
     9.2. Change the value of the Consumer Key field to be your "Consumer Key" 
	      from the app you created in the dev portal.
	 
     9.3. Change the Consumer Secret field to be your "Consumer Secret" from 
	      the app you created in the dev portal.
	 
     9.4. Click the "Save" button.
	 
     9.5. From detail page for the "Philips AP" authentication provider, copy 
	      the Callback URL value from near the bottom of the page and go back 
		  to the dev portal so you can paste the URL into the "Callback URL" 
		  field of your app.
     
     If you have any doubts about these steps, refer to the OData Cookbook.

 10. Navigate to the "External Data Sources" section of the Setup console 
     ("Build" -> "Develop" -> "External Data Sources").
	 
    10.1. Click "Edit" for the "Philips VHR" data source.
	 
    10.2. Check the box next to "Start Authentication Flow on Save" and click 
	      the "Save" button.
	 
    10.3. You'll be prompted whether you want to allow Salesforce to access the 
	      information for your sample app; click the "Allow" button.	 

    10.4. Back on the "Philips VHR" data source detail page, the Authentication 
	      Status should now be "Authorized"	 
     
     If you have any doubts about these steps, refer to the OData Cookbook.

 11. Navigate to the "External Objects" section of the Setup console 
     ("Build" -> "Develop" -> "External Objects").
	 
    11.1. Click on the "Patient" link to go to the detail view for the Patient 
	      object.

    11.2. Scroll down to "Buttons, Links, and Actions" section and click the 
	      "Edit" link next to "Patients Tab".

    11.3. In the "Override With" field, select "Visualforce Page" from the 
	      radio buttons and then choose "PatientList" from the drop-down.

    11.4. Click the "Save" button.
	 
 12. From the app menu in the upper right corner, choose "HealthSuite Digital 
     Platform".

 13. Click on the "Patients" tab; if all is working you should see a list of 
     patients.
	 - If you receive an error containing the word "unauthorized", you may have 
	   entered your OAuth credentials incorrectly or you skipped the step where 
	   you completed the authentication flow for the External Data Source.

 14. When the Patients tab loads, a call is being made to the Patients resource 
     to get a list of Patients available to that Organization.
 
 15. Clicking on a patient ID takes you to the Patient detail view. From here 
     you can see some details about the patient such as their birth date, 
	 gender, address, phone number, and e-mail. 
 
 16. At the bottom of the Patient detail page is a related list of Observations 
     for that Patient. In this area you can use the "Next Page >" and 
	 "< Previous Page" navigation links and you can also choose to filter the 
	 list by a different Observation type; choose a new value from the 
	 Observation type drop-down and click the "Filter" button. All these 
	 operations result in calls to the Observation resource.
	 
 17. Clicking on an Observation ID will take you to the Observation detail 
     page. This page shows the fields for that Observation. In the case of the 
	 "Blood Pressure" Observation type, the Observation detail page includes a 
	 related list of child Observations that represent the sub-components of 
	 the blood pressure measurement.	 
	 

  Licensing
  ---------

  Copyright (c) 2014-2015 Koninklijke Philips N.V.
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
   
  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
   
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.


  Contacts
  --------

     o  Please visit the Philips HealthSuite Developer portal for any additional
	information around bug fixes, updates and further resources.  The location
	is https://portal.api.pcftest.com/