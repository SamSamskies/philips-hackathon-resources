package com.philips.hsdp.mobiledhp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import com.philips.hsdp.feed.Constants;
import com.philips.hsdp.feed.LoginManager;

import java.util.Observable;
import java.util.Observer;

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
 * LoginActivity.java
 *
 * Created by Himanshu Shrivastava (hshrivastava@gmail.com)
 */

public class LoginActivity extends Activity
{

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        LoginManager loginManager = LoginManager.getInstance();
        loginManager.addObserver (new Observer()
        {
            @Override
            public void update(Observable observable, Object data)
            {
                //Log.i("HS", "HERE------");
                handleLoginResponse();
            }
        });

        findViewById(R.id.loginButton).setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                authUser();
            }
        });
    }

    @Override
    public void onResume()
    {
        super.onResume();

        ((EditText)findViewById(R.id.loginPwd)).setText("");
        ((TextView)findViewById(R.id.errorDesc)).setText("");

    }

    private void authUser ()
    {
        findViewById(R.id.authenticatingView).setVisibility(View.VISIBLE);

        String loginName = ((EditText)findViewById(R.id.loginName)).getText().toString().trim();
        String loginPwd = ((EditText)findViewById(R.id.loginPwd)).getText().toString().trim();

        if (loginName.isEmpty() || loginPwd.isEmpty())
        {
            if (loginName.isEmpty())
                ((TextView) findViewById(R.id.errorDesc)).setText("Username not entered");
            if (loginPwd.isEmpty())
                ((TextView) findViewById(R.id.errorDesc)).setText("Password not entered");


            findViewById(R.id.authenticatingView).setVisibility(View.GONE);
        }
        else
        {
            LoginManager.getInstance().authenticate(loginName, loginPwd, null);
        }
    }


    private void handleLoginResponse()
    {

        findViewById(R.id.authenticatingView).setVisibility(View.GONE);

        if (LoginManager.getInstance().isAuthenticated())
        {
            //Log.i("HS", "LOGGED IN");

            String urlPatient = LoginManager.getInstance().getPatientUrlIdString();

            Intent activityIntent = new Intent(LoginActivity.this, PatientInfoActivity.class);

            startActivity(activityIntent);
        }
        else
        {
            //Log.i("HS", "NOT LOGGED IN");
            ((TextView) findViewById(R.id.errorDesc)).setText("Username/Password incorrect, Try again");
        }

    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu)
    {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_login, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item)
    {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings)
        {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
