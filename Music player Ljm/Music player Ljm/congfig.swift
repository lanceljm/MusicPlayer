//
//  congfig.swift
//  Music player Ljm
//
//  Created by ljm on 2017/5/26.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit
import Foundation

//MARK: -   事件回调
typealias btnClicked        =   (UIAlertAction!) -> Void

//MARK: -   自定义“预处理”
/* 屏幕大小 */
let screenBounds :  CGRect  =   UIScreen.main.bounds

/* 屏幕宽、高 */
let screenWidth  :  CGFloat =   UIScreen.main.bounds.width

let screenHeight :  CGFloat =   UIScreen.main.bounds.height

/* 最小值 */
let screenMinX   :  CGFloat =   UIScreen.main.bounds.minX
let screenMinY   :  CGFloat =   UIScreen.main.bounds.minY

/* 中点 */
let screenMidX   :  CGFloat =   UIScreen.main.bounds.midX
let screenMidY   :  CGFloat =   UIScreen.main.bounds.midY

/* 最大值 */
let screenMaxX   :  CGFloat =   UIScreen.main.bounds.maxX
let screenMaxY   :  CGFloat =   UIScreen.main.bounds.maxY


//MARK: -  文件路径
var documentsPath           =   NSSearchPathForDirectoriesInDomains(
    
                                                FileManager.SearchPathDirectory.documentDirectory,
                                                FileManager.SearchPathDomainMask.userDomainMask,
                                                true
    ).last;

let musicFolderPath         =   "\(documentsPath!)/\("Music")"
var tempPath                =   NSTemporaryDirectory()




//MARK: -   自定义播放列表中的控件
class congfig {
    struct Notification {
        static let updatePlayingView    =   "updatePlayingView"
        
    }
    
    //MARK: -   make Button
    class func makeButton (
                            _ frame         :   CGRect!         ,
                            _ color         :   UIColor?        ,
                            _ cornerRadius  :   CGFloat? = 0    ,
                            _ imageName     :   String?
        )
        -> UIButton
    
        {
            
                    let btn      = UIButton(frame: frame)
                    btn.backgroundColor     =   color
                    
                    if let image = imageName {
                        btn.setImage(UIImage(named:image), for: .normal)
        }
        
        return btn
    }
    
    
    //MARK: -   make Label
    class func makeLabe (
                        _ frame         :   CGRect!     ,
                        _ textColor     :   UIColor?    ,
                        _ color         :   UIColor?    ,
                        _ textSize      :   CGFloat?
        )
        -> UILabel
        
    {
        
            let lab         =   UILabel(frame: frame)
            
            if let size     =   textSize    {
                lab.font                =       UIFont.systemFont(ofSize: size)
            }
            
            if let color    =   textColor   {
                lab.textColor           =       color
            }
            
            if let bgColor  =   color       {
                lab.backgroundColor     =       bgColor
            }
     
             return lab
            
    }
    
    
    //MARK: -   showAlertVC
    class func showAlertVC (
                            _ control   :   UIViewController!   ,
                            _ title     :   String?             ,
                            _  message  :   String?)
    {
        let alertVC         =   UIAlertController(
                                                    title: title,
                                                    message: message,
                                                    preferredStyle: .alert
                                                )
        
        control.present(alertVC, animated: true, completion: nil)
        
        /* 延迟执行 */
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(3))
        {
            
            print("dismiss alertVC")
            /* 提示框消失 */
            alertVC.dismiss(animated: true, completion: nil)
        }
        
    }
    
}


//MARK: -   返回系统时间
public var currentTime      :    String
{
    get
    {
        let dataFormatter           =       DateFormatter()
        
        dataFormatter.dateFormat    =       "yyyyMMddHHmmss"
        
        return dataFormatter.string(from: Date())
        
    }
}
