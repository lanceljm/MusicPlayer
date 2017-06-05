//
//  musicListCell.swift
//  Music player Ljm
//
//  Created by ljm on 2017/5/27.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit
import Masonry
import SnapKit

class musicListCell: UITableViewCell {
    
    
    public var musicImage   :   UIImageView?
    public var musicName    :   UILabel?
    public var musicAuthor  :   UILabel?
    
    /* 背景图片 */
    public  var backgroundImage :   UIImageView?

    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupCell()
    {
        
//        musicImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        musicImage?.center = CGPoint(x: 30, y: 25)
//        contentView.addSubview(musicImage!)
////        
//        musicName = UILabel(frame: CGRect(x: 60, y: 0, width: screenWidth - 70, height: 50))
//        musicName?.font = UIFont.systemFont(ofSize: 16)
//        musicName?.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
//        musicName?.textAlignment = .left
//        contentView.addSubview(musicName!)
//        
        /* 图片 */
        musicImage = UIImageView()
//        musicImage?.center = CGPoint(x: 30, y: 25)

        addSubview(musicImage!)
        
//        let superview = self
        let padding = 5
    
        
        musicImage?.snp.makeConstraints({ (make:ConstraintMaker!) in
            make.top.equalTo(padding)
            make.left.equalTo(2 * padding)
            make.bottom.equalTo(-padding)
//            make.centerY.equalTo(superview.center.y)
//            make.width.equalTo(Int(superview.frame.height) - padding)
            make.width.equalTo((musicImage?.snp.height)!)
        })
        
//        _ = musicImage?.mas_makeConstraints({ (make : MASConstraintMaker!) in
//            make?.top.equalTo()(superview)?.setOffset(CGFloat(padding))
//            make?.left.equalTo()(superview)?.setOffset(CGFloat(padding))
////          make?.right.equalTo()(superview)?.setOffset(-(CGFloat)(padding))
//            make?.bottom.equalTo()(superview)?.setOffset((CGFloat)(-padding))
//            make.width.and().height()
//        })
        
        musicImage?.layer.cornerRadius = CGFloat(padding)
        musicImage?.layer.masksToBounds = true
        
        
        /* 歌名 */
        musicName = UILabel()
//        musicName = UILabel(frame: CGRect(x: 60, y: 0, width: screenWidth - 70, height: 50))
        musicName?.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        musicName?.textAlignment = .left
        musicName?.font = UIFont.systemFont(ofSize: 14)
        addSubview(musicName!)

//        
//
        
        musicName?.snp.makeConstraints({ (make:ConstraintMaker!) in
            make.top.equalTo((musicImage?.snp.top)!).offset(padding * 2)
            make.left.equalTo((musicImage?.snp.right)!).offset(padding * 3)
            make.right.equalTo((musicImage?.frame.size.width)!)
            make.height.equalTo(padding * 2)
        })
        
//        _ = musicName?.mas_makeConstraints({ (make:MASConstraintMaker?) in
//            make?.top.equalTo()(self.musicImage?.mas_top)
//            make?.left.equalTo()(self.musicImage?.mas_right)?.setOffset(CGFloat(20))
//            make?.width.equalTo()(CGFloat(superview.frame.width * 0.5))
//            make?.height.equalTo()(CGFloat(superview.frame.height / 3))
//        })
        
        
        
        /* 作者名 */
        musicAuthor = UILabel()
        musicAuthor?.textColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        musicAuthor?.textAlignment = .left
        musicAuthor?.font = UIFont.systemFont(ofSize: 10)
        addSubview(musicAuthor!)

        
        musicAuthor?.snp.makeConstraints({ (make:ConstraintMaker!) in
            make.top.equalTo((musicName?.snp.bottom)!).offset(padding * 2)
            make.left.equalTo((musicName?.snp.left)!)
            make.right.equalTo((musicImage?.frame.size.width)!)
//            make.height.equalTo(padding * 2)
            make.bottom.equalTo(self.snp.bottom).offset(-padding * 2)
        })
        
//        _ = musicAuthor?.mas_makeConstraints({ (make:MASConstraintMaker?) in
//            make?.top.equalTo()(self.musicName?.mas_bottom)?.setOffset(CGFloat(padding))
//            make?.left.equalTo()(self.musicName?.mas_left)
//            make?.left.equalTo()(self.musicName?.mas_width)
//            make?.height.equalTo()(CGFloat(superview.frame.height * 0.2))
//        })
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
