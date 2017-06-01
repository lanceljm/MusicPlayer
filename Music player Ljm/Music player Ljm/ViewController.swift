//
//  ViewController.swift
//  Music player Ljm
//
//  Created by ljm on 2017/5/26.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit
import Kingfisher
import AFSoundManager
import Masonry

class ViewController: UIViewController {

    
    static  let shared  = ViewController()
    
    /* 歌曲名 */
    private var songName    :   UILabel?
    
    
    /* 专辑图片 */
    private var albumpic    :   UIImageView?
    
    
    /* 进度条 */
    private var slider      :   UISlider?
    
    
    /* 总时间 */
    private var allTime     :   UILabel?
    
    
    /* 当前时间 */
    private var currentTimes :   UILabel?
    
    
    /* 下一首 */
    private var nextBtn     :   UIButton?
    
    
    /* 上一首 */
    private var upBtn       :   UIButton?
    
    
    /* 播放 */
    private var playBtn     :   UIButton?
    
    
    /* 下载 */
    private var downBtn     :   UIButton?
    
    
    /* 列表 */
    private var listBtn     :   UIButton?
    
    
    
    /* 喜爱 */
    private var likeBtn     :   UIButton?
    
    
    
    /* 分享 */
    private var shareBtn    :   UIButton?
    
    
    
    /* 评论 */
    private var commentBtn  :   UIButton?
    
    
    
    /* 播放模式 */
    private var playModelBtn:   UIButton?
    

    /* 播放模式 */
    private var playModel   :   playModels?
    
    
    /* 播放、暂停 */
    private var playing     :   Bool            = false
    
    
    /* 播放模式下标 */
    public var playIndex   :   Int?
    
    
    /* 播放队列 */
    public var songsQueue  :   playingMusic?
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        songsQueue = playingMusic.sharePlayingServiece
        
        playing = true
        
        playModel = playModels.ListSongCircle
        
