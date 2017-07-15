//
//  HMTRecommendViewController.swift
//  红满堂
//
//  Created by Jacko Qm on 23/01/2017.
//  Copyright © 2017 欧阳铨. All rights reserved.
//

import UIKit
import CoreData

class HMTRecommendViewController: UIViewController {
    
    // MARK: - Private Properties
    private var scrollView: UIScrollView!
    private var isFirstTime = true
    private var managedContext: NSManagedObjectContext!
    private var savedModels: [HMTRecommendTableViewModel]!
    
    // MARK: Properties
    fileprivate var tableView: UITableView!
    fileprivate var currentOffset: CGFloat = 0.0
    fileprivate var currentPage = 1
    fileprivate var hasMoreData = true
    
    fileprivate var tableHeaderView: QMRefreshHeader?
    fileprivate var tableFooterView: QMRefreshFooter?
    
    fileprivate var tableViewModels = [HMTRecommendTableViewModel]() {
        didSet {
             if !tableViewModels.isEmpty {
                tableView.reloadData()
                
                if tableHeaderView!.isRefreshing() {
                    tableHeaderView!.endRefreshing(didRefreshed: true)
                    savePosts()
                }
                if tableView.tableFooterView == nil {
                    tableFooterView = QMRefreshFooter.getPullRefreshView {
                        [unowned strongSelf = self] in
                        strongSelf.currentPage += 1
                        strongSelf.configureRecommendModels()
                    }
                    tableView.tableFooterView = tableFooterView
                    tableView.frameHeight += tableFooterView!.frameHeight
                    
                    tableView.scrollIndicatorInsets = UIEdgeInsets(top: tableHeaderView!.frameHeight, left: 0.0, bottom: tableFooterView!.frameHeight, right: 0.0)
                } else {
                    tableFooterView!.endRefreshing(hasMoreData: hasMoreData)
                }
            }
        }
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        
        view.addSubview(tableView)
        
        tableHeaderView = QMRefreshHeader.getRefreshHeader() { [unowned strongSelf = self] in
            strongSelf.reload()
        }
        tableView.tableHeaderView = tableHeaderView
        tableView.frameHeight += tableView.tableHeaderView!.frame.height - 44 //弥补掉Header过长的部分，防止底部有空白
        tableView.frameY -= tableView.tableHeaderView!.frame.height
        
        if let appDelegate = (UIApplication.shared.delegate) as? AppDelegate {
            managedContext = appDelegate.managedObjectContext
        } else {
            print("Qm: Could not get NSManagedObjectContext")
        }
        savedModels = fetchPosts()
//        print("Qm: \(Constants.userDefaultImage == UIImage(named: "userDefault"))")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isFirstTime {
            if !savedModels.isEmpty {
                tableViewModels = savedModels
            }
            isFirstTime = false
            tableHeaderView!.beginRefreshing()
        }
    }
    
    // MARK: - Private Methods
    private func initTableView()
    {
        tableView = UITableView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: screenWidth, height: screenHeight)), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.rbgColor(red: 248, green: 248, blue: 248)
        
        tableView.register(UINib(nibName: Constants.Identifier.HMTTableViewCell, bundle: .main), forCellReuseIdentifier: Constants.Identifier.HMTTableViewCell)
        tableView.register(UINib(nibName: Constants.Identifier.HMTLoadingCell, bundle: .main), forCellReuseIdentifier: Constants.Identifier.HMTLoadingCell)
        tableView.register(UINib(nibName: Constants.Identifier.HMTScrollViewCell, bundle: .main), forCellReuseIdentifier: Constants.Identifier.HMTScrollViewCell)
        
    }
    
    fileprivate func reload()
    {
        currentPage = 1
        configureRecommendModels()
    }
    
    private func initScrollView()
    {
        scrollView = UIScrollView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: screenWidth, height: 44)))
        scrollView.backgroundColor = UIColor.black
    }
    
    private func savePosts()
    {
        //保存前先清空之前保存的内容
        let request = NSFetchRequest<RecommendPost>(entityName: "RecommendPost")
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        do {
            let results = try managedContext!.fetch(request)
            for result in results {
                managedContext!.delete(result)
            }
        } catch let error as NSError {
            print("Qm: Could not fetch! Error: \(error), \(error.userInfo)")
        }
        
        var num: Int16 = 0 //用于排序的序号
        
        for model in tableViewModels {
            let entity = NSEntityDescription.entity(forEntityName: "RecommendPost", in: managedContext!)!
            let post = RecommendPost(entity: entity, insertInto: managedContext)
            
            post.title = model.title
            post.answerCount = model.answerCount
            post.postDate = model.postDate
            post.lastEdit = model.lastEdit
            post.previewText = model.content
            post.threadID = model.threadID
            post.userName = model.userName
            post.authorID = model.authorID
            post.serialNum = num
            num += 1
        }
        
        do {
            try managedContext!.save()
        } catch let error as NSError {
            print("Could not save! Error: \(error), \(error.userInfo)")
        }
    }
    
    private func fetchPosts() -> [HMTRecommendTableViewModel]
    {
        let request = NSFetchRequest<RecommendPost>(entityName: "RecommendPost")
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        request.sortDescriptors = [NSSortDescriptor(key: "serialNum", ascending: true)]
        
        do {
            guard (try! managedContext!.count(for: request)) > 0 else {
                return []
            }
            let results = try managedContext!.fetch(request)
            var models = [HMTRecommendTableViewModel]()
            for result in results {
                let model = HMTRecommendTableViewModel()
                model.answerCount = result.answerCount
                model.authorID = result.authorID
                model._postDate = result.postDate
                model.lastEdit = result.lastEdit
                model.content = result.previewText
                model.threadID = result.threadID
                model.title = result.title
                model.userName = result.userName
                
                models.append(model)
                managedContext!.delete(result)
            }
            
            return models
        } catch let error as NSError {
            print("Could not fetch! Error: \(error), \(error.userInfo)")
            return []
        }
    }
    
}

