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

    /*
     *
     *  搜索歌曲信息
     *
     */
    
    func getSongModelWithName(name:String , completeHandle:@escaping ConvertModelCompleteModel) -> Void {
        
        let url = "\(searchSongAPI)？keyword=\(name)&page=\(page)&showapi_appid=\(showapi_appid)&showapi_timestamp=\(currentTime)&showapi_sign=\(showapi_sign)"
        
        
        
    }

    
}
