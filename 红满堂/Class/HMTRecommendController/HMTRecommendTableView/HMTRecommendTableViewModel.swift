//
//  HMTRecommendTableViewModel.swift
//  红满堂
//
//  Created by Qm on 11/11/2016.
//  Copyright © 2016 欧阳铨. All rights reserved.
//

import Foundation

class HMTRecommendTableViewModel {
    
    var _postDate: String!
    //发布时间
    var postDate: String! {
        set {
            _postDate = HMTToolS.tranformToDateString(from: newValue)
        }
        get {
            return _postDate
        }
    }
    // 标题
    var title: String!
    // 回复数目
    var answerCount: String!
    //预览内容
    private var previewText: NSMutableAttributedString!
    // 内容
    var text: NSMutableAttributedString {
        set {
            var newString = newValue.string
            
            lastEdit = HMTToolS.getLastEdit(from: newString)
            if lastEdit != nil {
                let removeRange = newString.index(newString.startIndex, offsetBy: 5)..<newString.range(of: "[/i]")!.lowerBound
                newString.removeSubrange(removeRange)
            }
            
            let transformedText = HMTToolS.getString(fromHMTText: newString)
            configurePreviewText(from: transformedText)
        }
        get {
            return previewText
        }
    }
    //预览内容的正文
    var content: String! {
        didSet {
            configureText()
        }
    }
    // 最后修改
    var lastEdit: String?
    // 用户名
    var userName: String! {
        didSet {
            if userName.isEmpty {
                userName = "匿名"
            }
        }
    }
    // 用户ID
    var authorID: String!
    // 帖子ID
    var threadID: String!
        
    private func configurePreviewText(from text: String) {
        var tempText: String!
        
        if text.characters.count > 90 {
            if lastEdit == nil {
                tempText = text.substring(to: text.index(text.startIndex, offsetBy: 91))
            } else {
                 tempText = text.substring(to: text.index(text.startIndex, offsetBy: 71))
            }
        } else {
            tempText = text
        } 
        
        tempText = tempText.replacingOccurrences(of: " ", with: "")
        tempText = tempText.replacingOccurrences(of: "\r\n", with: "  ")
        content = tempText
    }
    
    private func configureText()
    {
        if let lastEdit = lastEdit {
            previewText = NSMutableAttributedString(string: String(format: "%@\n\t%@", lastEdit, content))
            previewText.yy_setColor(UIColor(red: 153/255, green: 136/255, blue: 169/255, alpha: 1), range: NSMakeRange(0, lastEdit.characters.count))
        } else {
            previewText = NSMutableAttributedString(string: String(format: "\t%@", content))
        }
    }
}
