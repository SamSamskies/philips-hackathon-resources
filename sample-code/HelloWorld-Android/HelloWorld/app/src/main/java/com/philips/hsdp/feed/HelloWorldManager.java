package com.philips.hsdp.feed;

/**
 * Copyright (c) 2014-2015 Koninklijke Philips N.V.
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * HelloWorldManager.java
 * Singleton that contains following calls used for interacting with server
 * 1. token
 *    This call is made with Authorization Header of base64 encoded consumer key and secret.
 *    Returns a JSON with the access token from the server.
 *    This access token allows other interactions with the server from the app. No interactions can be done without a valid token.
 * 2. hello-world
 *    This call uses the access token in the authorization header, and returns "Hello, World!" message if the token is valid.
 *
 * @author Himanshu Shrivastava (hshrivastava@gmail.com)
 */


import android.os.AsyncTask;
import android.util.Base64;

import com.google.gson.JsonObject;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.StatusLine;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

public class HelloWorldManager
{
    public interface HelloWorldCallListener
    {
        public void helloWorldCallResponse (String inResponse);
    }

    private static HelloWorldManager sHelloWorldManager = null;

    private String mAccessToken = null;


    private HelloWorldManager()
    {
    }

    public static HelloWorldManager getInstance()
    {
        if (sHelloWorldManager == null)
        {
            sHelloWorldManager = new HelloWorldManager();
        }
        return sHelloWorldManager;
    }



    public String getAccessToken()
    {
        return mAccessToken;
    }



    public String getAuthorizationBearerHttpHeader ()
    {
        return "Bearer " + mAccessToken;
    }


    public static String getStringFromHttpResponse (HttpResponse inResponse)
    {
        String responseString = null;
        try
        {
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            inResponse.getEntity().writeTo(out);
            out.close();
            responseString = out.toString();
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }

        return responseString;
    }


    public void requestAccessToken (HelloWorldCallListener inListener)
    {
        new RequestAccessTokenTask(inListener).execute();
    }


    public void resetAccessToken ()
    {
        mAccessToken = null;
    }


    public void requestHelloWorld (HelloWorldCallListener inListener)
    {
        new HelloWorldTask(inListener).execute();
    }


    /*
     * AsyncTask to get the bearer token from the server
     */
    private class RequestAccessTokenTask extends AsyncTask<Void, Void, String>
    {
        HelloWorldCallListener mListener = null;
        public RequestAccessTokenTask (HelloWorldCallListener inListener)
        {
            mListener = inListener;
        }


        @Override
        protected String doInBackground(Void... params)
        {
            com.google.gson.JsonParser parser = new com.google.gson.JsonParser();

            HttpClient httpClient = new DefaultHttpClient();

            String authString = Constants.CLIENT_ID + ":" + Constants.CLIENT_SECRET;
            String base64AuthString = "Basic " + Base64.encodeToString(authString.getBytes(), Base64.NO_WRAP);

            HttpPost httpPostToken = new HttpPost(Constants.BASE_URL_TOKEN);
            httpPostToken.setHeader("Authorization", base64AuthString);

            try
            {
                HttpResponse responseToken = httpClient.execute(httpPostToken);
                StatusLine statusLine = responseToken.getStatusLine();

                if (statusLine.getStatusCode() == HttpStatus.SC_OK)
                {
                    JsonObject jsonComplete = parser.parse(HelloWorldManager.getStringFromHttpResponse(responseToken)).getAsJsonObject();
                    String accessToken = jsonComplete.get("access_token").getAsString();
                    mAccessToken = accessToken;
                }
                else
                {
                    resetAccessToken();
                }
            } catch (UnsupportedEncodingException e)
            {
                e.printStackTrace();
            } catch (IOException e)
            {
                e.printStackTrace();
            }

            return mAccessToken;
        }

        @Override
        protected void onPostExecute(String inAccessToken)
        {
            super.onPostExecute(inAccessToken);
            if (mListener != null)
                mListener.helloWorldCallResponse (mAccessToken);
        }
    }


    /*
     * Async Task to get message from server
     */
    private class HelloWorldTask extends AsyncTask<Void, Void, String>
    {
        HelloWorldCallListener mListener = null;
        public HelloWorldTask (HelloWorldCallListener inListener)
        {
            mListener = inListener;
        }


        @Override
        protected String doInBackground(Void... params)
        {
            String returnString = null;

            HttpClient httpClient = new DefaultHttpClient();

            HttpGet httpGetHelloWorld = new HttpGet(Constants.BASE_URL_HELLOWORLD);
            httpGetHelloWorld.setHeader("Accept", "text/plain");
            httpGetHelloWorld.setHeader("Authorization", HelloWorldManager.getInstance().getAuthorizationBearerHttpHeader());

            try
            {
                HttpResponse response = httpClient.execute(httpGetHelloWorld);
                StatusLine statusLine = response.getStatusLine();

                if (statusLine.getStatusCode() == HttpStatus.SC_OK)
                    returnString = HelloWorldManager.getStringFromHttpResponse(response);
            } catch (UnsupportedEncodingException e)
            {
                e.printStackTrace();
            } catch (IOException e)
            {
                e.printStackTrace();
            }

            if (returnString == null)
                resetAccessToken();

            return returnString;
        }

        @Override
        protected void onPostExecute(String inString)
        {
            super.onPostExecute(inString);
            if (mListener != null)
                mListener.helloWorldCallResponse (inString);
        }
    }
}
