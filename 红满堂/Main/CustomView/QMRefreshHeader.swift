//
//  QmRefreshHeader.swift
//  红满堂
//
//  Created by Jacko Qm on 07/02/2017.
//  Copyright © 2017 欧阳铨. All rights reserved.
//

import UIKit
import CoreGraphics

class QMRefreshHeader: QMRefreshView {

    // MARK: - Properties
    private var descriptionLabel: UILabel!
    private var dateLabel: UILabel!
    private var showingImageView: UIImageView!
    private var indicatorView: UIActivityIndicatorView!
    
    private var lastUpdatedTime: Date?
    private var needRefreshDate = true
    
    private let showingText: [States: String] = [.idle: "Pull down to refresh",
                                                 .ready: "Release to refresh",
                                                 .refreshing: "Loading..."]
    
    // MARK: - Override Properties
    override var state: States {
        willSet {
            guard newValue != state else {
                return
            }
            switch newValue {
            case .ready where state == .idle:
                changeToReady()
            case .idle where state == .ready:
                changeToIdle(from: .ready)
            case .idle where state == .refreshing:
                changeToIdle(from: .refreshing)
            default:
                break
            }
        }
        //不在willSet中调用是因为changeToRefreshing方法会在header变成Refreshing状态过程中因添加Inset将header变为为idle状态
        didSet {
            if state == .refreshing {
                changeToRefreshing()
            }
        }
    }
    
    //MARK: - Static constructors
    static func getRefreshHeader(withRefreshBlock block: (() -> (Swift.Void))? = nil) -> QMRefreshHeader
    {
        let refreshHeader = QMRefreshHeader(frame: CGRect())
        refreshHeader.executeBlock = block
        
        return refreshHeader
    }
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frameHeight = ViewHeight
        
        descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        descriptionLabel.textAlignment = .center
        
        dateLabel = UILabel()
        dateLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        dateLabel.textAlignment = .center
        
        lastUpdatedTime = UserDefaults.standard.object(forKey: Constants.LastUpdatedDateKey) as? Date
        configureDateLabelText()
        
        showingImageView = UIImageView()
        showingImageView.image = UIImage(named: "arrow")
        showingImageView.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews()
    {
        dateLabel.sizeToFit()
        dateLabel.frameWidth = boundsWidth
        dateLabel.center = CGPoint(x: center.x, y: 1.5 * center.y)
        
        //帮助indicatorView确定位置
        descriptionLabel.text = showingText[.refreshing]
        descriptionLabel.sizeToFit()
        descriptionLabel.center = CGPoint(x: center.x, y: ViewHeight / 3)
        indicatorView = UIActivityIndicatorView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: descriptionLabel.frameHeight, height: descriptionLabel.frameHeight)))
        indicatorView.center.x = descriptionLabel.frame.minX - descriptionLabel.frameHeight
        indicatorView.center.y = descriptionLabel.center.y
        indicatorView.color = UIColor.black
        
        descriptionLabel.text = showingText[.idle]
        descriptionLabel.sizeToFit()
        descriptionLabel.center.x = center.x
        
        showingImageView.center = CGPoint(x: descriptionLabel.frame.minX - frame.maxX / 10, y: center.y)
        
        addSubview(descriptionLabel)
        addSubview(dateLabel)
        addSubview(showingImageView)
        addSubview(indicatorView)
        
        indicatorView.isHidden = true
        readyToRefreshOffset = self.frame.minY - self.frameHeight
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard (newSuperview as? UIScrollView) != nil else {
            return
        }
        configureViews()
    }
    
    //MARK: - Methods
    func beginRefreshing()
    {
        state = .refreshing
        executeBlock?()
    }
    
    func endRefreshing(didRefreshed isRefreshed: Bool = true)
    {
        guard isRefreshing() else {
            return
        }
        if let scrollView = superScrollView {
            state = .idle
            if isRefreshed {
                lastUpdatedTime = Date()
                configureDateLabelText()
                UserDefaults.standard.set(lastUpdatedTime, forKey: Constants.LastUpdatedDateKey)
            }
            
            
            UIView.animate(withDuration: Constants.ScrollBackAnimationTimeInterval, animations: {
                if scrollView.contentOffset.y <= 0 {
                    scrollView.contentOffset.y = 0
                }
            }, completion: { _ in
                self.removeInset()
            })
        }
    }
    
    //MARK: - Private Methods
    private func removeInset()
    {
        if let sv = superScrollView {
            var inset = sv.contentInset
            inset.top -= ViewHeight
            sv.contentInset = inset
        }
        
    }
    
    override func scrollViewDidScroll(offset: CGFloat)
    {
        if state == .idle {
            //判断是否需要更新DateLabel
            if offset < frame.minY && needRefreshDate {
                configureDateLabelText()
                needRefreshDate = false
            } else if offset >= frame.minY && !needRefreshDate {
                needRefreshDate = true
            } else if offset <= readyToRefreshOffset {
                state = .ready
            }
        } else if state == .ready {
            if offset > readyToRefreshOffset {
                state = .idle
            }
        }
    }
    
    override func scrollViewGestureRecognizerStateDidChange()
    {
        if recognizer!.state == .ended && state == .ready {
            let offset = superScrollView!.contentOffset.y
            if offset > readyToRefreshOffset {
                state = .idle
            } else {
                beginRefreshing()
            }
        }
    }
    
    private func changeToReady()
    {
        descriptionLabel.text = showingText[.ready]
        UIView.animate(withDuration: Constants.ArrowRotateAnimationTimeInterval) {
            self.showingImageView.transform = CGAffineTransform(rotationAngle: -π)
        }
    }
    
    private func changeToIdle(from state: States)
    {
        if state == .ready {
            descriptionLabel.text = showingText[.idle]
            UIView.animate(withDuration: Constants.ArrowRotateAnimationTimeInterval, animations: {
                self.showingImageView.transform = CGAffineTransform(rotationAngle: 0)
            })
        } else if state == .refreshing {
            showingImageView.isHidden = false
            showingImageView.transform = CGAffineTransform(rotationAngle: 0)
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
            descriptionLabel.text = showingText[.idle]
            descriptionLabel.sizeToFit()
            descriptionLabel.center.x = center.x
        }
    }
    
    private func changeToRefreshing()
    {
        showingImageView.isHidden = true
        indicatorView.isHidden = false
        descriptionLabel.text = showingText[.refreshing]
        descriptionLabel.sizeToFit()
        descriptionLabel.center.x = center.x
        indicatorView.startAnimating()
        
        
        if let scrollView = superScrollView {
            var inset = scrollView.contentInset
            inset.top += ViewHeight
            scrollView.contentInset = inset
            scrollView.setContentOffset(CGPoint(x: 0, y: readyToRefreshOffset), animated: false)
        }
    }
    
    private func configureDateLabelText()
    {
        if let date = lastUpdatedTime {
            dateLabel.text = Constants.DateLabelStdText + HMTToolS.getTimeIntervalString(from: date)
        } else {
            dateLabel.text = Constants.DateLabelStdText + Constants.NotUpdatedText
        }
    }
    
}

extension QMRefreshHeader {
    
    struct Constants {
        static let LastUpdatedDateKey = "lastUpdatedDate"
        static let ArrowRotateAnimationTimeInterval = 0.3
        static let ScrollBackAnimationTimeInterval = 0.5
        static let DateLabelStdText = "Last updated: "
        static let NotUpdatedText = "No updated yet"
    }
}
