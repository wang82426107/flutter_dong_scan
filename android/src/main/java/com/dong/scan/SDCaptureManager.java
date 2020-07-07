package com.dong.scan;

import android.app.Activity;
import android.util.Log;

import com.journeyapps.barcodescanner.BarcodeResult;
import com.journeyapps.barcodescanner.CaptureManager;
import com.journeyapps.barcodescanner.DecoratedBarcodeView;

public class SDCaptureManager extends CaptureManager {

    private Activity activity;

    public SDCaptureManager(Activity activity, DecoratedBarcodeView barcodeView) {
        super(activity, barcodeView);
        this.activity = activity;
    }

    @Override
    protected void returnResult(BarcodeResult rawResult) {
        ResultDataManager.getInstance().setBarcodeResult(rawResult);
        activity.finish();
    }
}

