//
//  VideoCell.swift
//  You Tube -app
//
//  Created by 酒井ゆうき on 2020/04/15.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class VideoCell : UICollectionViewCell {
    
    //MARK: - Parts
    
    private let thumbnailImageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
       
        return iv
    }()
    
    private let profileImageView : UIImageView = {
         let iv = UIImageView()
         iv.backgroundColor = .green
         return iv
     }()
     
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Title label"
        return label
    }()
    
    private let subTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "Subtitle"
        return label
    }()
    
    
    
    private let separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(thumbnailImageView)

        thumbnailImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor,paddingLeft: 16, paddingRight: 16,width: self.frame.width, height: 135)
        
        addSubview(profileImageView)
        profileImageView.anchor(top : thumbnailImageView.bottomAnchor, left: leftAnchor,paddongTop: 8,paddingLeft: 16,paddiongBottom: 8, width: 43,height: 43 )
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stack.axis = . vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top : thumbnailImageView.bottomAnchor, left: profileImageView.rightAnchor, right:  rightAnchor , paddongTop: 8,paddingLeft: 16,paddingRight: 16)
        
        
        
        addSubview(separatorView)
        separatorView.anchor(left : leftAnchor, bottom: bottomAnchor, right: rightAnchor,paddingLeft: 16, paddingRight: 16, height: 0.75)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