// MARK: - Implement for tableView
extension HMTRecommendViewController
{
    
    fileprivate func configureRecommendModels()
    {
        let url = NetWorkToolS.getRecommendURL(withPages: currentPage, andLimit: Constants.NumberOfPostToFetch)
        
        print("Qm: url: \(url)")
        NetWorkToolS.parseJsonDictionary(from: url) {
            [weak weakSelf = self] jsonDict, _, _ in
            if let strongSelf = weakSelf {
                //如果jsDict为nil可以判断网络异常了
                guard let jsDict = jsonDict else {
                    DispatchQueue.main.async {
                        strongSelf.tableHeaderView!.endRefreshing(didRefreshed: false)
                        strongSelf.tableFooterView!.endRefreshing(hasMoreData: strongSelf.hasMoreData)
                    }
                    return
                }
                let result = strongSelf.parse(dictinary: jsDict)
                strongSelf.hasMoreData = (result.count == Constants.NumberOfPostToFetch)
                DispatchQueue.main.async {
                    if strongSelf.tableViewModels.isEmpty || strongSelf.tableHeaderView!.isRefreshing() {
                        strongSelf.tableViewModels = result
                    } else {
                        strongSelf.tableViewModels.append(contentsOf: result)
                    }
                    
                }
            }
        }
    }
    
    private func parse(dictinary: [String: Any]) -> [HMTRecommendTableViewModel] {
        guard let array = dictinary["threads"] as? [Any] else {
            print("Expected 'result' array")
            return []
        }
        
        var models: [HMTRecommendTableViewModel] = []
        
        for resultDict in array {
            if let resultDict = resultDict as? [String: Any] {
                let model = HMTRecommendTableViewModel()
                model.postDate = resultDict["dateline"] as! String
                model.title = resultDict["subject"] as! String
                model.answerCount = resultDict["replies"] as! String
                let text = resultDict["message"] as! String
                model.text = NSMutableAttributedString(string: text)
                model.userName = resultDict["author"] as! String
                model.authorID = resultDict["authorid"] as! String
                model.threadID = resultDict["tid"] as! String
                models.append(model)
            }
        }
        return models
    }
}

// MARK: - Implement of UITableViewDelegate
extension HMTRecommendViewController: UITableViewDelegate
{
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        let offset = scrollView.contentOffset.y
//        //print("Qm: \(offset)")
//        let maxOffset =  scrollView.contentSize.height - scrollView.frame.size.height
//        guard abs(currentOffset - offset) > 30 else {
//            return
//        }
//        //print("Qm: \(maxOffset)")
//        let nav = HMTTool.getPushNavigation()!
//        let view = nav.topViewController!
//        let navigationController = view.navigationController!
//        
//        if offset >= 60 && navigationController.isNavigationBarHidden == false {
//            navigationController.setNavigationBarHidden(true, animated: true)
//        }
//        if offset <= self.currentOffset && offset < maxOffset && navigationController.isNavigationBarHidden {//往上滑
//            navigationController.setNavigationBarHidden(false, animated: true)
//        }
//        self.currentOffset = offset
//    }
	
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            //测试代码
            (tableView.cellForRow(at: indexPath) as! HMTScrollViewCell).configure()
        }
        pushViewController(with: self.tableViewModels[indexPath.row])
    }
    
    
    private func pushViewController(with model: HMTRecommendTableViewModel) {
        let detailViewController = HMTRecommendDetailViewController()
        detailViewController.threadID = model.threadID
        let baseNavigationController = HMTTool.getPushNavigation()!
        HMTTool.setBaseNavigationBarHidden(false, animated: true)
        baseNavigationController.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        }
        return UITableViewAutomaticDimension
    }
}

// MARK: - Implement of UITableViewDataSource
extension HMTRecommendViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.HMTScrollViewCell, for: indexPath) as! HMTScrollViewCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.HMTTableViewCell, for:indexPath) as! HMTRecommendCell
        cell.configure(with: self.tableViewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return tableViewModels.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}

