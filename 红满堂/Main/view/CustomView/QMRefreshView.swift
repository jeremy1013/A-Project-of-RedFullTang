//
//  QMRefreshView.swift
//  红满堂
//
//  Created by Jacko Qm on 20/02/2017.
//  Copyright © 2017 欧阳铨. All rights reserved.
//

import UIKit

//QMPullRefreshView和QMRefreshHeader的父类
class QMRefreshView: UIView {
    
    //MARK: - Properties
    var superScrollView: UIScrollView? {
        didSet {
            addObserver()
            recognizer = superScrollView!.panGestureRecognizer
        }
    }
    var state: States = .idle
    var recognizer: UIPanGestureRecognizer?
    var readyToRefreshOffset: CGFloat = 0.0
    var executeBlock: (() -> Void)?
    
    deinit {
        removeObserver()
    }
    
    //MARK: - Override Method
    override func willMove(toSuperview newSuperview: UIView?) {
        if let superView = newSuperview as? UIScrollView {
            
            superScrollView = superView
            self.frameWidth = superView.frameWidth
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath {
            if keyPath == KeyPath.ContentOffset {
                let offsetY = (change![.newKey] as! CGPoint).y
                scrollViewDidScroll(offset: offsetY)
            } else if keyPath == KeyPath.PanGestureState {
                scrollViewGestureRecognizerStateDidChange()
            } else if keyPath == KeyPath.ContentSize {
                scrollViewContentSizeWillChanged(oldValue: (change![.oldKey] as! CGSize).height, newValue: (change![.newKey] as! CGSize).height)
            }
        }
    }
    
    // MARK: - Methods needs subClass to implement
    func scrollViewDidScroll(offset: CGFloat) { }
    
    func scrollViewGestureRecognizerStateDidChange() { }
    
    func scrollViewContentSizeWillChanged(oldValue: CGFloat, newValue: CGFloat) { }
    
    func scrollViewContentInsetDidChanged(newInset: UIEdgeInsets) { }
    
    // MARK: - Methods
    func isRefreshing() -> Bool {
        return state == .refreshing
    }
    
    // MARK: - Private Methods
    private func addObserver()
    {
        superScrollView!.addObserver(self, forKeyPath: KeyPath.ContentOffset, options: [.new, .old], context: nil)
        superScrollView!.addObserver(self, forKeyPath: KeyPath.PanGestureState, options: [.new], context: nil)
        superScrollView!.addObserver(self, forKeyPath: KeyPath.ContentSize, options: [.old, .new], context: nil)
    }
    
    private func removeObserver()
    {
        superScrollView!.removeObserver(self, forKeyPath: KeyPath.ContentOffset)
        superScrollView!.removeObserver(self, forKeyPath: KeyPath.PanGestureState)
        superScrollView!.removeObserver(self, forKeyPath: KeyPath.ContentSize)
    }
    
    // MARK: - Constants
    let ViewHeight: CGFloat = 60
}


extension QMRefreshView {
    
    enum States {
        case idle
        case ready
        case refreshing
        case ended //FooterView特有的标记，表示无更多数据标记
    }
    
    fileprivate struct KeyPath {
        static let ContentOffset = "contentOffset"
        static let ContentSize = "contentSize"
        static let ContentInset = "contentInset"
        static let PanGestureState = "panGestureRecognizer.state"
    }
    
}
