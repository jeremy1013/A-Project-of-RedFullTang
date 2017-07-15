//
//  UIColor+Extension.swift
//  红满堂
//
//  Created by Jacko Qm on 24/01/2017.
//  Copyright © 2017 欧阳铨. All rights reserved.
//

import UIKit

extension UIColor
{
    static func rbgColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
