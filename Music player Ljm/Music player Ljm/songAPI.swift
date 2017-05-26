//
//  songAPI.swift
//  Music player Ljm
//
//  Created by ljm on 2017/5/26.
//  Copyright © 2017年 ljm. All rights reserved.
//

import Foundation


//MARK: -   易源QQ音乐接口
/* URL */
/* 根据歌名、人名搜索歌曲接口 */
public  let searchSongAPI   =   "https://route.showapi.com/213-1"

/* 歌单接口 */
public  let topListSongAPI  =   "http://route.showapi.com/213-4"

/* 歌词接口 */
public  let lyricBySongAPI  =   "http://route.showapi.com/213-2"




//MARK: -   系统级参数
/* 参数 */
public  let showapi_appid   =   "28796"
public  let showapi_sign    =   "1551b6e4ba9a470799e8e6f042c86d4a"




//MARK: -   应用级参数
/* 排行榜id */
public  let topid           =   "5"             //排行榜类型，示例值
/*
 *
 *
 榜行榜id
 3   =   欧美
 4   =   流行榜
 5   =   内地
 6   =   港台
 16  =   韩国
 17  =   日本
 26  =   热歌
 27  =   新歌
 28  =   网络歌曲
 32  =   音乐人
 36  =   K歌金曲
 *
 */




/* 歌曲id */
/*
 *
 *  歌曲id不正确，那么没有响应的歌词
 *
 */

public  let songid          =   "4833285"       //海阔天空，示例值



/* 搜索id */
public  let keyword         =   "海阔天空"      //人名或歌名，示例值
public  let page            =   "1"           //页数,每页最多只返回20条记录，示例值



