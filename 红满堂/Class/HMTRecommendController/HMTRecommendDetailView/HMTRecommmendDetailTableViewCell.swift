//
//  HMTRecommmendDetailTableViewCell.swift
//  红满堂
//
//  Created by Qm on 25/11/2016.
//  Copyright © 2016 欧阳铨. All rights reserved.
//

import UIKit

class HMTRecommendDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var userIconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postIDLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    private var dataTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.white
//        layer.cornerRadius = 10.0
//        layer.masksToBounds = true
//        layer.borderWidth = 1
//        layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor

    }
    
    override func draw(_ rect: CGRect) {
//        let height = rect.size.height
//        let width = rect.size.width
//        let mainLayer = CALayer()
//        layer.cornerRadius = 10.0
//        layer.masksToBounds = true
//        layer.frame.size.height = height - 3
//        layer.frame.size.width = width - 6
//        layer.frame.origin.x = 3
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dataTask?.cancel()
        dataTask = nil
    }
    
    func configure(with model: HMTRecommendDetailTableViewModel, andPostID postID: Int)
    {
        dataTask = self.userIconImageView.loadImage(url: NetWorkToolS.getUserIconURL(withAuthorID: model.authorID))
        postDateLabel.text = model.postDate
        nameLabel.text = model.authorName
        contentLabel.attributedText = model.message
        postIDLabel.text = transferID(fromPostID: postID)
    }
    
    func transferID(fromPostID id: Int) -> String {
        if id == 0 {
            return "楼主"
        } else {
            return String(id+1) + "楼"
        }
    }
}
