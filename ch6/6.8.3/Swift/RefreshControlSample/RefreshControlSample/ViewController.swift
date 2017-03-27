//
//  ViewController.swift
//  RefreshControlSample
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

class ViewController: UITableViewController {
    
    var Logs : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化变量和时间
        self.Logs = NSMutableArray()
        let date = Date()
        self.Logs.add(date)
        
        //初始化UIRefreshControl
        let rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "下拉刷新")
        rc.addTarget(self, action: #selector(refreshTableView), for: UIControlEvents.valueChanged)
        self.refreshControl = rc
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func refreshTableView() {
        
        if (self.refreshControl?.isRefreshing == true) {
            self.refreshControl?.attributedTitle = NSAttributedString(string: "加载中...")
            //添加新的模拟数据
            let date = Date()
            self.Logs.add(date)
            
            self.refreshControl?.endRefreshing()
            self.refreshControl?.attributedTitle = NSAttributedString(string: "下拉刷新")
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: --UITableViewDataSource 协议方法
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Logs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CellIdentifier"
        let cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        
        let theDate = self.Logs[(indexPath as NSIndexPath).row] as! Date
        cell.textLabel?.text = dateFormatter.string(from: theDate)
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }

}

