//
//  Constants.swift
//  红满堂
//
//  Created by Jacko Qm on 26/01/2017.
//  Copyright © 2017 欧阳铨. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let ScrollViewHeight: CGFloat = 44
    static let NavBarHeight: CGFloat = HMTTool.getPushNavigation().navigationBar.frame.size.height
    static let NumberOfPostToFetch: Int = 10
    static let userDefaultImage: UIImage = UIImage(named: "userDefault")!
    
    struct Identifier {
        static let HMTTableViewCell = "HMTRecommendCell"
        static let HMTLoadingCell = "HMTLoadingTableViewCell"
        static let HMTDetailCell = "HMTRecommendDetailTableViewCell"
        static let HMTScrollViewCell = "HMTScrollViewCell"
    }
}
