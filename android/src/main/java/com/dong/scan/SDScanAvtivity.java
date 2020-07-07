package com.dong.scan;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;

import com.journeyapps.barcodescanner.BarcodeResult;
import com.journeyapps.barcodescanner.CaptureManager;
import com.journeyapps.barcodescanner.DecoratedBarcodeView;


public class SDScanAvtivity extends AppCompatActivity {

    private SDCaptureManager captureManager;
    private DecoratedBarcodeView barcodeView;
    private SDScanFinderView scanFinderView;
    private TextView titleView;
    private ImageButton exitButton;
    private ScanConfig config;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent = getIntent();
        config = (ScanConfig)intent.getSerializableExtra("ScanConfig");
        Log.e("打印",config.title);
        setContentView(R.layout.activity_sd_scan_avtivity);
        barcodeView = (DecoratedBarcodeView)findViewById(R.id.dbv_custom);
        titleView = (TextView)findViewById(R.id.scan_view_title);
        titleView.setText(config.title);
        scanFinderView = (SDScanFinderView)barcodeView.getViewFinder();
        scanFinderView.setConfig(config);
        exitButton = (ImageButton)findViewById(R.id.scan_exit_button);
        if (config.returnStyle == 0) {
            exitButton.setImageResource(R.drawable.sd_scan_exit_icon);
        } else {
            exitButton.setImageResource(R.drawable.sd_scan_cancle_icon);
        }
        exitButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
        captureManager = new SDCaptureManager(this,barcodeView);
        captureManager.initializeFromIntent(getIntent(),savedInstanceState);
        captureManager.decode();
    }

    @Override
    protected void onResume() {
        super.onResume();
        captureManager.onResume();
    }

    @Override
    protected void onPause() {
        super.onPause();
        captureManager.onPause();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        captureManager.onDestroy();
    }

    @Override
    public void onSaveInstanceState(Bundle outState, PersistableBundle outPersistentState) {
        super.onSaveInstanceState(outState, outPersistentState);
        captureManager.onSaveInstanceState(outState);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String permissions[], @NonNull int[] grantResults) {
        captureManager.onRequestPermissionsResult(requestCode, permissions, grantResults);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        return barcodeView.onKeyDown(keyCode, event) || super.onKeyDown(keyCode, event);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
    }
}

