//
//  String+Extension.swift
//  红满堂
//
//  Created by Qm on 12/11/2016.
//  Copyright © 2016 欧阳铨. All rights reserved.
//

import Foundation

extension Data {
    var attributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
             print(error.localizedDescription)
        }
        return nil
    }
}

extension String {
    var utf8Data: Data? {
        return data(using: .utf8)
    }
}
