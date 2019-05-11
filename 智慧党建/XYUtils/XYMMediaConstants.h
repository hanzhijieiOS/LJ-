//
//  XYMMediaConstants.h
//  MobileApp
//
//  Created by dengtuotuo on 2017/11/17.
//  Copyright © 2017年 xiyoumobile. All rights reserved.
//

#ifndef XYMMediaConstants_h
#define XYMMediaConstants_h


///!!!!!!!!--请合理的使用基于通知，Block，delegate这几种方式回调，如果多个使用，将产生多个回调---!!!!!!!!
// notification -- 下载通知事件使用 所有的key均为基于观察者下载回调得参数名
//eventName使用progress 与 complete两个value进行进度通知和完成通知
#define Notification_DownloadEvent @"Notification_DownloadEvent"

// notification --
#define Notification_DownloadSuspend @"Notification_DownloadSuspend"

typedef void(^XYMDataNoParamsBlock)();
typedef void(^XYMDataDownloaderProgressBlock)(NSProgress * _Nullable progress, NSURL * _Nullable targetURL);
typedef void(^XYMDataDownloaderDestinationBlock)(NSURL * _Nullable fileURL);
typedef void(^XYMDataDownloaderCompletedBlock)(id _Nullable object, NSError * _Nullable error, BOOL finished);

typedef NS_ENUM(NSInteger,XYMDownloaderStatus){
    
    
    XYMDownloaderStatusNone = 0,           // 未知状态or未下载状态
    XYMDownloaderStatusDownloading = 1 << 1,    // 正在下载
    XYMDownloaderStatusPause = 1 << 2,      // 暂停状态   (其实已经取消，但是存在缓存文件)
    XYMDownloaderStatusFinish = 1 << 3,   // 下载完成
    
};


typedef NS_OPTIONS(NSInteger,XYMDownloadOptions) {
    //默认下载操作
    XYMDownloadDefault = 1 << 0,
    //允许后台操作
    XYMDownloadContinueInBackground = 1 << 2,
};

/**
 *  下载队列执行顺序
 */
typedef NS_ENUM(NSInteger, XYMDownloaderExecutionOrder) {
    XYMDownloaderExecutionOrderFIFO, // 先进先出
    XYMDownloaderExecutionOrderLIFO  // 后进先出
};

typedef  NS_ENUM(NSInteger, XYMMediaType){
    
    XYMMediaTypeUnknow = 0, //未知类型
    
    XYMMediaTypeAudio, //声音文件
    
    XYMMediaTypeImg ,  //图片类型
    
    XYMMediaTypePlugin,    // 插件类型
    
    XYMMediaTypeVideo,   //视频类型
    
    XYMMediaTypeFile,    //对象归档使用 zip下载文件
    
    XYMMediaTypeTmp      //断点下载的临时文件路径
};



#endif /* XYMMediaConstants_h */
