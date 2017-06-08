//
//  downloadMusicTableViewController.swift
//  Music player Ljm
//
//  Created by ljm on 2017/5/27.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit

private let identifier  =       "mycell"
private let path        =       NSHomeDirectory() + "/Documents/Music/"

class downloadMusicTableViewController: UIViewController , UITableViewDelegate , UITableViewDataSource
{

    
    var dataArray       =       [String]()
    var myTableview : UITableView?
    
    /*
     *
     *   下拉刷新控件
     *
     */
    var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        view.backgroundColor    =   .clear

    }
    
    func setupUI()  {
        myTableview = UITableView(frame: CGRect(x: 0,
                                                y: 0,
                                                width: screenWidth,
                                                height: screenHeight - 64),
                                  style: .plain)
        myTableview?.delegate = self
        myTableview?.dataSource = self
        myTableview?.separatorColor = .clear
        myTableview?.backgroundColor = .clear
        myTableview?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
        view.addSubview(myTableview!)
        
        /*
         *
         *   添加刷新
         *
         */
        refreshControl.addTarget(self, action: #selector(downloadMusicTableViewController.refreshData), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据喽")
        myTableview?.addSubview(refreshControl)
        refreshData()
    }
    
    
    /*
     *
     *   刷新数据
     *
     */
    func refreshData() {
         /* 移除老数据 */
//        self.dataArray.removeAll()
        
        self.myTableview?.reloadData()
        self.refreshControl.endRefreshing()
    
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        dataArray       =       []
        let fileManager =       FileManager.default
        let enumeator:FileManager.DirectoryEnumerator! = fileManager.enumerator(atPath: path)
        
        /* 遍历目录 */
        while let element       =   enumeator?.nextObject() as? String {
            dataArray.append("\(element)")
        }
        myTableview?.reloadData()
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int
    {

        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return self.dataArray.count
    }


     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        cell.textLabel?.text    =   dataArray[indexPath.row]
        cell.accessoryType      =   .checkmark
        cell.backgroundColor = .clear
        return cell
    }

    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        myTableview?.deselectRow(at: indexPath, animated: true)
    }
    
    
    
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
