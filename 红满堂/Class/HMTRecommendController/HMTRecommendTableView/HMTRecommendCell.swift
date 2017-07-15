//
//  HMTRecommendCell.swift
//  红满堂
//
//  Created by Qm on 07/11/2016.
//  Copyright © 2016 欧阳铨. All rights reserved.
//

import UIKit

class HMTRecommendCell: UITableViewCell {
    
    @IBOutlet weak var userIconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: YYLabel!
    @IBOutlet weak var answerLabel: UILabel!
    //@IBOutlet weak var detailView: UIView!
    
    private var dataTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.white
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.main.scale
        
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        layer.borderWidth = 1
        //layer.borderColor = UIColor.clear.cgColor
        layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
//        let backgroundLayer = detailView.layer
//        backgroundLayer.cornerRadius = 5
//        backgroundLayer.shadowColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
//        backgroundLayer.shadowOffset = CGSize(width: 0, height: 4)
//        backgroundLayer.shadowOpacity = 0.5
//        backgroundLayer.shadowRadius = 4
//        backgroundLayer.shouldRasterize = true
//        backgroundLayer.rasterizationScale = UIScreen.main.scale
    }
    
    override func draw(_ rect: CGRect) {
        let height = rect.size.height
        let width = rect.size.width
        layer.frame.size.height = height - 3
        layer.frame.size.width = width - 6
        layer.frame.origin.x = 3
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 4.0
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        dataTask?.cancel()
        dataTask = nil
    }
    
    func configure(with model: HMTRecommendTableViewModel) 
    {
        dataTask = self.userIconImageView.loadImage(url: NetWorkToolS.getUserIconURL(withAuthorID: model.authorID))
        self.titleLabel.text = model.title;
        self.answerLabel.text = String(format: "%d", Int(model.answerCount)! + 1)
        self.nameLabel.text = model.userName;
        self.timeLabel.text = model.postDate;
        self.contentLabel.attributedText = model.text
    }
}
