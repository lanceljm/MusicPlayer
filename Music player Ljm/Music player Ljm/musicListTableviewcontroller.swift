//
//  musicListTableviewcontroller.swift
//  Music player Ljm
//
//  Created by ljm on 2017/5/27.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit
import Kingfisher
import AFSoundManager


private let identifier = "cell"
public var player:AFSoundPlayback?


class musicListTableviewcontroller:
    UIViewController,
    UITableViewDelegate,UITableViewDataSource,
    UIPickerViewDelegate,UIPickerViewDataSource
{

    var myTableview:UITableView?
    
    var musicData = [Songs]()
    
    var myPickerView:UIPickerView!
    
    var selectBtn:UIBarButtonItem!
    
    /* 自定义下拉刷新 */
    var refreshcontrol = UIRefreshControl()
    
    
    
    var topID:Int!
    
    
    var titleArr = ["欧美","流行榜","内地","港台","韩国","日本","热歌","新歌","网络歌曲","音乐人","K歌金曲"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear

        title = "歌单"
        player = AFSoundPlayback()
        
        setupUI()
        setupPickerView()
        
    
            let topidStr = UserDefaults.standard.value(forKey: "titleStr") as! String?
            if topidStr == titleArr[0] {
                 /* 欧美 3 */
                topID = 3
            }else if topidStr == titleArr[1]
            {
                 /* 流行榜 4 */
                topID = 4
            }else if topidStr == titleArr[2]
            {
                 /* 内地 */
                topID = 5
            }else if topidStr == titleArr[3]
            {
                 /* 港台 */
                topID = 6
            }else if topidStr == titleArr[4]
            {
                 /* 韩国 */
                topID = 16
            }else if topidStr == titleArr[5]
            {
                 /* 日本 */
                topID = 17
            }else if topidStr == titleArr[6]
            {
                 /* 热歌 */
                topID = 26
            }else if topidStr == titleArr[7]
            {
                 /* 新歌 */
                topID = 27
            }else if topidStr == titleArr[8]
            {
                 /* 网络歌曲 */
                topID = 28
            }else if topidStr == titleArr[9]
            {
                 /* 音乐人 */
                topID = 32
            }else if topidStr == titleArr[10]
            {
                 /* K歌金曲 */
                topID = 36
            }
            
            if topidStr == nil {
                 /* 默认为 欧美 */
                topID = 3
            }
        
        DispatchQueue.global().async {
            SongInfoController().getSongsModelWithTopID(topid: self.topID, completehandle: {
                (songsModels , error) -> Void in
                
                if error != nil
                {
                    print("歌单请求成功")
                }else
                {
                    DispatchQueue.main.async {
                        if songsModels?.count == 0
                        {
                            congfig.showAlertVC(self, "提示", "歌单请求失败，请检查网络")
                        }else
                        {
                            self.musicData = songsModels!
                            self.refreshcontrol.endRefreshing()
                            self.myTableview?.reloadData()
                        }
                    }
                }
                
            })
        }

        
        
    }
    
    
    func setupUI() {
        myTableview = UITableView(frame: CGRect(x: 0,
                                                y: 0,
                                                width: screenWidth,
                                                height: screenHeight - 64),
                                  style: .plain)
        
        myTableview?.delegate = self
        myTableview?.dataSource = self
        
        myTableview?.separatorColor = .clear
        myTableview?.backgroundColor = .clear
        /* 注册cell */
        myTableview?.register(musicListCell.classForCoder(), forCellReuseIdentifier: identifier)
        view.addSubview(myTableview!)
        
        
        /*
         *
         *  添加下拉刷新
         *
         */
        refreshcontrol.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshcontrol.attributedTitle = NSAttributedString(string: "下拉刷新歌单")
        myTableview?.addSubview(refreshcontrol)
        refreshData()
    }
    
    //MARK: -   下拉刷新的方法
    func refreshData() {
        self.myTableview?.reloadData()
        self.refreshcontrol.endRefreshing()
    }
    
     //MARK:- 设置选择器
    func setupPickerView() {
        myPickerView = UIPickerView(frame: CGRect(x: 0,
                                                y: 64,
                                                width: screenWidth / 3,
                                                height: screenHeight / 4))
        myPickerView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        myPickerView.delegate = self
        myPickerView.dataSource = self
    }
    
    //MARK: -   设置导航条的文字
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        let plays = UIBarButtonItem(title: "播放", style: .plain, target: self, action: #selector(goToPlayer(sender:)))
        plays.tag = 100
        navigationItem.rightBarButtonItem = plays

         /* 根据ud里面的值判断当前位置歌曲 */
        if ((UserDefaults.standard.value(forKey: "titleStr") as! String?) == nil) {
            selectBtn = UIBarButtonItem(title: titleArr[0], style: .plain, target: self, action: #selector(goToPlayer(sender:)))
        }else{
            selectBtn = UIBarButtonItem(title: UserDefaults.standard.value(forKey: "titleStr") as! String?, style: .plain, target: self, action: #selector(goToPlayer(sender:)))
        }
        selectBtn.tag = 1000
        navigationItem.leftBarButtonItem = selectBtn
        
        
        
    }
    
    //MARK: -   action  goToPlayer
    func goToPlayer(sender:UIBarButtonItem) -> Void {
        if sender.tag == 100 {
            
            let player = ViewController.shared
            player.view.backgroundColor = .clear
            self.present(player, animated: true, completion: nil)
            
        }
        else if sender.tag == 1000{
            view.addSubview(myPickerView)
            sender.tag += 1
        }else
        {
            myPickerView.removeFromSuperview()
            sender.tag -= 1
        }
        
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (UIDevice.current.systemVersion as NSString).doubleValue < currentVersion {
            return 60
        }else
        {
            return 80
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! musicListCell
        let songs = musicData[indexPath.row]
        cell.backgroundColor = .clear
        cell.musicImage?.kf.setImage(with: URL(string: songs.albumpic_small))
        cell.musicName?.text = songs.songname
        cell.musicAuthor?.text = songs.singername
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        /* 播放 */
        let player = playingMusic.sharePlayingServiece
        if player.songName != musicData[indexPath.row].songname {
            player.songList = musicData
            player.playMusicWitnIndex(indexPath.row)
        }
        
        let plays = ViewController.shared
        plays.view.backgroundColor = .clear
        plays.playIndex = indexPath.row
        self.present(plays, animated: true, completion: nil)
        
        
    }
    
    

    //MARK: -   列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    //MARK: -   行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return titleArr.count
    }
    
    //MARK: -   设置文字内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //        return String(row) + "-"+String(component)
        return titleArr[row]
    }
    
    //MARK: -   设置行高
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    //MARK: -   选中状态的事件
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(titleArr[row])
        
         /* 使用ud保存当前位置 */
        UserDefaults.standard.set(titleArr[row], forKey: "titleStr")
        
        switch row {
        case 0:
            topID = 3
            break
        case 1:
            topID = 4
            break
        case 2:
            topID = 5
            break
        case 3:
            topID = 6
            break
        case 4:
            topID = 16
            break
        case 5:
            topID = 17
            break
        case 6:
            topID = 26
            break
        case 7:
            topID = 27
            break
        case 8:
            topID = 28
            break
        case 9:
            topID = 32
            break
        case 10:
            topID = 36
            break
        default:
            break
        }
        
        DispatchQueue.global().async {
            SongInfoController().getSongsModelWithTopID(topid: self.topID, completehandle: {
                (songsModels , error) -> Void in
                
                if error != nil
                {
                    print("歌单请求成功")
                }else
                {
                    DispatchQueue.main.async {
                        if songsModels?.count == 0
                        {
                            congfig.showAlertVC(self, "提示", "歌单请求失败，请检查网络")
                        }else
                        {
                            self.musicData = songsModels!
//                            self.myTableview?.reloadData()
                        }
                    }
                }
                
            })
        }

        
        selectBtn = UIBarButtonItem(title: titleArr[row], style: .plain, target: self, action: #selector(goToPlayer(sender:)))
        selectBtn.tag = 1000
        navigationItem.leftBarButtonItem = selectBtn
        myPickerView.removeFromSuperview()

        
    }
}
