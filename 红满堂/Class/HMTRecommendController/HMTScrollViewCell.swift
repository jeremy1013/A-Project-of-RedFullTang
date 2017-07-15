//
//  HMTScrollViewCell.swift
//  红满堂
//
//  Created by Jacko Qm on 07/02/2017.
//  Copyright © 2017 欧阳铨. All rights reserved.
//

import UIKit

class HMTScrollViewCell: UITableViewCell {

    private var scrollView: QMAdScrollView!
    
    private var isFirstTime = true
    private var adData = [AdData]()
    
    override func draw(_ rect: CGRect) {
        guard scrollView == nil else {
            return
        }
        scrollView = QMAdScrollView(frame: self.bounds)
        addSubview(scrollView)
        configure()
        scrollView.autoDisplay = true
    }

    func configure()
    {
        guard isFirstTime else {
            return
        }
        isFirstTime = false
        var data = AdData(imageURL: "http://hometown.scau.edu.cn/bbs/data/attachment/forum/201703/02/124705do5mrofim91kd5k1.png", adText: "【3.7华农专场】中国通信服务广东公司2017届春季校园招聘")
        adData.append(data)
        data = AdData(imageURL: "http://hometown.scau.edu.cn/bbs/data/attachment/forum/201703/02/101914xs6dw6hq9fhilqlp.png", adText: "公务员资料  行测6元 申论4元")
        adData.append(data)
        data = AdData(imageURL: "http://hometown.scau.edu.cn/bbs/data/attachment/forum/201703/01/222517c7qw8fhhshia4cff.jpg", adText: "风夏（又是一部音乐纯恋）")
        adData.append(data)
        
        scrollView.adData = adData
    }
}
