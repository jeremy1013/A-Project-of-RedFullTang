//
//  HMTRecommendDetailTableViewModel.swift
//  红满堂
//
//  Created by Qm on 25/11/2016.
//  Copyright © 2016 欧阳铨. All rights reserved.
//

import Foundation

class HMTRecommendDetailTableViewModel {
    
    var authorID: String!
    var authorName: String!
    
    var title: String?
    var lastEdit: String?
    var quote: String?
    private var _message: NSMutableAttributedString!
    var message: NSMutableAttributedString {
        set {
            var text = newValue.string
            lastEdit = HMTToolS.getLastEdit(from: text)
            quote = HMTToolS.getQuote(from: text)
            _message = NSMutableAttributedString()
            if let lastEdit = lastEdit {
                let removeRange = text.index(text.startIndex, offsetBy: 5)..<text.range(of: "[/i]")!.lowerBound
                text.removeSubrange(removeRange)
                
                _message.yy_appendString(lastEdit + "\n")
                _message.yy_setColor(UIColor(red: 153/255, green: 136/255, blue: 169/255, alpha: 1), range: NSMakeRange(0, lastEdit.characters.count))
            }
            if let quote = quote {
                let removeRange = text.index(text.startIndex, offsetBy: 7)..<text.range(of: "[/quote]")!.lowerBound
                text.removeSubrange(removeRange)
                _message.yy_appendString("\t" + quote + "\n")
                let offset = (lastEdit == nil ? 0 : quote.characters.count + 1)
                _message.yy_setColor(UIColor(red: 72/255, green: 178/255, blue: 168/255, alpha: 1), range: NSMakeRange(offset, offset + quote.characters.count + 2))
            }
            text = HMTToolS.getString(fromHMTText: text)
            _message.yy_appendString("\t" + text)
        }
        get {
            return _message
        }
    }
    
    var postDate: String {
        set {
            _postDate = HMTToolS.tranformToDateString(from: newValue)
        }
        get {
            return _postDate
        }
    }
    private var _postDate: String!
    
}
