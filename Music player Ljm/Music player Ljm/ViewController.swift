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

    
    static  let shared  = UIViewController()
    
    
    private var songName    :   UILabel?
    private var albumpic    :   UIImageView?
    private var slider      :   UISlider?
    private var allTime     :   UILabel?
    private var currentTime :   UILabel?
    private var nextBtn     :   UIButton?
    private var upBtn       :   UIButton?
    private var playBtn     :   UIButton?
    private var downBtn     :   UIButton?
    private var playModelBtn:   UIButton?
    private var playIndex   :   Int?

    private var playing     :   Bool            = false
    
//    private var songsQueue  :   
    
    private var playModel   :   playModels?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

