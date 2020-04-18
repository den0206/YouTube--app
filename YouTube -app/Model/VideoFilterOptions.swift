//
//  VideoFilterOptions.swift
//  YouTube -app
//
//  Created by 酒井ゆうき on 2020/04/18.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

enum VideoFilterOptions : Int {
    
    case Feed
    case Trend
    case Subscription
    
    
    var description : String {
        switch self {
        case .Feed:
            return "Feed"
        case .Trend :
            return "Trend"
        case .Subscription :
            return "Subscription"
        }
    }
}
