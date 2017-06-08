//
//  selectPickerview.swift
//  Music player Ljm
//
//  Created by ljm on 2017/6/7.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit

class selectPickerview: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource {

    static let shared = selectPickerview()
    
    var pickerView : UIPickerView!
    
    var titleDic = ["欧美":3,"流行榜":4,"内地":5,"港台":6,"韩国":16,"日本":17,"热歌":26,"新歌":27,"网络歌曲":28,"音乐人":32,"K歌金曲":36]
    
    var titleArr = ["欧美","流行榜","内地","港台","韩国","日本","热歌","新歌","网络歌曲","音乐人","K歌金曲"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupPickerView()
    }
    
    
    func setupPickerView() {
        pickerView = UIPickerView(frame: CGRect(x: 0,
                                                y: 64,
                                                width: screenWidth / 3,
                                                height: screenHeight / 4))
        pickerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pickerView.delegate = self
        pickerView.dataSource = self
        
        view.addSubview(pickerView)
    }

    
    //MARK: -   列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    //MARK: -   行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return titleDic.count
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
        
        if row == 1 {
            dismiss(animated: true, completion: nil)
        }
    }
}
