package com.philips.hsdp.mobiledhp;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.philips.hsdp.feed.LoginManager;
import com.philips.hsdp.feed.ObservationFeed;
import com.philips.hsdp.feed.OrganizationFeed;
import com.philips.hsdp.feed.PatientFeed;
import com.philips.hsdp.mobiledhp.adapters.ObservationListViewAdapter;
import com.philips.hsdp.model.HSDPOrganization;
import com.philips.hsdp.model.HSDPPatient;

import java.util.List;
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
 * PatientInfoActivity.java
 *
 * Created by Himanshu Shrivastava (hshrivastava@gmail.com)
 */

public class PatientInfoActivity extends Activity
{
    int mPatientListIndex = -1;
    String mPatientUrlLink = null;

    PatientFeed mPatientInfoFeed = null;
    TextView mGender, mStatus, mBirthDate, mNames, mAddresses, mPhones; // mLastUpdated,

    ObservationFeed mObservationFeed = null;
    ListView mObservationListView;
    TextView mObservationCount;
    ObservationListViewAdapter mObservationAdapter;
    Button mNextPageObservationButton, mPrevPageObservationButton;

    OrganizationFeed mOrganizationFeed = null;
    String mObservationFilterBy = null;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_patient_info);

        mNextPageObservationButton = (Button) findViewById(R.id.nextButton);
        mPrevPageObservationButton = (Button) findViewById(R.id.prevButton);

        mPatientUrlLink = LoginManager.getInstance().getPatientUrlIdString(); // this.getIntent().getStringExtra(Constants.PATIENT_URL_LINK);
        mPatientListIndex = -1; //this.getIntent().getIntExtra(Constants.PATIENT_LIST_INDEX, -1);

        if (mPatientUrlLink == null || mPatientUrlLink.isEmpty())
            this.finish();

        mGender = (TextView) this.findViewById(R.id.patientGender);
        mStatus = (TextView) this.findViewById(R.id.patientStatus);
