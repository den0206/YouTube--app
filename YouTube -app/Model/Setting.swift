//
//  Setting.swift
//  YouTube -app
//
//  Created by 酒井ゆうき on 2020/04/17.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

/// use @objc paramator
class Setting : NSObject {
    let name : SettingName
    let imageName: SettingIconName
    
    init(name: SettingName, imageName: SettingIconName) {
           self.name = name
           self.imageName = imageName
       }
}

enum SettingName: String {
    case cancel = "Cancel"
    case settings = "Settings"
    case termsPrivacy = "Terms & privacy policy"
    case sendFeedback = "Send Feedback"
    case help = "Help"
    case switchAccount = "Switch Account"
}

enum SettingIconName: String {
    case settingsIcon = "settings"
    case privacyIcon = "privacy"
    case feedbackIcon = "feedback"
    case helpIcon = "help"
    case switchAccountIcon = "switch_account"
    case cancelIcon = "cancel"
}

