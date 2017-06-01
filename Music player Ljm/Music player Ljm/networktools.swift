//
//  networktools.swift
//  Music player Ljm
//
//  Created by ljm on 2017/5/27.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit
import AFNetworking

typealias callBackClocked = ( _ data:Any? , _ error : Error?) -> ()

//MARK: -   开始封装网络请求单例类
class networktools : AFHTTPSessionManager
{
 
    /* 初始化工具类属性 */
    static let shared : networktools = {
        let instance = networktools(baseURL:nil) //URL(string: baseURLString!))
        
        instance.responseSerializer.acceptableContentTypes?.insert("text/html")
        
        return instance
    }()
    
    
    /*
     *
     *  封装网络请求的方法
     *
     */

    func request(url:String,parameters:Any?,finished: @escaping callBackClocked) {
        //拼接地址
        let newURL = url
        
        //调用三方网络的方法请求数据
        get(newURL, parameters: parameters, progress: nil, success: { (_, data) in
        
            //使用闭包属性回调参数
            finished(data, nil)
        }) { (_, err) in
            //使用闭包属性回调错误
            finished(nil, err)
        }
        
    }

    
}

