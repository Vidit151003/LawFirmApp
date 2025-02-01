package io.flutter.app;

import androidx.multidex.MultiDexApplication;
import androidx.multidex.MultiDex;
import android.content.Context;

public class FlutterMultiDexApplication extends MultiDexApplication {
  @Override
  protected void attachBaseContext(Context base) {
    super.attachBaseContext(base);
    MultiDex.install(this);
  }
}