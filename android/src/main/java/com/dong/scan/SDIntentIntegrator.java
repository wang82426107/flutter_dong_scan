package com.dong.scan;

import android.app.Activity;
import android.content.Intent;

import com.google.zxing.client.android.Intents;
import com.google.zxing.integration.android.IntentIntegrator;

public class SDIntentIntegrator extends IntentIntegrator {

    private ScanConfig config;

    public SDIntentIntegrator(Activity activity) {
        super(activity);
    }

    @Override
    public Intent createScanIntent() {
        Intent intent = super.createScanIntent();
        if (config != null) {
            intent.putExtra("ScanConfig", config);
        }
        return intent;
    }

    public IntentIntegrator setScanConfig(ScanConfig config) {
        this.config = config;
        return this;
    }

    public ScanConfig getConfig() {
        return config;
    }

    public void setConfig(ScanConfig config) {
        this.config = config;
    }
}
