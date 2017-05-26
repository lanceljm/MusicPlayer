//
//  SongModel.swift
//  Music player Ljm
//
//  Created by ljm on 2017/5/26.
//  Copyright © 2017年 ljm. All rights reserved.
//

import Foundation


public  struct  Songs
{
    let albumpic_big    :   String!
    let albumpic_small  :   String!
    let downUrl         :   String!
    let m4a             :   String!
    let songname        :   String!
    let song_id         :   Int!
    
}


enum    playModels  :   Int
{
    /* 单曲循环 */
    case    SingleSongCircle    =   0
    
    /* 列表循环 */
    case    ListSongCircle
    
    /* 随机播放 */
    case    RandomlySong
}



/*
 *
 *      "showapi_res_body"  : {
        "ret_code"          : 0,
        "pagebean"          : {
        "songlist"          : [
                        {
                            "songname": "嗯",
                            "seconds": 238,
                            "albummid": "003ATIGS0KgQEn",
                            "songid": 202360527,
                            "singerid": 60505,
                            "albumpic_big": "http://i.gtimg.cn/music/photo/mid_album_300/E/n/003ATIGS0KgQEn.jpg",
                            "albumpic_small": "http://i.gtimg.cn/music/photo/mid_album_90/E/n/003ATIGS0KgQEn.jpg",
                            "downUrl": "http://dl.stream.qqmusic.qq.com/202360527.mp3?vkey=45FE8C8EBB24A2792BD6372473BED8E9FBE4A887E38B5EB192E27D01BA68A4066E16F22432A553F125E55450E09154870087CE952C992D35&guid=2718671044",
                            "url": "http://ws.stream.qqmusic.qq.com/202360527.m4a?fromtag=46",
                            "singername": "李荣浩",
                            "albumid": 2064220
                        },
 *
 */
