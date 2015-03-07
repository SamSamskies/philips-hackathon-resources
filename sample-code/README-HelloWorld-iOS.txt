Philips HealthSuite Digital Platform (HSDP) 
HelloWorld iOS Application

  What is it?
  -----------
  
  Simple HelloWorld application demonstrates a two step process to interact
  with the server.


  Pre-requisite
  --------------
  
  You need to have an account on the dev portal to build the application. 
  (https://portal.api.pcftest.com/getting-started)

  1. Create an account

  2. Wait for the approval (within 24 hours)
  
  3. Create an application with 
      App Name: "HelloWorld", 
      Callback URL: "localhost"
      Product: "Hello World"
  
  4. Once the application is created, make a note of the "Consumer Secret"
     and "Consumer Key". This is going to be used in step 4 in the 
     "Setup, Install & Run" section.


  Documentation
  --------------

  Additional documentation for the FHIR API as well as the Philips HealthSuite 
  may be found at https://portal.api.pcftest.com/


  Setup, Install & Run
  ---------------------
  
  1. Copy the folder to the hard-drive.
  
  2. Open XCode.

  3. Select "Open another project" and then select the folder or select 
        HelloWorld.xcodeproj 
  
  4. Open Constants.java file and fill in following
       "CLIENT_ID" & "CLIENT_SECRET" 
         This will come from the dev portal after registering the application 
         for "Hello World" product. It maps to "Consumer Key" & "Consumer 
         Secret".

  5. Build and run the app.

  6. Once the app runs, press the "Get Token" button to get the bearer token, 
     this is going to be used for rest of the calls.

  7. If token request fails, then either the network is not available or Client 
     ID and Secret is not correct. Go back to step 4. 

  8. If token requests succeeds, then the "Say Hello World" button will appear.

  9. Clicking the "Say Hello World" button will invoke the hello-world call to
     the server and returns "Hello World!" response from server.

  10. If you reached this step, CONGRATULATIONS!!! 
      You will be using the same process for the other two products:
         VHR API - RESTful FHIR 
         VHR API - OData Wrapper to FHIR


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
  is https://portal.api.pcftest.com/.


