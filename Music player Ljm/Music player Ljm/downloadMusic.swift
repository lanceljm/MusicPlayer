//
//  downloadMusic.swift
//  Music player Ljm
//
//  Created by ljm on 2017/5/31.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit

class downloadMusic: NSObject {
    
    static let shared = downloadMusic()
    
    /* 下载队列 */
    var downQueue = [Songs]()
    
    /* 下载进度 */
    var currentDownProgress:CGFont!
    
    /* 当前下载任务索引 */
    var currentDownIndex:Int!
    
    /* 下载路径 */
    var downPath:String!
    
    
    
//MARK: -   开始下载
    func startDownAtIndex( _ atIndex:Int)  {
        print("start down")
        
        /* 处理字符串，获得歌曲存放的路径 */
        downPath = NSHomeDirectory() + "/Documents/Music/" + downQueue[atIndex].songname + ".mp3"
        
        print("当前歌曲的路径是：%@",downPath)
        
        let topVC = self.getCurrentViewController()
        let fileManager = FileManager.default
        let downURL = downQueue[atIndex].downUrl
        
        let session = URLSession.shared.downloadTask(with: URL(string:downURL!)!, completionHandler: {(url , response , eror) -> Void in
            
            do{
                if !fileManager.fileExists(atPath: NSHomeDirectory() + "/Documents/Music/")
                {
                    try fileManager.createDirectory(atPath: self.downPath, withIntermediateDirectories: true, attributes: nil)
                }
                
                try fileManager.moveItem(atPath: (url?.path)!, toPath: self.downPath)
                congfig.showAlertVC(topVC, "提示", "歌曲\((self.downQueue[atIndex].songname)!) 下载成功")
            }
            catch{
                print("move file error")
                
                congfig.showAlertVC(topVC, "提示", "歌曲\((self.downQueue[atIndex].songname)!) 已经存在")
            }
            
        })
        
        session.resume()
        print("start down")
        
        
        
    }
    
    
    
    //MARK: -   获取当前屏幕显示的控制器
    func getCurrentViewController() -> UIViewController {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        
        var topVC = rootVC
        
        if topVC?.presentedViewController != nil {
            topVC = topVC?.presentedViewController
        }
        
        return topVC!
        
    }
    

}
