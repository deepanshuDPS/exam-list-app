package com.dps.examu

import android.os.Bundle
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import com.dps.exam_list.R
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity(){

    override fun onCreate(savedInstanceState: Bundle?) {
        if (savedInstanceState != null) this.setTheme(R.style.Theme_MySplashScreen)
        super.onCreate(savedInstanceState)
        if (savedInstanceState == null) {
            installSplashScreen()
        }
    }

}
