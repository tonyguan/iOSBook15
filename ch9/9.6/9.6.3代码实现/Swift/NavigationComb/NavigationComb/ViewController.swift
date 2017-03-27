//
//  ViewController.swift
//  NavigationComb
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

    var dictData: NSDictionary!
    var listData: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = Bundle.main.path(forResource: "provinces_cities", ofType: "plist")
        
        self.dictData = NSDictionary(contentsOfFile: plistPath!)
        let navigationController = self.parent as! UINavigationController
        let selectProvinces = navigationController.tabBarItem.title!
        
        print(selectProvinces)
        
        if (selectProvinces == "黑龙江") {
            self.listData = self.dictData["黑龙江省"] as! NSArray
            self.navigationItem.title = "黑龙江省信息"
        } else if (selectProvinces == "吉林") {
            self.listData = self.dictData["吉林省"] as! NSArray
            self.navigationItem.title = "吉林省信息"
        } else {
            self.listData = self.dictData["辽宁省"] as! NSArray
            self.navigationItem.title = "辽宁省信息"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: --实现表视图数据源方法
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CellIdentifier"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:cellIdentifier)
        }
        
        let row = indexPath.row
        let dict = self.listData[row] as! NSDictionary
        
        cell.textLabel?.text = dict["name"] as? String
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    //MARK: --实现表视图委托方法
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedIndex = indexPath.row
        let dict = self.listData[selectedIndex] as! NSDictionary
        
        let detailViewController = DetailViewController()
        detailViewController.url = dict["url"] as! String
        detailViewController.title = dict["name"] as? String
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }

}

