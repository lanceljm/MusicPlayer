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


class musicListTableviewcontroller: UITableViewController
{

    
    var musicData = [Songs]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "歌单"
        player = AFSoundPlayback()
        
        /* 注册cell */
        tableView.register(musicListCell.classForCoder(), forCellReuseIdentifier: identifier)
        
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
                            self.tableView.reloadData()
                        }
                    }
                }
                
            })
        }
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let plays = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(goToPlayer))
        
        navigationItem.rightBarButtonItem = plays
        
    }
    
    
    //MARK: -   action  goToPlayer
    func goToPlayer() -> Void {
        let player = ViewController.shared
        player.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.pushViewController(player, animated: true)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return musicData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! musicListCell
        let songs = musicData[indexPath.row]
        cell.musicImage?.kf.setImage(with: URL(string: songs.albumpic_small))
        cell.musicName?.text = songs.songname
        cell.musicAuthor?.text = songs.singername
//        cell.backgroundImage?.kf.setImage(with: URL(string: songs.albumpic_big))
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        /* 播放 */
        let player = playingMusic.sharePlayingServiece
        if player.songName != musicData[indexPath.row].songname {
            player.songList = musicData
            player.playMusicWitnIndex(indexPath.row)
        }
        
        let plays = ViewController.shared
        plays.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        plays.playIndex = indexPath.row
        navigationController?.pushViewController(plays, animated: true)
        
        
    }
    
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
