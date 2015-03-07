package com.philips.hsdp.helloworld;

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
 * HelloWorldActivity.java
 *
 * @author Himanshu Shrivastava (hshrivastava@gmail.com)
 */

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.philips.hsdp.feed.HelloWorldManager;

public class HelloWorldActivity extends Activity
{
    Button mGetTokenButton, mHelloWorldButton;
    TextView mTokenTextView, mHelloWorldTextView;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_hello_world);

        mTokenTextView = (TextView) findViewById(R.id.displayTokenTextView);
        mHelloWorldTextView = (TextView) findViewById(R.id.helloWorldTextView);

        mGetTokenButton = (Button) findViewById(R.id.getTokenButton);
        mHelloWorldButton = (Button) findViewById(R.id.getHellowWorld);

        hideHelloWorld (true);

        mGetTokenButton.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                if (HelloWorldManager.getInstance().getAccessToken() == null)
                {
                    HelloWorldManager.getInstance().requestAccessToken (new HelloWorldManager.HelloWorldCallListener()
                    {
                        @Override
                        public void helloWorldCallResponse(String inToken)
                        {
                            if (HelloWorldManager.getInstance().getAccessToken() == null)
                            {
                                mTokenTextView.setText (getResources().getString(R.string.tokenRequestError));
                                hideHelloWorld (true);
                            }
                            else
                            {
                                tokenRecievedOrAlreadyExists (getResources().getString(R.string.tokenReceivedString));
                            }
                        }
                    });
                    mHelloWorldTextView.setText ("");
                }
                else
                {
                    tokenRecievedOrAlreadyExists (getResources().getString(R.string.tokenExistsString));
                }
            }
        });

        mHelloWorldButton.setOnClickListener (new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                HelloWorldManager.getInstance().requestHelloWorld(new HelloWorldManager.HelloWorldCallListener()
                {
                    @Override
                    public void helloWorldCallResponse(String inString)
                    {
                        if (inString != null)
                        {
                            mHelloWorldTextView.setText (inString);
                        }
                        else
                        {
                            mHelloWorldTextView.setText (getResources().getString(R.string.tokenExpOrNetworkConnectionIssue));
                            mHelloWorldButton.setVisibility(View.INVISIBLE);
                        }
                    }
                });
            }
        });

    }

    public void tokenRecievedOrAlreadyExists (String inMsg)
    {
        mTokenTextView.setText (inMsg + HelloWorldManager.getInstance().getAccessToken());
        hideHelloWorld (false);
    }

    public void hideHelloWorld (boolean inHidden)
    {
        if (inHidden)
        {
            mHelloWorldButton.setVisibility(View.GONE);
            mHelloWorldTextView.setVisibility(View.GONE);
        }
        else
        {
            mHelloWorldButton.setVisibility(View.VISIBLE);
            mHelloWorldTextView.setVisibility(View.VISIBLE);
        }
    }
}
