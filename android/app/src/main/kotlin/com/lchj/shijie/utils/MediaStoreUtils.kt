package com.lchj.shijie.utils

import android.content.ContentResolver
import android.database.Cursor
import android.provider.MediaStore
import com.lchj.shijie.model.VideoDirectoryModel
import io.flutter.Log
import java.io.File

object MediaStoreUtils {

    /**
     * 获取视频文件目录集合
     */
    fun getVideoDirectoryList(contentResolver: ContentResolver) : List<VideoDirectoryModel> {
        var list: MutableList<VideoDirectoryModel> = mutableListOf<VideoDirectoryModel>()
        var dirMap: LinkedHashMap<String, VideoDirectoryModel> = linkedMapOf();
        var cursor : Cursor? = contentResolver.query(
            MediaStore.Video.Media.EXTERNAL_CONTENT_URI,
            null, null,null, MediaStore.Video.Media.DEFAULT_SORT_ORDER);
        if (cursor != null) {
            while (cursor.moveToNext()) {
                var path: String = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Video.Media.DATA))
//                Log.e("test", "getVideoDirectoryList path :$path")
                var parentFile: File = File(path).parentFile
                if (parentFile.exists()) {
                    val absolutePath: String = parentFile.absolutePath;
                    if (dirMap[absolutePath] == null) {
                        dirMap[absolutePath] = VideoDirectoryModel(absolutePath, absolutePath.split("/").last(), 1)
                    } else {
                        dirMap[absolutePath]!!.fileNumber += 1
                    }
                }
//                Log.e("test", "getVideoDirectoryList dirMap :$dirMap")
            }
//            Log.e("test", "getVideoDirectoryList dirMap :$dirMap")
//            Log.e("test", "getVideoDirectoryList dirMap :${dirMap.values}")
            list = ArrayList(dirMap.values);
//            Log.e("test", "getVideoDirectoryList list :$list")
        }
        return list;
    }
}