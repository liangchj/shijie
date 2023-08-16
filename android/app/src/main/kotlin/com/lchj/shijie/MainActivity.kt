package com.lchj.shijie

import android.content.ContentResolver
import android.os.Bundle
import com.google.gson.Gson
import com.lchj.shijie.model.VideoDirectoryModel
import com.lchj.shijie.utils.MediaStoreUtils
import com.lchj.shijie.utils.MethodChannelUtils
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private lateinit var _contentResolver: ContentResolver
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        _contentResolver = this.contentResolver
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        //1.创建android端的MethodChannel
        val methodChannel = MethodChannel(flutterEngine.dartExecutor, MethodChannelUtils.METHOD_CHANNEL_MEDIA_STORE)
        //2.通过setMethodCallHandler响应Flutter端的方法调用
        methodChannel.setMethodCallHandler { call, result ->
            //判断调用的方法名
            if(call.method.equals("getMediaStoreVideoDirList")){
                //获取传递的参数
                var list: List<VideoDirectoryModel> = MediaStoreUtils.getVideoDirectoryList(contentResolver)
                val toJson = Gson().toJson(list)
//                Log.e("test", "Have received Test Method Call :$list")
//                Log.e("test", "Have received Test Method Call :$toJson")
                //返回结果给Flutter端
                result.success(toJson)
            }
        }
    }
}