//        mLastUpdated = (TextView) this.findViewById(R.id.patientLastUpdated);
        mBirthDate = (TextView) this.findViewById(R.id.patientBirthDate);
        mNames = (TextView) this.findViewById(R.id.patientNames);
        mAddresses = (TextView) this.findViewById(R.id.patientAddresses);
        mPhones = (TextView) this.findViewById(R.id.patientPhones);

        mObservationCount = (TextView) this.findViewById(R.id.observationCount);

        mPatientInfoFeed = PatientFeed.getNewInstance();
        String patientFeedUrl = PatientFeed.generatePatientFeedUrl(mPatientUrlLink);
        //Log.i("HS", "PatientFeedUrl: " + patientFeedUrl);
        mPatientInfoFeed.setFeedUrl(patientFeedUrl);
        mPatientInfoFeed.addObserver(new Observer()
        {
            @Override
            public void update(Observable observable, Object data)
            {
                refreshView();
                findViewById(R.id.patientProgressBar).setVisibility(View.GONE);
            }
        });

        String observationTypeNames[] = getResources().getStringArray(R.array.observationTypeName);
        final String observationTypeCodes[] = getResources().getStringArray(R.array.observationTypeCode);
        final ArrayAdapter<String> adapter = new ArrayAdapter<String>(PatientInfoActivity.this, android.R.layout.simple_list_item_1, observationTypeNames);


        final AlertDialog.Builder builder = new AlertDialog.Builder(PatientInfoActivity.this);
            builder.setTitle("Obseration Type Filter");
            builder.setOnCancelListener(new DialogInterface.OnCancelListener()
            {
                @Override
                public void onCancel(DialogInterface dialog)
                {
                    dialog.dismiss();
                }
            });

        final ListView listView = new ListView(builder.getContext());
        listView.setAdapter(adapter);
        builder.setView(listView);

        final AlertDialog observationFilterDialog = builder.create();
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener()
        {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id)
            {
                mObservationFilterBy = observationTypeCodes[position].equals("") ? null : observationTypeCodes[position];

                String observationFeedUrl = ObservationFeed.generateObservationUrl(mPatientUrlLink.replace("/Patient/", ""), mObservationFilterBy, null, null);
                //Log.i("HS", "ObservationFeedUrl: " + observationFeedUrl);
                mObservationFeed.setFeedUrl(observationFeedUrl);

                findViewById(R.id.observationProgressBar).setVisibility(View.VISIBLE);
                mObservationFeed.refresh();

                observationFilterDialog.dismiss();
            }
        });
        findViewById(R.id.observationFilterButton).setOnClickListener (new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                observationFilterDialog.show();
            }
        });

        mOrganizationFeed = OrganizationFeed.getNewInstance();
        String organizationFeedUrl = OrganizationFeed.generateOrganizationFeedUrl (LoginManager.getInstance().getOrganizationUrlIdString());
        mOrganizationFeed.setFeedUrl (organizationFeedUrl);
        mOrganizationFeed.addObserver(new Observer()
        {
            @Override
            public void update(Observable observable, Object data)
            {
                if (mOrganizationFeed.getOrganizationList() != null)
                {
                    List<HSDPOrganization> orgList = mOrganizationFeed.getOrganizationList();
                    HSDPOrganization organization = orgList.get(0);
                    ((TextView) findViewById(R.id.patientOrganization)).setText(organization.getOrganizationName());
                }
            }
        });
        mOrganizationFeed.refresh();

        mObservationFeed = ObservationFeed.getInstance();
        String observationFeedUrl = ObservationFeed.generateObservationUrl(mPatientUrlLink.replace("/Patient/", ""), null, null, null);
        //Log.i("HS", "ObservationFeedUrl: " + observationFeedUrl);
        mObservationFeed.setFeedUrl(observationFeedUrl);
        mObservationFeed.addObserver(new Observer()
        {
            @Override
            public void update(Observable observable, Object data)
            {
                refreshObservationView();
            }
        });

        mObservationListView = (ListView) this.findViewById(R.id.observationListView);
        mObservationAdapter = new ObservationListViewAdapter(this, R.layout.listitem_observation_item, mObservationFeed.getObservationList());
        mObservationListView.setAdapter(mObservationAdapter);

        this.findViewById(R.id.getDataButton).setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                findViewById(R.id.patientProgressBar).setVisibility(View.VISIBLE);
                mPatientInfoFeed.refresh();
            }
        });

        this.findViewById(R.id.getBloodPressureObservation).setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                findViewById(R.id.observationProgressBar).setVisibility(View.VISIBLE);
                mObservationFeed.refresh();
            }
        });

        this.findViewById(R.id.logoutButton).setOnClickListener (new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                LoginManager.getInstance().logout( new LoginManager.LogoutListener()
                {
                    @Override
                    public void logoutCompleted(final boolean inSuccessful)
                    {
                        runOnUiThread(new Runnable()
                                      {
                                          @Override
                                          public void run()
                                          {
                                              String msg = "Logout completed" + (inSuccessful ? "" : " with error");
                                              Toast.makeText(PatientInfoActivity.this, msg, Toast.LENGTH_SHORT).show();
                                          }
                                      });
                        finish();
                    }
                });
            }
        });


        mNextPageObservationButton.setOnClickListener (new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                String nextPageUrl = mObservationFeed.getNextPageLinkUrl();
                mObservationFeed.setFeedUrl(nextPageUrl);
//                mObservationFeed.refresh();
                findViewById(R.id.getBloodPressureObservation).performClick();
            }
        });
        mPrevPageObservationButton.setOnClickListener (new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                String previousPageUrl = mObservationFeed.getPreviousPageLinkUrl();
                mObservationFeed.setFeedUrl(previousPageUrl);
//                mObservationFeed.refresh();
                findViewById(R.id.getBloodPressureObservation).performClick();
            }
        });

        refreshView();
        this.findViewById(R.id.getDataButton).performClick();
        this.findViewById(R.id.getBloodPressureObservation).performClick();
    }


    @Override
    public void onBackPressed()
    {
        LoginManager.getInstance().logout(new LoginManager.LogoutListener()
        {
            @Override
            public void logoutCompleted(final boolean inSuccessful)
            {
                runOnUiThread(new Runnable()
                {
                    @Override
                    public void run()
                    {
                        String msg = "Logout completed" + (inSuccessful ? "" : " with error");
                        Toast.makeText(PatientInfoActivity.this, msg, Toast.LENGTH_SHORT).show();
                        PatientInfoActivity.super.onBackPressed();
                    }
                });
            }
        });
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu)
    {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_patient_info, menu);
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

    private void refreshObservationView()
    {
        mObservationAdapter.notifyDataSetChanged();
        int count = mObservationAdapter.getCount(); // mObservationFeed.getObservationList().size();
        mObservationCount.setText("Page: " + mObservationFeed.getCurrentPageNo() + "/" + mObservationFeed.getTotalNoPages()
                                + " (" + mObservationFeed.getTotalRecordsOnServer() +" Records)");

        mNextPageObservationButton.setVisibility(mObservationFeed.getNextPageLinkUrl() != null ? View.VISIBLE : View.GONE);
        mPrevPageObservationButton.setVisibility(mObservationFeed.getPreviousPageLinkUrl() != null ? View.VISIBLE : View.GONE);
        findViewById(R.id.observationProgressBar).setVisibility(View.GONE);
    }

    private void refreshView()
    {
        // here
        //Log.d("HS", "getCommonInstance: " + PatientFeed.getInstance().getPatientList().size());
        //Log.d("HS", "mPatientInfoFeed: " + mPatientInfoFeed.getPatientList().size());

        HSDPPatient patient = null;
        if (mPatientInfoFeed.getPatientList().size() == 0 && PatientFeed.getInstance().getPatientList().size() > 0)
            patient = PatientFeed.getInstance().getPatientList().get(mPatientListIndex);
        else if (mPatientInfoFeed.getPatientList().size()>0)
            patient = mPatientInfoFeed.getPatientList().get(0);

        if (patient == null)
            return;

        mGender.setText(patient.getGender());
        mStatus.setText(patient.getStatus());
//        mLastUpdated.setText(patient.getHumanReadableDateUpdated());
        mBirthDate.setText(patient.getBirthdate());
        mNames.setText(TextUtils.join("\n", patient.getNames()));
        mAddresses.setText(TextUtils.join("\n", patient.getAddresses()));
        mPhones.setText(TextUtils.join("\n", patient.getPhones()));
    }
}
