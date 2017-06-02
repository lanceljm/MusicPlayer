//
//  SongInfoController.swift
//  Music player Ljm
//
//  Created by ljm on 2017/5/27.
//  Copyright © 2017年 ljm. All rights reserved.
//

import Foundation


typealias ConvertModelCompleteModel = ( _ songMolde:[Songs]? , _ error:Error?) -> Void


class SongInfoController {

    //MARK: -    搜索歌曲信息
    func getSongModelWithName(name:String , completeHandle:@escaping ConvertModelCompleteModel) -> Void {
        
        let url = "\(searchSongAPI)？keyword=\(name)&page=\(page)&showapi_appid=\(showapi_appid)&showapi_timestamp=\(currentTime)&showapi_sign=\(showapi_sign)"
        networkingservice.getSearchMusicInfo(url, completeHondle: {(jsonData , error) -> Void in
        
            if let songlist = jsonData{
                let songModles = self.convertJsonToModel(jsonData: songlist, m4aName: "m4a")
                completeHandle(songModles , error)
            }else
            {
                completeHandle(nil , error)
            }
        
        })
        
        
        
    }
    
    
    
    //MARK: -   榜单信息
    func getSongsModelWithTopID(topid:Int , completehandle:@escaping ConvertModelCompleteModel) -> Void {
        
//        let parm = ["topid":topid,"showapi_appid":showapi_appid,"showapi_sign":showapi_sign,"showapi_timestamp":currentTime] as [String : Any]
//        networktools.shared.request(url: topListSongAPI, parameters: parm) { (data, err) in
//            if (err == nil) {
//                print("歌单请求成功")
//                print(data!)
//            }else
//            {
//                print("歌单请求失败")
//            }
//        }
        
        
        
        let url = "\(topListSongAPI)?topid=\(topid)&showapi_appid=\(showapi_appid)&showapi_sign=\(showapi_sign)&showapi_timestamp=\(currentTime)"
        
        networkingservice.getTopListMusicInfo(url, completeHondle: {(jsonData,error) -> Void in

            if let songlist = jsonData{
                let songModels = self.convertJsonToModel(jsonData: songlist, m4aName: "url")
                completehandle(songModels , error)
                print("歌单请求成功")
//                print(songModels!)
            }else
            {
                completehandle(nil , error)
                print(error!)
                print("歌单请求失败")
            }
        
        })
        
    }
    
    
    
    //MARK: -   把json数组转换为模型数组
    func convertJsonToModel(jsonData:[JSON]! , m4aName:String!) -> [Songs]? {
        
        var songs = [Songs]()
        
        for data in jsonData {
            let albumpic_big    =   data["albumpic_big"].string
            let albumpic_small  =   data["albumpic_small"].string
            let downUrl         =   data["downUrl"].string
            let m4a             =   data[m4aName].string
            let songname        =   data["songname"].string
            let songid          =   data["songid"].int
            let singername      =   data["singername"].string
            
            if let song = songid {
                if
                    albumpic_big    != nil &&
                    albumpic_small  != nil &&
                    downUrl         != nil &&
                    m4a             != nil &&
                    songname        != nil &&
                    singername      != nil &&
                    song > 0
                    
                    
                {
                    let songModel = Songs(albumpic_big      :   albumpic_big! ,
                                          albumpic_small    :   albumpic_small! ,
                                          downUrl           :   downUrl! ,
                                          m4a               :   m4a! ,
                                          songname          :   songname! ,
                                          song_id           :   songid!,
                                          singername        :   singername!)
                    
                    songs.append(songModel)
                    
                }

            }
            
//            
            
        }
        return songs
        
    }

    
}
