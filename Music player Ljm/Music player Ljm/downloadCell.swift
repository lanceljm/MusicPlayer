//
//  downloadCell.swift
//  Music player Ljm
//
//  Created by ljm on 2017/5/27.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit
import SnapKit

class downloadCell: UITableViewCell
{

    
    public  var downImage       :   UIImageView?
    public  var downName        :   UILabel?
    public  var downProgress    :   UIProgressView?
    public  var downSuccess     :   UIImageView?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    
    func setupUI()
    {
        
        downImage = UIImageView(frame: CGRect(x: 10, y: 5, width: 40, height: 40))
        contentView.addSubview(downImage!)
        downName = UILabel(frame: CGRect(x: 60, y: 5, width: screenWidth - 80, height: 25))
        downName?.textColor = .red
        downName?.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(downName!)
        downProgress = UIProgressView(frame: CGRect(x: 60, y: 30, width: screenWidth - 120, height: 10))
        contentView.addSubview(downProgress!)
        
//        downImage = UIImageView()
//        addSubview(downImage!)
//        
//        downImage?.snp.makeConstraints({ (make:ConstraintMaker) in
//            make.top.equalTo(10)
//            make.left.equalTo(10)
//            make.width.height.equalTo(40)
//        })
//        
//        
//        
//        downName = UILabel()
//        downName?.textAlignment = .center
//        downName?.textColor = .red
//        downName?.font = UIFont.systemFont(ofSize: 15)
//        addSubview(downName!)
//        
//        downName?.snp.makeConstraints({ (make:ConstraintMaker) in
//            make.top.equalTo(self.downImage?.mas_top as! ConstraintRelatableTarget)
//            make.left.equalTo(self.downImage?.mas_right as! ConstraintRelatableTarget).offset(10)
//            make.width.equalTo(screenWidth - 80)
//            make.height.equalTo(25)
//        })
//        
//        
//        downProgress = UIProgressView()
//        downProgress?.backgroundColor = .green
//        addSubview(downProgress!)
//        
//        downProgress?.snp.makeConstraints({ (make:ConstraintMaker) in
//            make.top.equalTo(self.downName?.mas_bottom as! ConstraintRelatableTarget).offset(5)
//            make.left.equalTo(self.downName?.mas_left as! ConstraintRelatableTarget)
//            make.width.equalTo(screenWidth - 120)
//            make.height.equalTo(10)
//        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(corder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
