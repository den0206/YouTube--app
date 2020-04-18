//
//  SettingLauncher.swift
//  YouTube -app
//
//  Created by 酒井ゆうき on 2020/04/16.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

private let  reuseIdentifer = "settingCell"

protocol SettingLauncherDelegate {
    func showControllerForSetting(setting : Setting)
}

class SettingLauncher : NSObject {
    
    let blackView = UIView()
    
    let settings: [Setting] = {
        return [Setting(name: .settings, imageName: .settingsIcon),
                Setting(name: .termsPrivacy, imageName: .privacyIcon),
                Setting(name: .sendFeedback, imageName: .feedbackIcon),
                Setting(name: .help, imageName: .helpIcon),
                Setting(name: .switchAccount, imageName: .switchAccountIcon),
                Setting(name: .cancel, imageName: .cancelIcon)]
    }()
    
    
    
    var delegate : SettingLauncherDelegate?
    
    let collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellHelght : CGFloat = 50
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: reuseIdentifer)
        
        collectionView.isScrollEnabled = false
    }
    
    @objc func showSettings() {
        /// entire windo
        if let window = UIWindow.key {
            ///show menu
            
            blackView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            window.addSubview(collectionView)
            
            /// from bottom
            let height : CGFloat = CGFloat(settings.count) * cellHelght
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: height)
            }, completion: nil)
            
            
        }
    }
    
    @objc func handleDismiss(setting : Setting) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            
            if let window = UIWindow.key {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed: Bool) in
            if setting.name != .cancel {
                self.delegate?.showControllerForSetting(setting: setting)
            }
        }
    }
    
}

extension SettingLauncher : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as! SettingCell
        
        cell.setting = settings[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = settings[indexPath.item]
        
       handleDismiss(setting: setting)
    }

}

extension SettingLauncher : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHelght)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
