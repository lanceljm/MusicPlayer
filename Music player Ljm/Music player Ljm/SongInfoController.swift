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
        let url = "\(topListSongAPI)?topid=\(topid)&showapi_appid=\(showapi_appid)&showapi_sign=\(showapi_sign)"/*&showapi_timestamp=\(currentTime)*/
        
        networkingservice.getTopListMusicInfo(url, completeHondle: {(jsonData,error) -> Void in
        
            if let songlist = jsonData{
                let songModels = self.convertJsonToModel(jsonData: songlist, m4aName: "url")
                completehandle(songModels , error)
            }else
            {
                completehandle(nil , error)
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
            let m4a             =   data["m4a"].string
            let songname        =   data["songname"].string
            let song_id         =   data["song_id"].int
            let singername      =   data["singername"].string
            
            
            if albumpic_big     != nil &&
                albumpic_small  != nil &&
                downUrl         != nil &&
                m4a             != nil &&
                songname        != nil &&
                singername      != nil &&
                song_id! > 0
                {
                    let songModel = Songs(albumpic_big      :albumpic_big! ,
                                          albumpic_small    :albumpic_small! ,
                                          downUrl           : downUrl! ,
                                          m4a               : m4a! ,
                                          songname          : songname! ,
                                          song_id           : song_id!,
                                          singername        : singername!)
                    songs.append(songModel)
                    
            }
            
        }
        return songs
        
    }

    
}
