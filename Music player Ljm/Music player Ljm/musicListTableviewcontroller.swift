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
    UITableViewDelegate,UITableViewDataSource
//    UIPickerViewDelegate,UIPickerViewDataSource
{

    var myTableview:UITableView?
    
    var musicData = [Songs]()
    
    var myPickerView:UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear

        title = "歌单"
        player = AFSoundPlayback()
        
        self.setupUI()
        
        DispatchQueue.global().async {
            SongInfoController().getSongsModelWithTopID(topid: 26, completehandle: {
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
    }
    
    //MARK: -   设置导航条的文字
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let plays = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(goToPlayer))
        let plays = UIBarButtonItem(title: "播放", style: .plain, target: self, action: #selector(goToPlayer))
        plays.tag = 100
        let select = UIBarButtonItem(title: "热门", style: .plain, target: self, action: #selector(goToPlayer))
        select.tag = 101
        
        navigationItem.rightBarButtonItem = plays
        navigationItem.leftBarButtonItem = select
        
    }
    
    
    //MARK: -   action  goToPlayer
    func goToPlayer(sender:UIBarButtonItem) -> Void {
        if sender.tag == 100 {
            
            let player = ViewController.shared
            player.view.backgroundColor = .clear
            navigationController?.pushViewController(player, animated: true)
//            self.present(player, animated: true, completion: nil)
            
        }
        else if sender.tag == 101{
            let pickerVC = selectPickerview.shared
            self.present(pickerVC, animated: true, completion: nil)
            sender.tag += 1
        }else
        {
            dismiss(animated: true, completion: nil)
            sender.tag -= 1
        }
        
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
//        cell.accessoryType = .none
        
        cell.musicImage?.kf.setImage(with: URL(string: songs.albumpic_small))
        cell.musicName?.text = songs.songname
        cell.musicAuthor?.text = songs.singername
//        cell.backgroundImage?.kf.setImage(with: URL(string: songs.albumpic_big))
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
//        navigationController?.pushViewController(plays, animated: true)
        self.present(plays, animated: true, completion: nil)
        
        
    }
    
    

    
    
    

}
