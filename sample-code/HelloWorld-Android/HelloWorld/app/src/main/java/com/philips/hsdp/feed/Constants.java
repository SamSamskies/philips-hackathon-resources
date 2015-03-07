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
 * Constants.java
 *
 * @author Himanshu Shrivastava (hshrivastava@gmail.com)
 */

public class Constants
{
    /*
     * Client ID and secret from the philips app portal to authenticate the validity of the app
     * Used to get the token from the server to use the API.
     */
    public static final String CLIENT_ID = "CLIENT_KEY_HERE";
    public static final String CLIENT_SECRET = "CLIENT_SECRET_HERE";

    /* Base URL */
    public static final String BASE_URL = "https://gateway.api.pcftest.com:9004/";

    /*
     * Following variables should not be changed.
     */
    private static final String BASE_URL_AUTH_PATH = BASE_URL + "v1/oauth2/";
    public static final String BASE_URL_TOKEN = BASE_URL_AUTH_PATH + "token?grant_type=client_credentials";
    public static final String BASE_URL_HELLOWORLD = BASE_URL + "hello-world/";
}
