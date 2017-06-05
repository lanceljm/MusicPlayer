//
//  playingMusic.swift
//  Music player Ljm
//
//  Created by ljm on 2017/5/27.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit
import AFSoundManager

class playingMusic: NSObject {

    /* 单例 */
    static let sharePlayingServiece = playingMusic()
    
    
    /* 重载实例方法 */
    private override init() {}
    
    
    /* 歌曲列表 */
    var songList        =       [Songs]()
    
   
    
    /* 当前播放索引 */
    var playIndex:Int   =       0
    
    
    
    /* 当前播放模型 */
    var playingSong     =       Songs(albumpic_big:nil , albumpic_small:nil , downUrl:nil , m4a:nil , songname:nil , song_id:nil , singername: nil)
    
    
    
    /* 播放列表 */
    var soundQueue      =       AFSoundQueue(items: [])
    
    
    
    
    /* 歌曲名 */
    var songName                    :       String!
    
    
    
    /* 歌手名 */
    var singerName                  :       String!
    
    
    
    
    /* 专辑小封面 */
    var songAlbue                   :       String!
    
    
    /* 下载链接 */
    var downUrl                     :       String!
    
    
    /* 歌曲时间 */
    var songDuration                :       String!
    
    
    
    /* 格式化歌曲播放时间 */
    var songPlayedFormatterTime     :       String!
    
    
    
    /* 格式化歌曲剩余时间 */
    var songRemoinderFormatterTime  :       String!
    
    
    
    /* 歌曲播放时间 */
    dynamic var songPlayedTime  =       Float()
    
    
    
    /* 播放模式 */
    var playModel:playModels!   =       playModels.ListSongCircle//列表循环
    
    

     /* 背景图片 */
    var backGroundImage             :       String!
    
    
    
    /* 根据歌曲索引播放 */
    func playMusicWitnIndex( _ index:Int) {
        /* 后台线程 */
        DispatchQueue.global().async {
            self.playIndex      =       index
            let item            =       self.getSoundItem(index)
            
            /* 清除队列 */
            self.soundQueue?.clear()
            
            
            /* 添加到队列中 */
            self.soundQueue?.add(item)
            self.soundQueue?.playItem(at: 0)
            
            /*
             *
             *  处理播放剩余时间的函数
             *
             */
            self.songRemoinderFormatterTime     =   self.makeTime((self.soundQueue?.getCurrentItem().duration)!)
            
            DispatchQueue.main.async {
                
                /* 播放当前歌曲的回调 */
                self.listenCurrentMusicCallBack(self.soundQueue!)
                
                NotificationCenter.default.post(name:NSNotification.Name(
                        rawValue:congfig.Notification.updatePlayingView), object: nil, userInfo: nil)
            }
        }
    }
    
    
    
    //MARK: -   播放模式
    func playMusicModel() {
        
    }
    
    
    
    //MARK: -   根据歌曲索引获取歌曲对象
    func getSoundItem( _ songIndex:Int) -> AFSoundItem {
        /* 处理下标 */
        let currentIndex            =       getCurrentIndex(songIndex)
        playingSong                 =       songList[currentIndex]
        self    .   songName        =       playingSong.songname
        self    .   singerName      =       playingSong.singername
        self    .   songAlbue       =       playingSong.albumpic_small
        self    .   backGroundImage =       playingSong.albumpic_big
        let item                    =       AFSoundItem(streamingURL: URL(string: playingSong.m4a))
        self    .   songDuration    =       "\((item?.duration)!)"
        
        
        print("当前URL：\(playingSong.m4a)")
        
        
        /* 更新主线程*/
        return item!
        
    }
    
    
    
    //MARK: -   处理时间
    func makeTime( _ time:Int) -> String {
        let formatter           =   DateFormatter()
        /* 时间的格式 */
        formatter.dateFormat    =   "mm:ss"
        
        let date                =   Date(timeIntervalSince1970: TimeInterval(time))

        return formatter.string(from: date)
    }
    
    
    
    //MARK: -   处理下标
    func getCurrentIndex( _ fromIndex:Int) -> Int {
        
        let currentIndex:Int
        
        /* 当前处于列表的最后一首，跳转到第一首 */
        if fromIndex > (songList.count - 1)
        {
            currentIndex = 0
        }
            /* 当前处于第一首，下一首跳转到列表的最后一首 */
        else if fromIndex < 0
        {
            currentIndex  = songList.count - 1
        }
        else
        {
            currentIndex = fromIndex
        }
        
        return currentIndex
        
    }
    
    
    
    //MARK: -   监听当前歌曲的播放状态
    func listenCurrentMusicCallBack( _ currentQueue:AFSoundQueue) {
        
        currentQueue.listenFeedbackUpdates({ (item) in
            
            
            /* 歌曲播放时间 */
            self.songPlayedTime = Float((item?.timePlayed)!)
            self.songPlayedFormatterTime = self.makeTime((item?.timePlayed)!)
            
            if item?.timePlayed == item?.duration
            {
                print("下一首")
                
                self.playWithNext()
                
                
                ////////////////////////////////////////////////////////////////
                
                
            }
            
            
        }, andFinishedBlock: {(item) in
            
            
        })
        
    }
    

    
    //MARK: -  上一首
    func playWithUP() {
        
        
        switch playModel! {
            /* 列表循环 */
        case playModels.ListSongCircle:
            playModel = playModels.ListSongCircle
            playMusicWitnIndex(playIndex - 1)
            print("^")
            break
            
            /* 随机播放 */
        case playModels.RandomlySong:
            playModel = playModels.RandomlySong
            playMusicWitnIndex(Int(arc4random()) % (songList.count - 1))
            print("v")
            break
            
            /* 单曲循环 */
        case playModels.SingleSongCircle:
            playModel = playModels.SingleSongCircle
            playMusicWitnIndex(playIndex)
       
        }
        
    }
    
    
    
    //MARK: -   下一首
    func playWithNext() {
        
        switch playModel! {
            /* 列表循环 */
        case playModels.ListSongCircle:
            playModel = playModels.ListSongCircle
            playMusicWitnIndex(playIndex + 1)
            print("^")
            break
            
            /* 随机播放 */
        case playModels.RandomlySong:
            playModel = playModels.RandomlySong
            playMusicWitnIndex(Int(arc4random()) % (songList.count - 1))
            print("v")
            break
            
            /* 单曲循环 */
        case playModels.SingleSongCircle:
            playModel = playModels.SingleSongCircle
            playMusicWitnIndex(playIndex)
            
        }
        
    }
    
    
    //MARK: -   快进快退
    func seekToCurrentSlider( _ second:Int) {
        soundQueue?.playItem(at: second)
        soundQueue?.playCurrentItem()
        
        
        //////////////////////////////////////////////////////////////////
        
        
        listenCurrentMusicCallBack(soundQueue!)
    }
    
    
    
    
    
    
    
}
