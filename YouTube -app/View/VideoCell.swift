//
//  VideoCell.swift
//  You Tube -app
//
//  Created by 酒井ゆうき on 2020/04/15.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit



class VideoCell : UICollectionViewCell {
    
    var video : Video? {
        didSet {
            configure()
        }
    }
    
    //MARK: - Parts
    
    private let thumbnailImageView : CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .lightGray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let profileImageView : CustomImageView = {
         let iv = CustomImageView()
         iv.backgroundColor = .lightGray
        iv.setDimension(width: 43, height: 43)
        iv.clipsToBounds = true
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 43 / 2
         return iv
     }()
     
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Title label"
        label.numberOfLines = 2
        
        return label
    }()
    
    private let subTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "Subtitle"
        return label
    }()
    
    var titleLabelHeightConstraint : NSLayoutConstraint?
    
    private let separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        return view
    }()
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(thumbnailImageView)

        thumbnailImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor,paddongTop: 8, paddingLeft: 16, paddingRight: 16,width: self.frame.width, height: 235)
        
        addSubview(profileImageView)
        profileImageView.anchor(top : thumbnailImageView.bottomAnchor, left: leftAnchor,paddongTop: 8,paddingLeft: 16,paddiongBottom: 8 )
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stack.axis = . vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top : thumbnailImageView.bottomAnchor, left: profileImageView.rightAnchor, right:  rightAnchor , paddongTop: 8,paddingLeft: 16,paddingRight: 16)
//        titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeightConstraint!.constant).isActive = true
        
        
        
        addSubview(separatorView)
        separatorView.anchor(left : leftAnchor, bottom: bottomAnchor, right: rightAnchor,paddingLeft: 16, paddingRight: 16, height: 0.75)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        guard let video = video else {return}
        
        titleLabel.text = video.title
        
        setupProfileImage()
    
        setupThumbnail()
        
        let numbeFormatter = NumberFormatter()
            numbeFormatter.numberStyle = .decimal
        
        if let channelName = video.channel?.name, let numberOfVievs = video.numberOfViews {
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let subtitleText = "\(channelName) - \(numberFormatter.string(from: NSNumber(value: numberOfVievs))!) — 2 years ago"
            subTitleLabel.text = subtitleText
        }
        
        //measure title text
        guard let title = video.title else {return}
        let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
        
        if estimatedRect.size.height > 20 {
            titleLabelHeightConstraint?.constant = 44
        } else {
            titleLabelHeightConstraint?.constant = 20
        }
        
 
        
    }
    
    func setupThumbnail() {
        if let thumbnailImageUrl = video?.thumbnailImageName {
            thumbnailImageView.loadImageUsingUrl(urlString: thumbnailImageUrl)
        }
    }
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
            profileImageView.loadImageUsingUrl(urlString: profileImageUrl)
        }
    }
}
