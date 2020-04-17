//
//  SettingCell.swift
//  YouTube -app
//
//  Created by 酒井ゆうき on 2020/04/17.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class SettingCell : UICollectionViewCell {
    
    var setting : Setting? {
        didSet {
            configure()
        }
    }
    
    let iconImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.setDimension(width: 30, height: 30)
        iv.image = #imageLiteral(resourceName: "settings")
        
        return iv
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Settin"
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .lightGray : .white
            
            nameLabel.textColor = isHighlighted ? .white : .black
            
            iconImageView.tintColor = isHighlighted ? .white : .darkGray
            
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconImageView)
        iconImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 8)
        
        
        addSubview(nameLabel)
        nameLabel.centerY(inView: iconImageView)
        nameLabel.anchor(left : iconImageView.rightAnchor,paddingLeft: 8)
        
        
    }
    
    private func configure() {
        guard let setting = setting else {return}
        iconImageView.image = UIImage(named: setting.imageName.rawValue)?.withRenderingMode(.alwaysOriginal)
        nameLabel.text = setting.name.rawValue
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