        songsQueue?.addObserver(self, forKeyPath: "songPlayedTime", options: .new, context: nil)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:congfig.Notification.updatePlayingView), object: nil, queue: nil, using: {
            (notification) -> Void in
            
            DispatchQueue.main.async {
                self.changeUI()
            }
        })
    }
    
    //MARK: -   视图即将出现时隐藏状态栏
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: -   视图即将消失时让状态栏出现
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    
    
    //MARK: -   设计UI
    func setupUI() {
        
        /*
         *
         *  歌曲名
         *
         */

        songName = congfig.makeLabe(CGRect(x:0 ,
                                           y:0 ,
                                           width:screenWidth ,
                                           height:40),
                                    #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                                    #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,
                                    18)
        
        songName?.center = CGPoint(
            x: screenWidth * 0.5,
            y: /*(self.navigationController?.navigationBar.frame.height)!*/ 64 + 40)
        songName?.textAlignment = .center
        view.addSubview(songName!)
        
        
        /*
         *
         *  图片
         *
         */

        albumpic = UIImageView(frame: CGRect(x: 0,
                                             y: 0,
                                             width: screenWidth * 0.5,
                                             height: screenWidth * 0.5))
        albumpic?.center = CGPoint(x: screenWidth * 0.5,
                                   y: (self.songName?.frame.origin.y)! + (self.songName?.frame.height)! + screenWidth * 0.4)
        albumpic?.image = UIImage(named:"playIcon")
        albumpic?.layer.cornerRadius = (self.albumpic?.frame.width)! * 0.5
        view.addSubview(albumpic!)
        
        
        /*
         *
         *  进度条
         *
         */

        slider = UISlider(frame: CGRect(x: 0,
                                        y: 0,
                                        width: screenWidth - /*(self.allTime?.frame.width)!*/ 60 - /*(self.currentTimes?.frame.width)!*/ 60,
                                        height: 20))
        
        slider?.center = CGPoint(x: screenWidth * 0.5,
                                 y: self.view.frame.height * 0.5 + (self.albumpic?.frame.height)!)
//        slider?.backgroundColor = .red
        slider?.value = 0
        slider?.maximumValue = 100
        slider?.setThumbImage(UIImage(named:"slider"), for: UIControlState.normal)
        
        /* 开始 */
        slider?.addTarget(
            self, action: #selector(beginChange(_:)), for: .touchDown)
        
        /* 结尾 */
        slider?.addTarget(
            self, action: #selector(endChange(_:)), for: .touchUpInside)
        
        /* 改变 */
        slider?.addTarget(
            self, action: #selector(timeChange(_:)), for: .valueChanged)
        view.addSubview(slider!)
        
        
        /*
         *
         *  播放时间
         *
         */

        currentTimes = congfig.makeLabe(CGRect(x : 0 ,
                                               y : (self.slider?.frame.origin.y)!,
                                               width : 60 ,
                                               height : 20),
                                        #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                                        #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                        12)
        currentTimes?.textAlignment = .right
        currentTimes?.text = "00:00"
        view.addSubview(currentTimes!)
        
        /*
         *
         *  歌曲总时间
         *
         */

        allTime = congfig.makeLabe(CGRect(
                                        x : (self.slider?.frame.width)! + (self.currentTimes?.frame.width)! ,
                                        y : (self.currentTimes?.frame.origin.y)! ,
                                        width: (self.currentTimes?.frame.width)! ,
                                        height : (self.currentTimes?.frame.height)!),
                                   self.currentTimes?.textColor,
                                   self.currentTimes?.backgroundColor,
                                   12)
        allTime?.textAlignment = .left
        allTime?.text = "00:00"
        view.addSubview(allTime!)
        
        
        /*
         *
         *  播放、暂停
         *
         */

        playBtn = congfig.makeButton(CGRect(x : 0 ,
                                            y : 0 ,
                                            width : 60 ,
                                            height : 60),
                                     #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                     30,
                                     "stop")
        playBtn?.center = CGPoint(x: screenWidth * 0.5,
                                  y: (self.slider?.center.y)! + 40)
        playBtn?.addTarget(self, action: #selector(playWithMethon(btn:)), for: .touchUpInside)
        view.addSubview(playBtn!)
        
        
        /*
         *
         *  上一首
         *
         */

        upBtn = congfig.makeButton(CGRect(x : 0 ,
                                          y : 0 ,
                                          width : 40 ,
                                          height : 40),
                                   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                   25,
                                   "up")
        upBtn?.center = CGPoint(x: (self.playBtn?.frame.origin.x)! - (self.playBtn?.frame.width)! * 0.5,
                                y: (self.playBtn?.center.y)!)
        upBtn?.tag = 101
        upBtn?.addTarget(self, action: #selector(nextorupWithMusic(btn:)), for: .touchUpInside)
        view.addSubview(upBtn!)
        
        /*
         *
         *  下一首
         *
         */

        nextBtn = congfig.makeButton(CGRect(x : 0 ,
                                            y : 0 ,
                                            width : (self.upBtn?.frame.width)! ,
                                            height : (self.upBtn?.frame.height)!),
                                     #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                     25,
                                     "next")
        nextBtn?.center = CGPoint(x: (self.playBtn?.frame.origin.x)! + (self.playBtn?.frame.width)! * 1.5, y: (self.playBtn?.center.y)!)
        nextBtn?.addTarget(self, action: #selector(nextorupWithMusic(btn:)), for: .touchUpInside)
        nextBtn?.tag = 100
        view.addSubview(nextBtn!)
        
        
        /*
         *
         *  播放模式
         *
         */
        playModelBtn = congfig.makeButton(CGRect(x : 0 ,
                                                 y : 0 ,
                                                 width : 30 ,
                                                 height : 30),
                                          #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
                                          0,
                                          "one")
        playModelBtn?.center = CGPoint(x: (self.upBtn?.frame.origin.x)! - (self.upBtn?.frame.width)!,
                                       y: (self.upBtn?.center.y)!)
        playModelBtn?.addTarget(self, action: #selector(changPlayWithModel(btn:)), for: .touchUpInside)
        view.addSubview(playModelBtn!)
        
        
        /*
         *
         *  播放列表
         *
         */
        listBtn = congfig.makeButton(CGRect(x : 0 ,
                                            y : 0 ,
                                            width : (self.playModelBtn?.frame.width)! ,
                                            height : (self.playModelBtn?.frame.height)!),
                                     #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
                                     0,
                                     "list")
        listBtn?.center = CGPoint(x: (self.nextBtn?.frame.origin.x)! + (self.nextBtn?.frame.width)! * 2,
                                  y: (self.nextBtn?.center.y)!)
        view.addSubview(listBtn!)

        
        
        /*
         *
         *  喜爱
         *
         */
        likeBtn = congfig.makeButton(CGRect(x : 0 ,
                                            y : 0 ,
                                            width : 30,
                                            height : 28),
                                     #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
                                     0,
                                     "like")
        likeBtn?.center = CGPoint(x: screenWidth / 5,
                                  y: (self.playBtn?.frame.origin.y)! + (self.playBtn?.frame.height)! * 1.5)
        likeBtn?.addTarget(self, action: #selector(likeChangeImage(sender:)), for: .touchUpInside)
        view.addSubview(likeBtn!)

        
        
        /*
         *
         *  下载
         *
         */
        downBtn = congfig.makeButton(CGRect(x : 0 ,
                                            y : 0 ,
                                            width : (self.likeBtn?.frame.width)! ,
                                            height : (self.likeBtn?.frame.height)!),
                                     #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1),
                                     0,
                                     "downmoad")
        downBtn?.center = CGPoint(x: screenWidth / 5 * 2, y: (self.likeBtn?.center.y)!)
        view.addSubview(downBtn!)
        
        
        
        /*
         *
         *  分享
         *
         */
        shareBtn = congfig.makeButton(CGRect(x : 0 ,
                                             y : 0 ,
                                             width : (self.likeBtn?.frame.width)!,
                                             height : (self.likeBtn?.frame.height)!),
                                      #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),
                                      0,
                                      "share")
        shareBtn?.center = CGPoint(x: screenWidth / 5 * 3, y: (self.likeBtn?.center.y)!)
        view.addSubview(shareBtn!)

        
        
        /*
         *
         *  评论
         *
         */
        commentBtn = congfig.makeButton(CGRect(x : 0 ,
                                               y : 0 ,
                                               width : (self.likeBtn?.frame.width)! ,
                                               height : (self.likeBtn?.frame.height)!),
                                        #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),
                                        0,
                                        "comment")
        commentBtn?.center = CGPoint(x: screenWidth / 5 * 4, y: (self.likeBtn?.center.y)!)

        view.addSubview(commentBtn!)
        
    }
    
    
    
    //MARK: -   改变UI
    func changeUI() {
        albumpic?.kf.setImage(with: URL(string:(songsQueue?.songAlbue)!))
        self.songName?.text = songsQueue?.songName
        self.allTime?.text = songsQueue?.songRemoinderFormatterTime
        self.slider?.maximumValue = Float((self.songsQueue?.soundQueue?.getCurrentItem().duration)!)
        self.playing = true
        self.playBtn?.setImage(UIImage(named:"stop"), for: .normal)
    }
    
    
    //MARK: -   点击进度条相应的方法
    func beginChange( _ slider:UISlider) {
        songsQueue?.soundQueue?.pause()
        
        playBtn?.setImage(UIImage(named:"paly"), for: .normal)
    }
    
    func endChange( _ slider:UISlider) {
        songsQueue?.seekToCurrentSlider(Int(slider.value))
        playBtn?.setImage(UIImage(named:"stop"), for: .normal)
    }
    
    func timeChange( _ slider:UISlider) {
        self.currentTimes?.text = makeTime(Int(slider.value))
    }
    
    
    //MARK: -   播放
    func playWithMethon(btn:UIButton) {
        if playing
        {
            songsQueue?.soundQueue?.pause()
            playing = false
            playBtn?.setImage(UIImage(named:"paly"), for: .normal)
            
        }else
        {
            songsQueue?.soundQueue?.playCurrentItem()
            playing = true
            playBtn?.setImage(UIImage(named:"stop"), for: .normal)
        }
    }
    
    //MARK: -   处理时间
    func makeTime( _ time:Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        
        return formatter.string(from: date)
    }
    
    //MARK: -   下一首、上一首
    func nextorupWithMusic(btn:UIButton) {
        print(btn.tag)
        switch btn.tag {
        case 100:
            /* 下一首 */
            songsQueue?.playWithNext()
            break
        case 101:
            /* 上一首 */
            songsQueue?.playWithUP()
            break
            
        default:
            break
        }
    }
    
    
    //MARK: -   切换播放模式
    func changPlayWithModel(btn:UIButton) {
        switch (playModel?.rawValue)! {
        case 0:
            /* 列表循环 */
            playModel = playModels.ListSongCircle
            playModelBtn?.setImage(UIImage(named:"circle"), for: .normal)
            break
            
        case 1:
            /* 随机播放 */
            playModel = playModels.RandomlySong
            playModelBtn?.setImage(UIImage(named:"arc"), for: .normal)
            break
        default:
            /* 单曲循环 */
            playModel = playModels.SingleSongCircle
            playModelBtn?.setImage(UIImage(named:"one"), for: .normal)
            break
        }
        songsQueue?.playModel = playModel
    }
    
    
    //MARK: -   监听处理当前时间和进度条
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        self.currentTimes?.text = songsQueue?.songPlayedFormatterTime
        self.slider?.value = (songsQueue?.songPlayedTime)!
    }
    
    
    //MARK: -   下载
    func downLoadWithMusic(btn:UIButton) {
        let downloadWithMethon = downloadMusic.shared
        downloadWithMethon.downQueue.removeAll()
        downloadWithMethon.downQueue.append((self.songsQueue?.playingSong)!)
        
        downloadWithMethon.startDownAtIndex(0)
    }
    
    
    //MARK: -   动画
    func roundImageView( _ timer:Timer) {
        let animal = CABasicAnimation(keyPath: "transform.rotation")
        
        animal.toValue = 2 * M_PI
        animal.repeatCount = MAXFLOAT
        animal.duration = 10
        animal.isRemovedOnCompletion = false
        
        /* 把动画添加到图层上 */
        albumpic?.layer.add(animal, forKey: nil)
        
    }
    
    //MARK: -   喜爱
    func likeChangeImage(sender:UIButton) {
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

