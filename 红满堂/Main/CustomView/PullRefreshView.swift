//
//  PullRefreshView.swift
//  红满堂
//
//  Created by Jacko Qm on 11/01/2017.
//  Copyright © 2017 欧阳铨. All rights reserved.
//

import UIKit

class PullRefreshView: UIView
{
    private var refreshLabel: UILabel!
    private var indicatorView: UIActivityIndicatorView!
    private var currentStatus: Status = .end
    
    enum Status {
        case normal
        case prepare
        case loading
        case end
    }
    
    override init(frame: CGRect)
    {
        refreshLabel = UILabel()
        indicatorView = UIActivityIndicatorView()
        
        super.init(frame: frame)
        
        changeStatues(.normal)
        addSubview(refreshLabel)
        addSubview(indicatorView)
        indicatorView.isHidden = true
        indicatorView.color = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeText(_ text: String)
    {
        if refreshLabel.text != text {
            refreshLabel.text = text
            refreshLabel.sizeToFit()
            refreshLabel.center = CGPoint(x: self.bounds.maxX / 2, y: self.bounds.maxY / 2)
        }
    }
    
    func changeStatues(_ status: Status)
    {
        if currentStatus == status {
            return
        }
        switch status {
        case .normal:
            refreshLabel.text = "上拉精彩继续..."
        case .prepare:
            refreshLabel.text = "快松手，我要加载啦..."
        case .loading:
            refreshLabel.text = "加载中..."
        case .end:
            refreshLabel.text = "已经没有更多啦..."
        }
        refreshLabel.sizeToFit()
        refreshLabel.center = CGPoint(x: self.bounds.maxX / 2, y: self.bounds.maxY / 2)
        if status == .loading {
            indicatorView.isHidden = false
            indicatorView.frame = CGRect(x: refreshLabel.frame.minX - 30, y: refreshLabel.frame.minY, width: 20, height: 20)
            indicatorView.startAnimating()
        } else if !indicatorView.isHidden {
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
        }
        currentStatus = status
    }
    
    func isLoading() -> Bool {
        return currentStatus == .loading
    }
}
