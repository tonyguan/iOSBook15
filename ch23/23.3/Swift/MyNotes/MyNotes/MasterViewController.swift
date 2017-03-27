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

class MasterViewController: UITableViewController, NotesURLConnectionDelegate {
    
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
        
        let conn = NotesURLConnection()
        conn.delegate = self
        //开始查询
        conn.findAll()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    // MARK: --查询所有数据方法 成功
    func findAllFinished(_ res : NSDictionary) {
        
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
    
    //MARK: --查询所有数据方法 失败
    func findAllFailed(_ error: NSError) {
        NSLog("error : %@", error.localizedDescription)
    }
}
