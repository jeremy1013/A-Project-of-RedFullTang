//
//  HMTRecommendDetailViewController.swift
//  红满堂
//
//  Created by Qm on 23/11/2016.
//  Copyright © 2016 欧阳铨. All rights reserved.
//

import UIKit

class HMTRecommendDetailViewController: UIViewController {
    @IBOutlet fileprivate weak var detailTableView: UITableView!
    
    var threadID: String! {
        get {
            return String(_threadID)
        }
        set {
            _threadID = Int(newValue)!
        }
    }
    private var _threadID: Int!
    private var hasMoreData: Bool = true
    private var tableFooterView: QMRefreshFooter?
    
    fileprivate var models = [HMTRecommendDetailTableViewModel]() {
        didSet {
            if isFristTime && !models.isEmpty {
                //第一次加载数据后将LoadingCell移除，并将rowHeight变回自动调整高度
                detailTableView.rowHeight = UITableViewAutomaticDimension
                detailTableView.estimatedRowHeight = 150
                detailTableView.isScrollEnabled = true
                isFristTime = false
                detailTableView.reloadData()
                
                tableFooterView = QMRefreshFooter.getPullRefreshView() {
                    [unowned strongSelf = self] in
                    strongSelf.currentPage += 1
                    strongSelf.fetchDetailData(withPage: strongSelf.currentPage)
                }
                detailTableView.tableFooterView = tableFooterView
                let footerViewHeight = detailTableView.tableFooterView!.frameHeight
                detailTableView.frameHeight += footerViewHeight
                detailTableView.scrollIndicatorInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: footerViewHeight, right: 0.0)
            } else {
                detailTableView.reloadData()
                tableFooterView?.endRefreshing(hasMoreData: hasMoreData)
            }
        }
    }
    fileprivate var currentPage = 1 //number parameter for fetch data
    
    fileprivate var isFristTime = true
    
    deinit {
        print("Qm: deinit \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cellNib = UINib(nibName: Constants.Identifier.HMTDetailCell, bundle: nil)
        detailTableView.register(cellNib, forCellReuseIdentifier: Constants.Identifier.HMTDetailCell)
        cellNib = UINib(nibName: Constants.Identifier.HMTLoadingCell, bundle: nil)
        detailTableView.register(cellNib, forCellReuseIdentifier: Constants.Identifier.HMTLoadingCell)
        
        detailTableView.contentInset = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 0)
        detailTableView.rowHeight = screenHeight
        detailTableView.backgroundColor = UIColor.rbgColor(red: 248, green: 248, blue: 248)
        detailTableView.isScrollEnabled = false
        
        fetchDetailData(withPage: currentPage)    }
    
    fileprivate func fetchDetailData(withPage page: Int)
    {
        let detailURL = NetWorkToolS.getRecommendDetailURL(withThreadID: _threadID, pages: page, andLimit: Constants.NumberOfPostToFetch)
        NetWorkToolS.parseJsonDictionary(from: detailURL) { [weak weakSelf = self] jsonDict, response, error in
            if let strongSelf = weakSelf {
                guard let jsonDict = jsonDict else {
                    DispatchQueue.main.async {
                        strongSelf.connectFailure()
                    }
                    return
                }
                let result = strongSelf.parse(dictinary: jsonDict)
                strongSelf.hasMoreData = (result.count == Constants.NumberOfPostToFetch)
                
                DispatchQueue.main.async {
                    if strongSelf.models.isEmpty {
                        strongSelf.models = result
                    } else {
                        strongSelf.models.append(contentsOf: result)
                    }
                }
            }
        }
    }
    
    var tapGesture: UITapGestureRecognizer?
    
    private func connectFailure()
    {
        //开始加载时网络异常处理方法
        if let cell = detailTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? HMTLoadingTableViewCell {
            cell.loadDidFail()
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler(sender:)))
            cell.addGestureRecognizer(tapGesture!)
            detailTableView.reloadData()
        } else { //上拉加载时网络异常处理方法
            tableFooterView?.endRefreshing(hasMoreData: hasMoreData)
        }
    }
    
    private func parse(dictinary: [String: Any]) -> [HMTRecommendDetailTableViewModel] {
        guard let array = dictinary["posts"] as? [Any] else {
            return []
        }
        
        var models: [HMTRecommendDetailTableViewModel] = []
        
        for resultDict in array {
            if let resultDict = resultDict as? [String: Any] {
                let model = HMTRecommendDetailTableViewModel()
                model.postDate = resultDict["dateline"] as! String
                model.title = resultDict["subject"] as? String
                model.authorName = resultDict["author"] as! String
                model.authorID = resultDict["authorid"] as! String
                let text = resultDict["message"] as! String
                model.message = NSMutableAttributedString(string: text)
                
                models.append(model)
            }
        }
        return models
    }
    
    @objc
    private func reload()
    {
        detailTableView.isScrollEnabled = false
        models = []
        currentPage = 1
        fetchDetailData(withPage: currentPage)
    }
    
    @objc
    private func tapGestureHandler(sender: UITapGestureRecognizer)
    {
        if sender.state == .ended {
            reload()
        }
        if let cell = sender.view as? HMTLoadingTableViewCell {
            cell.removeGestureRecognizer(sender)
            cell.startLoading()
            detailTableView.reloadData()
        }
    }
}

// Implement of UITableViewDelegate
extension HMTRecommendDetailViewController: UITableViewDelegate 
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// Implement of UITableViewDataSource
extension HMTRecommendDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFristTime {
            return 1
        }
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFristTime {
            return (tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.HMTLoadingCell, for: indexPath) as! HMTLoadingTableViewCell)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.HMTDetailCell, for: indexPath) as! HMTRecommendDetailTableViewCell
        cell.configure(with: models[indexPath.row], andPostID: indexPath.row)
        
        return cell
    }
}
