package com.lchj.shijie.model

class VideoDirectoryModel {
    var path: String = "";
    var name: String = "";
    var fileNumber: Int = 0;

    constructor(path: String, name: String, fileNumber: Int) {
        this.path = path
        this.name = name
        this.fileNumber = fileNumber
    }



    override fun toString(): String {
        return "VideoDirectoryModel(path='$path', name='$name', fileNumber=$fileNumber)"
    }

}