//
//  MasterViewController.swift
//  MyNotes
//
//  Created by 关东升 on 2016-11-18.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

enum ActionTypes {
    case query      //查询操作
    case remove     //删除操作
    case add        //添加操作
    case mod        //修改操作
}


class MasterViewController: UITableViewController {

    //请求动作标识
    var action = ActionTypes.query
    //删除行号
    var deleteRowId = -1

    var detailViewController: DetailViewController? = nil

    //保存数据列表
    var listData = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = self.editButtonItem

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        //查询请求数据
        action = ActionTypes.query
        self.startRequest()
        
        //在导航栏中显示活动指示器
        self.showActivityIndicatorViewInNavigationItem()
    }

    func refreshTableView() {
        
        if (self.refreshControl?.isRefreshing == true) {
            self.refreshControl?.attributedTitle = NSAttributedString(string: "加载中...")
            //查询请求数据
            action = ActionTypes.query
            self.startRequest()
        }
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(true)
//        action = ActionTypes.QUERY
//        self.startRequest()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - 开始请求Web Service
    func startRequest() {

        let strURL = "http://www.51work6.com/service/mynotes/WebService.php"
        var post = ""
        if action == ActionTypes.query {
            //查询处理
            post = String(format: "email=%@&type=%@&action=%@", "<你的51work6.com用户邮箱>", "JSON", "query")
        } else if action == ActionTypes.remove {
            //删除处理
            let dict = self.listData[deleteRowId] as! NSDictionary
            let id = dict.object(forKey: "ID") as! NSNumber
            post = String(format: "email=%@&type=%@&action=%@&id=%@", "<你的51work6.com用户邮箱>", "JSON", "remove", id)
        }
        let postData: Data = post.data(using: String.Encoding.utf8)!

        let url = URL(string: strURL)!

        let mutableURLRequest = NSMutableURLRequest(url: url)
        mutableURLRequest.httpMethod = "POST"
        mutableURLRequest.httpBody = postData
        let request = mutableURLRequest as URLRequest
        
        let defaultConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: defaultConfig, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task: URLSessionDataTask = session.dataTask(with: request, completionHandler:
            { (data, response, error) in
                print("请求完成...")
                if error == nil {
                    do {
                        let resDict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                        
                        if self.action == ActionTypes.query {
                            //查询处理
                            self.reloadView(resDict)
                        } else if self.action == ActionTypes.remove {
                            //删除处理
                            let resultCode: NSNumber = resDict["ResultCode"] as! NSNumber
                            var message = "操作成功。"
                            if (resultCode.intValue < 0) {
                                message = resultCode.errorMessage
                            }
                            
                            let alertController: UIAlertController = UIAlertController(title: "提示信息", message: message, preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(okAction)
                            //显示
                            self.present(alertController, animated: true, completion: nil)
                            
                            //重新查询
                            self.action = ActionTypes.query
                            self.startRequest()
                        }
                        
                    } catch {
                        print("返回数据解析失败")
                    }
                } else {
                    print("error : ", error!.localizedDescription)
                }
        })
        task.resume()

    }


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let dict = self.listData[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = dict as AnyObject?
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let dict = self.listData[indexPath.row] as! NSDictionary
        cell.textLabel!.text = dict["Content"] as? String
        cell.detailTextLabel!.text = dict["CDate"] as? String

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            //删除数据
            action = ActionTypes.remove
            deleteRowId = indexPath.row
            self.startRequest()
        }
    }

    // MARK: -- 重新加载表视图
    func reloadView(_ res: NSDictionary) {

        //停止等待指示器，恢复导航栏
        self.navigationItem.titleView = nil;
        self.navigationItem.prompt = nil;
        
        let resultCode: NSNumber = res["ResultCode"] as! NSNumber
        if (resultCode.intValue >= 0) {
            self.listData = res["Record"] as! NSArray
            self.tableView.reloadData()
        } else {
            let errorStr = resultCode.errorMessage
            let alertController: UIAlertController = UIAlertController(title: "错误信息", message: errorStr, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            //显示
            self.present(alertController, animated: true, completion: nil)

        }
    }
    
    // MARK: -- 在导航栏中显示等待对话框
    func showActivityIndicatorViewInNavigationItem() {
        
        let aiview = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        self.navigationItem.titleView = aiview
        aiview.startAnimating()
        self.navigationItem.prompt = "数据加载中..."
        
    }
}
