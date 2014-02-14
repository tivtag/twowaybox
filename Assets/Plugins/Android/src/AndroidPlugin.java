package com.federrot.lstdt;

import com.unity3d.player.UnityPlayerActivity;
import android.content.Context;
import android.os.Bundle;
import android.util.Config;
import android.util.Log;
import android.view.View;

public class AndroidPlugin extends UnityPlayerActivity
{
	@Override
	protected void onCreate(Bundle myBundle) {
		super.onCreate(myBundle);
	}
	
	@Override
	protected void onResume() {
		super.onResume();
		if (android.os.Build.VERSION.SDK_INT >= 19) { // KITKAT
			int flags = View.SYSTEM_UI_FLAG_LAYOUT_STABLE
				| View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
				| View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
				| View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
				| View.SYSTEM_UI_FLAG_FULLSCREEN
				| View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY;

			this.findViewById(android.R.id.content).setSystemUiVisibility(flags);
		}
	}

	@Override
	protected void onPause() {
		super.onPause();
	}
	
	@Override
	protected void onStop() {
		super.onStop();
	}
}