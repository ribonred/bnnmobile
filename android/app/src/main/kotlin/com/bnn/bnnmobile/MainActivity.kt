package com.bnn.bnnmobile

import android.os.Bundle
import vn.hunghd.flutterdownloader.FlutterDownloaderPlugin
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
  }
  
}

