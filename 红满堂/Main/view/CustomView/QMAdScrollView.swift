//
//  QMAdScrollView.swift
//  红满堂
//
//  Created by Jacko Qm on 03/03/2017.
//  Copyright © 2017 欧阳铨. All rights reserved.
//

import UIKit

class QMAdIndicatorView: UIActivityIndicatorView {
    override var isHidden: Bool {
        didSet {
            guard let scrollView = superview as? QMAdScrollView, scrollView.adData == nil else {
                return
            }
            if isHidden {
                DispatchQueue.main.async {
                    self.startAnimating()
                }
            }
        }
    }
}

class QMAdScrollView: UIView {
    
    // MARK: - Private Properties
    private var scrollView: UIScrollView!
    private var bottomView: UIView!
    private var pageControl: UIPageControl!
    private var adLabel: UILabel!
    var indicatorView: QMAdIndicatorView!
    
    private let PanGestureRecognizerKeyPath = "panGestureRecognizer.state"
    
    fileprivate var turnPageTimer: Timer?
    fileprivate var currentPage: Int! {
        didSet {
            guard let adData = adData else {
                return
            }
            if currentPage == 0 {
                currentPage = adData.count-1
            } else if currentPage == adData.count+1 {
                currentPage = 0
            } else {
                currentPage! -= 1
            }
        }
    }
    
    // MARK: - Properties
    var adData: [AdData]? {
        didSet {
            if let adData = adData {
                indicatorView.stopAnimating()
                indicatorView.isHidden = true
                //准备展示前设定好各个view的位置
                pageControl.numberOfPages = adData.count
                pageControl.frameWidth = pageControl.size(forNumberOfPages: pageControl.numberOfPages).width
                pageControl.frameHeight = bottomView.boundsHeight
                pageControl.frameX = self.boundsWidth - pageControl.frameWidth - 10
                adLabel.frameX = 8.0
                adLabel.frameWidth = pageControl.frameX
                adLabel.frameHeight = bottomView.boundsHeight
                
                bottomView.addSubview(adLabel)
                bottomView.addSubview(pageControl)
                pageControl.addTarget(self, action: #selector(pageControlHandler), for: .valueChanged)
                //若之前设定autoDisplay时adData未被赋值，那么重新设定以启动Timer
                if autoDisplay {
                    autoDisplay = true
                }
                
                scrollView.contentSize.width = CGFloat(adData.count + 2) * self.frameWidth
                indicatorView.removeFromSuperview()
                
                let end = adData.count + 2
                for i in 0..<end {
                    let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * boundsWidth, y: 0, width: boundsWidth, height: boundsHeight))
                    //增加两张图片于首尾，用来实现循环Scroll
                    currentPage = i
                    _ = imageView.loadImage(url: URL(string: adData[currentPage].imageURL)!)
                    
                    scrollView.addSubview(imageView)
                }
                
                scrollView.setContentOffset(CGPoint(x: boundsWidth, y: 0.0), animated: false)
                currentPage = 1
                turnTo(page: currentPage)
            }
        }
    }
    
    var autoDisplay: Bool = false {
        didSet {
            guard adData != nil else {
                return
            }
            if autoDisplay && turnPageTimer == nil {
                turnPageTimer = Timer.scheduledTimer(timeInterval: displayInterval, target: self, selector: #selector(autoTurnPage), userInfo: nil, repeats: true)
            } else {
                turnPageTimer?.invalidate()
                turnPageTimer = nil
            }
        }
    }
    var displayInterval: TimeInterval = 3.0
    
    // MARK: - Initializes
    override init(frame: CGRect)
    {
        scrollView = UIScrollView(frame: frame)
        bottomView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: 40))
        bottomView.frameY = frame.height - bottomView.frameHeight
        pageControl = UIPageControl()
        adLabel = UILabel()
        indicatorView = QMAdIndicatorView()
        
        super.init(frame: frame)
        
        scrollView.addObserver(self, forKeyPath: PanGestureRecognizerKeyPath, options: [.new], context: nil)
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        
        indicatorView.center = center
        indicatorView.color = UIColor.blue
        indicatorView.startAnimating()
        
        self.addSubview(scrollView)
        self.addSubview(bottomView)
        self.addSubview(indicatorView)
        
        self.backgroundColor = UIColor.clear
        bottomView.backgroundColor = UIColor.black
        bottomView.alpha = 0.7
        pageControl.pageIndicatorTintColor = UIColor.red
        adLabel.textColor = UIColor.white
        adLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        scrollView.removeObserver(self, forKeyPath: PanGestureRecognizerKeyPath)
        turnPageTimer?.invalidate()
    }
    
    // MARK: - Override Methods
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let kp = keyPath, kp == PanGestureRecognizerKeyPath {
//            gestureStateDidChanged(toState: (change![.newKey] as! Int))
        }
    }
    
    // MARK: - Private Methods
    @objc
    private func autoTurnPage()
    {
        currentPage! += 2 //因为currentPage特殊性，加2效果等于加1
        turnTo(page: currentPage)
    }
    
    @objc
    private func pageControlHandler()
    {
        currentPage = pageControl.currentPage+1
        turnTo(page: currentPage)
    }

    fileprivate func turnTo(page: Int, animated: Bool = true)
    {
        guard adData != nil else {
            return
        }
        if scrollView.contentOffset.x != (CGFloat(page+1)*boundsWidth) {
            scrollView.setContentOffset(CGPoint(x: CGFloat(page+1) * boundsWidth, y: 0), animated: animated)
        }
        pageControl.currentPage = page
        adLabel.text = adData?[page].adText
    }
}

// MARK: - Implement of UIScrollViewDelegate
extension QMAdScrollView: UIScrollViewDelegate
{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.boundsWidth)
        
        if page == 0 {
            scrollView.setContentOffset(CGPoint(x: CGFloat(adData!.count) * boundsWidth, y: 0), animated: false)
        } else if page == adData!.count+1 {
            scrollView.setContentOffset(CGPoint(x: boundsWidth, y: 0), animated: false)
        }
        currentPage = page
        turnTo(page: currentPage)
        
        if autoDisplay {
            autoDisplay = true
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if autoDisplay {
            turnPageTimer?.invalidate()
            turnPageTimer = nil
        }
    }
    
}

// MARK: - Structs
struct AdData {
    var imageURL: String
    var adText: String
}
