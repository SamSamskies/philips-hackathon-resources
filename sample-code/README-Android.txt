Philips HealthSuite Digital Platform (HSDP) 
Android Application
  
  What is it?
  -----------

  The Philips Android sample application demonstrates core capabilities of the 
  Philips HealthSuite FHIR API.  Basic concepts including acquiring a token, 
  authenticating and logging into and out of the application via the 
  HealthSuite API. Additionally, retrieving patient demographic information 
  as well as an organization are shown. The key concept of retrieving 
  observations is highlighted as well as the ability to page back and forth 
  over a set of observations.  
 
  
  Operations
  -----------
  
  - Login
  - Get Patient(s)
  - Get Observation(s)
  - Get Organization(s)
  - Observation Filtering and Pagination
  - Logout


  Pre-requisite
  --------------
  
  You need to have an account on the dev portal to build the application. 
  (https://portal.api.pcftest.com/getting-started)

  1. Create an account

  2. Wait for the approval (within 24 hours)
  
  3. Create an application with 
      App Name: "Sample App", 
      Callback URL: "localhost"
      Product: "VHR API - RESTful FHIR"
  
  4. Once the application is created, make a note of the "Consumer Secret"
     and "Consumer Key". This is going to be used in step 4 in the 
     "Setup, Install & Run" section.


  Documentation
  -------------

  Additional documentation for the FHIR API as well as the Philips HealthSuite 
  may be found at https://portal.api.pcftest.com/
  

  Setup, Install & Run
  ---------------------
  
  1. Copy the folder to the hard-drive.

  2. Open AndroidStudio (http://developer.android.com/sdk/index.html)
       Requires 21.1.2 Android SDK build tools, so if it's not installed, 
       open AndroidStudio SDK Manager and install it.

  3. Select "Open an existing Android Studio Project" and select the 
     SampleDHPApp folder.
  
  4. Open the Constants.java file and fill in following
       "CLIENT_ID" & "CLIENT_SECRET" 
         This will come from the dev portal after registering the VHR 
         application for "API - RESTful FHIR" product. It maps to 
         "Consumer Key" & "Consumer Secret"

  5. Build and run the app on the device/emulator.

  6. Enter username and password in the login page and press the Login button.
     This will go through the two steps for authenticating the app and 
     the user, via OAuth2.

     6.1. token
          The app receives a token from server. If there is an error, check 
          your network and verify that CLIENT_ID and CLIENT_SECRET are  
          correct. If they are not correct, go back to step 4.

     6.2. login
          Uses the above token to authenticate the user and enable 
          other calls.

  7. After the user logs in, the patient information page is displayed.
     Information is retrieved using these three calls 
	 (see FHIR Cookbook for details):
     
     7.1. patient
          (name, phone, gender, etc.)

     7.2. observations
          array of observations associated with the patient
		  (date or date range, value, units, etc)
     
     7.3. organization
          (name, location, etc)

  8. Information on the page sections can be refreshed by clicking respective 
     headers (refresh person info, refresh observations).

  9. The next and previous observation buttons appear as applicable. 
     Clicking on them will display the next/previous set of observations.
      
  10. The filter button is used to filter data by observation type.

      10.1. Clicking the button will bring a popup menu with all the observation 
            types

      10.2. Selecting the observation type will close the popup menu and refresh 
            the list with only observations of that type.

  11. The logout button terminates the session and takes the user back to the login 
      page.
  

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
  Please visit the Philips HealthSuite Developer portal for any additional
  information around bug fixes, updates and further resources.  The location
  is https://portal.api.pcftest.com/


