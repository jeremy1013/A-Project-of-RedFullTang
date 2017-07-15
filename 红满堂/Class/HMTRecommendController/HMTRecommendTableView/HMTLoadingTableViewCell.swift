//
//  HMTLoadingTableViewCell.swift
//  红满堂
//
//  Created by Jacko Qm on 24/01/2017.
//  Copyright © 2017 欧阳铨. All rights reserved.
//

import UIKit

class HMTLoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var showingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        startLoading()
    }
    
    override func didMoveToSuperview() {
        self.backgroundColor = superview?.backgroundColor
    }
    
    func startLoading()
    {
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        showingLabel.text = "正在玩命地加载中..."
    }
    
    func loadDidFail()
    {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
        showingLabel.text = "Oh no! 网络异常，点击重新加载..."
    }
    
}
