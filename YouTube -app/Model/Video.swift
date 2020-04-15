//
//  Video.swift
//  YouTube -app
//
//  Created by 酒井ゆうき on 2020/04/16.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

struct Video : Codable {
    
    let thumbnailImageName : String?
    let title : String?
    var numberOfView : Int?
    var uploadDate: Date?
    
    let channel : Channel?
}

class Channel : Codable {
    
    let name : String?
    let progileImageName : String?
}


