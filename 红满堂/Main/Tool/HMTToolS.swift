//
//  HMTTool.swift
//  红满堂
//
//  Created by Qm on 25/11/2016.
//  Copyright © 2016 欧阳铨. All rights reserved.
//

import Foundation

class HMTToolS {
    //将时间戳转换成标准样式字符串
    static func tranformToDateString(from timeStamp: String) -> String 
    {
        guard !timeStamp.isEmpty else {
            return ""
        }
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp)!)
        let formatter = DateFormatter()
        formatter.dateFormat = "发表于 yyyy-MM-dd  HH:mm"
        return formatter.string(from: date)
    }
    
    //将论坛字符串的奇怪[]删除
    static func getString(fromHMTText hmtText: String) -> String 
    {
        var result = hmtText
        while true {
            guard let startIndex = result.characters.index(of: "[") as String.Index?, let endIndex = result.characters.index(of: "]") as String.Index? else {
                break
            }
            let length = result.distance(from: startIndex, to: endIndex)
            guard length > 0 else {
                break
            }
            guard length != 1 else {
                continue
            }
            let range = startIndex..<result.index(endIndex, offsetBy: 1)
            result.removeSubrange(range)
        }
        while result.hasPrefix("\n") || result.hasPrefix("\r") || result.hasPrefix(" ") {
            result.remove(at: result.startIndex)
        }
        
        return result.replacingOccurrences(of: "\n", with: "\n\t")
    }
    
    static func getLastEdit(from text: String) -> String? {
        return getText(from: text, withKeyword: "i=s")
    }

    static func getQuote(from text: String) -> String?
    {
        return getText(from: text, withKeyword: "quote", andExtra: "回复: ")
    }
    
    private static func getText(from text: String, withKeyword keyword: String, andExtra extraText: String = "") -> String?
    {
        var suffix = keyword
        if keyword == "i=s" {
            suffix = "i"
        }
        if text.hasPrefix(String("[\(keyword)]")) {
            let suffixRange = text.range(of: String("[/\(suffix)]"))!
            let length = keyword.characters.count + 2
            let textRange = (text.index(text.startIndex, offsetBy: length)..<suffixRange.lowerBound)
            var tempText = getString(fromHMTText: text.substring(with: textRange))
            if tempText.hasSuffix("\r\n\t") {
                let rangeToDelete = tempText.range(of: "\r\n\t", options: .backwards)!
                tempText.removeSubrange(rangeToDelete)
            }
            
            return "【" + extraText + tempText + "】"
        }
        return nil
    }
    
    static func getTimeIntervalString(from date: Date) -> String
    {
        let calendar = Calendar.current
        let dateComp = calendar.dateComponents([.minute, .hour, .day], from: date, to: Date())
        
        if calendar.isDateInToday(date) {
            if let hour = dateComp.hour, hour >= 1 {
                return "\(hour) " + (hour == 1 ? "hour" : "hours") + " ago"
            } else if let minute = dateComp.minute {
                if minute == 0 {
                    return "Just now"
                }
                return "\(minute) " + (minute == 1 ? "minute" : "minutes") + " ago"
            }
        } else {
            if let day = dateComp.day {
                
                return "\(day+1) " + ((day+1) == 1 ? "day" : "days") + " ago"
            }
        }
        return "Something wrong!"
    }
    
}
