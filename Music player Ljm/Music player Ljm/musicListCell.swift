//
//  musicListCell.swift
//  Music player Ljm
//
//  Created by ljm on 2017/5/27.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit
import Masonry

class musicListCell: UITableViewCell {
    
    
    public var musicImage   :   UIImageView?
    public var musicName    :   UILabel?
    public var musicAuthor  :   UILabel?

    
    
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
        /* 图片 */
        musicImage = UIImageView()
//        musicImage?.center = CGPoint(x: 30, y: 25)
        musicImage?.layer.cornerRadius = (self.musicImage?.frame.width)! * 0.5
        musicImage?.layer.masksToBounds = true
        addSubview(musicImage!)
        
        let superview = self
        let padding = 5
    

        _ = musicImage?.mas_makeConstraints({ (make : MASConstraintMaker!) in
            make?.top.equalTo()(superview)?.setOffset(CGFloat(padding))
            make?.left.equalTo()(superview)?.setOffset(CGFloat(padding))
//          make?.right.equalTo()(superview)?.setOffset(-(CGFloat)(padding))
            make?.bottom.equalTo()(superview)?.setOffset((CGFloat)(-padding))
            make.width.and().height()
        })
        
        
        
        
        /* 歌名 */
        musicName = UILabel()
//        musicName = UILabel(frame: CGRect(x: 60, y: 0, width: screenWidth - 70, height: 50))
        musicName?.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        musicName?.textAlignment = .left
        musicName?.font = UIFont.systemFont(ofSize: 16)
        addSubview(musicName!)
        
        _ = musicName?.mas_makeConstraints({ (make:MASConstraintMaker?) in
            make?.top.equalTo()(self.musicImage?.mas_top)
            make?.left.equalTo()(self.musicImage?.mas_right)?.setOffset(CGFloat(20))
            make?.width.equalTo()(CGFloat(superview.frame.width * 0.5))
            make?.height.equalTo()(CGFloat(superview.frame.height / 3))
        })
        
        
        
        /* 作者名 */
        musicAuthor = UILabel()
        musicAuthor?.textColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        musicAuthor?.textAlignment = .left
        musicAuthor?.font = UIFont.systemFont(ofSize: 12)
        addSubview(musicAuthor!)
        
        _ = musicAuthor?.mas_makeConstraints({ (make:MASConstraintMaker?) in
            make?.top.equalTo()(self.musicName?.mas_bottom)?.setOffset(CGFloat(padding))
            make?.left.equalTo()(self.musicName?.mas_left)
            make?.left.equalTo()(self.musicName?.mas_width)
            make?.height.equalTo()(CGFloat(superview.frame.height * 0.2))
        })
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
