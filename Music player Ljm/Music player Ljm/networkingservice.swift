//
//  networkingservice.swift
//  Music player Ljm
//
//  Created by ljm on 2017/5/27.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit

//声明闭包类型
typealias networkCompleteHandle = (_ jsonData:[JSON]?,_ error:Error?)->Void

class networkingservice: NSObject {
    
    //获取搜索数据
    class func getSearchMusicInfo(_ url: String?,completeHondle: @escaping networkCompleteHandle){
        let ecodeUrl = url?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        
        let session: URLSessionTask = URLSession.shared.dataTask(with: URL(string: ecodeUrl!)!, completionHandler: {(data,response,error)->Void in
            let json = JSON(data: data!)["showapi_res_body"]["pagebean"]["contentlist"].array
            completeHondle(json,error)
        })
        
        
        
        session.resume()
    }
    
    //获取榜单数据
    class func getTopListMusicInfo(_ url: String?,completeHondle: @escaping networkCompleteHandle){
        let ecodeUrl = url?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let session: URLSessionTask = URLSession.shared.dataTask(with: URL(string: ecodeUrl!)!, completionHandler: {(data,response,error)->Void in
            let json = JSON(data: data!)["showapi_res_body"]["pagebean"]["songlist"].array
            completeHondle(json,error)
        })
        session.resume()
    }
    
    
    //获取歌词
    class func getMusicLyric(_ url: String?,completeHondle: @escaping networkCompleteHandle){
        let ecodeUrl = url?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let session: URLSessionTask = URLSession.shared.dataTask(with: URL(string: ecodeUrl!)!, completionHandler: {(data,response,error)->Void in
            _ = JSON(data: data!)["showapi_res_body"]["lyric"].string
        })
        session.resume()
    }
}
