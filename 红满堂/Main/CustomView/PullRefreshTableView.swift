//
//  PullToRefreshTableView.swift
//  红满堂
//
//  Created by Jacko Qm on 16/01/2017.
//  Copyright © 2017 欧阳铨. All rights reserved.
//

import UIKit

class PullRefreshTableView: UITableView {
    
    private var refreshView: PullRefreshView?
    private var hasMoreData = true
    private var isPrepareToRefresh = false
    private var currentContentSizeHeight: CGFloat = 0 {
        willSet {
            print("Qm: oldValue: \(currentContentSizeHeight), newValue: \(newValue)")
        }
        didSet {
            refreshView?.frame.origin.y = currentContentSizeHeight + 10
            self.setNeedsLayout()
        }
    }
    
    var refreshDelegate: PullRefreshTableViewDelegate?
    
    override var contentOffset: CGPoint {
        didSet {
            let actualHeight = contentSize.height
            if let refreshView = refreshView {
                if hasMoreData && actualHeight > self.bounds.height && !refreshView.isLoading()
                {
                    let readyToRefreshOffset = actualHeight - self.bounds.height + 80
                    if isPrepareToRefresh && !isDragging && contentOffset.y > readyToRefreshOffset - 45 {
                        //In order to prevent scrollview continue to scroll, so make the view be the tableview footerview
                        refreshView.removeFromSuperview()
                        self.tableFooterView = refreshView
                        refreshView.changeStatues(.loading)
                        isPrepareToRefresh = false
                        refreshDelegate?.tableViewWillStartLoading(self)
                    }
                    else if contentOffset.y > readyToRefreshOffset {
                        refreshView.changeStatues(.prepare)
                        isPrepareToRefresh = true
                    } else {
                        refreshView.changeStatues(.normal)
                    }
                }
            } else {
//                print("\(contentOffset.y - actualHeight - self.bounds.height)")
                if abs(contentOffset.y - (actualHeight - self.bounds.height)) <= 300 {
                    currentContentSizeHeight = contentSize.height
                    refreshView = PullRefreshView(frame: CGRect(x: 0, y: currentContentSizeHeight + 10, width: self.bounds.width, height: 40))
                    if !hasMoreData {
                        refreshView!.changeStatues(.end)
                        self.tableFooterView = refreshView!
                        return
                    }
                    self.addSubview(refreshView!)
                }
            }
        }
    }
    
    func isLoading() -> Bool {
        guard let rv = refreshView else {
            return false
        }
        return rv.isLoading()
    }
    
    func finishLoading(hasMoreData: Bool)
    {
        tableFooterView = nil
        refreshView = nil
        self.hasMoreData = hasMoreData
        self.reloadData()
    }
    
    override var contentSize: CGSize {
        didSet {
            if hasMoreData && abs(contentSize.height - currentContentSizeHeight) > 10 {
                currentContentSizeHeight = contentSize.height
            }
        }
    }
}


protocol PullRefreshTableViewDelegate {
    func tableViewWillStartLoading(_ tableView: PullRefreshTableView)
}
