//
//  QMPullRefreshView.swift
//  红满堂
//
//  Created by Jacko Qm on 11/01/2017.
//  Copyright © 2017 欧阳铨. All rights reserved.
//

import UIKit

class QMRefreshFooter: QMRefreshView
{
    // MARK: - Private Properties
    private var refreshLabel: UILabel!
    private var indicatorView: UIActivityIndicatorView!
    private var showingText: [States: String] = [.idle: "上拉精彩继续...",
                               .ready: "快松手，我要加载啦...",
                               .refreshing: "加载中...",
                               .ended: "已经没有更多啦..."]
//    private var actualHeight: CGFloat = 0
    private var hasMovedToSuperView: Bool = false
    private var scrollViewOffsetY: CGFloat = 0
    
    // MARK: - Override Properties
    override var state: States {
        willSet {
            guard newValue != state else {
                return
            }
            switch newValue {
            case .idle where state == .ready:
                changeToIdle(from: .ready)
            case .idle where state == .refreshing:
                changeToIdle(from: .refreshing)
            case .ready:
                changeToReady()
            default:
                break
            }
        }
        didSet {
            if state == .refreshing {
                beginRefreshing()
            } else if state == .ended {
                changeToEnded()
            }
        }
    }
    override var frame: CGRect {
        didSet {
            if let sv = superScrollView {
                readyToRefreshOffset = frame.maxY - sv.boundsHeight + ViewHeight
//                print("Qm: readyToRefreshOffset: \(readyToRefreshOffset)")
            }
        }
    }
    
    static func getPullRefreshView(withRefreshBlock block: (() -> (Swift.Void))? = nil) -> QMRefreshFooter
    {
        let refreshView = QMRefreshFooter()
        refreshView.executeBlock = block
        
        return refreshView
    }
    
    // MARK: - Initializes
    override init(frame: CGRect)
    {
        refreshLabel = UILabel()
        indicatorView = UIActivityIndicatorView()
        
        super.init(frame: frame)
        
        self.frameHeight = ViewHeight
        refreshLabel.textAlignment = .center
        refreshLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        addSubview(refreshLabel)
        addSubview(indicatorView)
        indicatorView.isHidden = true
        indicatorView.color = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    override func didMoveToSuperview()  {
        super.didMoveToSuperview()
        
        configureView()
        hasMovedToSuperView = true
        if superScrollView!.contentSize.height < superScrollView!.boundsHeight {
            state = .ended
        }
    }
    
    override func scrollViewDidScroll(offset: CGFloat)
    {
        guard hasMovedToSuperView != false && !isRefreshing() && state != .ended else {
            return
        }
        
//        print("Qm: offset: \(offset), frame.minY: \(frame.minY)")
        if offset > readyToRefreshOffset {
            state = .ready
            scrollViewOffsetY = offset
        } else {
            state = .idle
        }
    }
    
    override func scrollViewGestureRecognizerStateDidChange()
    {
        if recognizer!.state == .ended {
            if state == .ready && state != .ended {
                state = .refreshing
            }
        }
    }
    
    private func configureView()
    {
        
        refreshLabel.text = showingText[.idle]
        refreshLabel.sizeToFit()
        refreshLabel.frameWidth = superScrollView!.boundsWidth
        refreshLabel.center.y = self.center.y
        
        indicatorView.frame.size = CGSize(width: refreshLabel.frameHeight, height: refreshLabel.frameHeight)
        indicatorView.center = self.center
    }
    
    private func changeToIdle(from state: States)
    {
        refreshLabel.text = showingText[.idle]
        
        if state == .refreshing {
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
            refreshLabel.isHidden = false
            removeEdgeInset()
        }
    }
    
    private func changeToReady()
    {
        refreshLabel.text = showingText[.ready]
    }
    
    private func changeToEnded()
    {
        refreshLabel.text = showingText[.ended]
        //刷新后发现没数据需隐藏加载界面
        if indicatorView.isHidden == false {
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
            refreshLabel.isHidden = false
        }
    }
    
    private func insertEdgeInset()
    {
        if let scrollView = superScrollView {
            var inset = scrollView.contentInset
            
            inset.bottom += ViewHeight
            scrollView.contentInset = inset
            scrollView.setContentOffset(CGPoint(x: 0, y: readyToRefreshOffset), animated: false)
        }
    }
    
    private func removeEdgeInset()
    {
        if let sv = superScrollView {
            UIView.animate(withDuration: Constants.ScrollBackAnimationTimeInterval, animations: {
                if sv.contentOffset.y >= self.readyToRefreshOffset {
                    sv.contentOffset.y = self.scrollViewOffsetY
                }
            }, completion: { _ in
                var inset = sv.contentInset
                inset.bottom -= 60
                sv.contentInset = inset
            })
        } 
    }
    
    // MARK: - Methods
    func beginRefreshing()
    {
        refreshLabel.isHidden = true
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        
        insertEdgeInset()
        executeBlock?()
    }
    
    func endRefreshing(hasMoreData: Bool)
    {
        guard isRefreshing() else {
            return
        }
        if hasMoreData {
            state = .idle
        } else {
            state = .ended
        }
    }
   
    func isEnded() -> Bool {
        return state == .ended
    }
    
    static func getViewHeigt() -> CGFloat {
        return QMRefreshView().ViewHeight
    }
}

// MARK: - Constants
extension QMRefreshFooter {
    
    fileprivate struct Constants {
        static let ScrollBackAnimationTimeInterval = 0.5
    }
}
