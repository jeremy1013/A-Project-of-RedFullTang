//
//  NetWorkToolS.swift
//  红满堂
//
//  Created by Qm on 28/11/2016.
//  Copyright © 2016 欧阳铨. All rights reserved.
//

import Foundation

class NetWorkToolS 
{
    private struct HMTRequestUrlsFormat {
        static let RecommendURL = "http://hometown.scau.edu.cn/bbs/plugin.php?id=iltc_open:thread&fid=36&page=%d&limit=%d"
        static let RecommendDetailURL = "http://hometown.scau.edu.cn/bbs/plugin.php?id=iltc_open:post&tid=%d&page=%d&limit=%d"
        static let UserIconURL = "http://hometown.scau.edu.cn/bbs/uc_server/avatar.php?uid=%@"
    }
    
    static func getRecommendURL(withPages pages: Int, andLimit limit: Int) -> URL
    {
        let urlString = String(format: HMTRequestUrlsFormat.RecommendURL, pages, limit)
        
        return URL(string: urlString)!
    }
    
    static func getRecommendDetailURL(withThreadID threadID: Int, pages: Int, andLimit limit: Int ) -> URL
    {
        let urlString = String(format: HMTRequestUrlsFormat.RecommendDetailURL, threadID, pages, limit)
        
        return URL(string: urlString)!
    }
    
    static func getUserIconURL(withAuthorID id : String) -> URL 
    {
        let urlString = String(format: HMTRequestUrlsFormat.UserIconURL, id)
        
        return URL(string: urlString)!
    }
    
    
    static func parseJsonDictionary(from url: URL, completionHandler: @escaping ([String: Any]?, URLResponse?, Error?) -> Void)
    {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url, completionHandler: {
            data, response, error in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let data = data, let jsonDictionary = self.parse(json: data) { 
                   completionHandler(jsonDictionary, response, error)
                }
            } else {
                print("Qm: response: \(response)")
                print("Qm: error: \(error)")
                completionHandler(nil, response, error)
            }
        })
        dataTask.resume()
    }
    
    private static func parse(json data: Data) -> [String: Any]? 
    {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
    }
}





