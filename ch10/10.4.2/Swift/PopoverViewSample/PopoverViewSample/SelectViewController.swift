//
//  SelectViewController.swift
//  PopoverViewSample
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

class SelectViewController: UITableViewController {
    
    var listData: NSArray!
    var lastIndexPath: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.listData = ["红色", "蓝色", "黄色"]
        self.preferredContentSize = CGSize(width: 200, height: 140)
        self.tableView.isScrollEnabled = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: --UITableViewDataSource 协议方法
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let CellIdentifier = "Cell"
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: CellIdentifier)
        }
        
        cell.textLabel?.text = self.listData[indexPath.row] as? String

        return cell
    }
    
    // MARK: --UITableViewDelegate 协议方法
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newRow = indexPath.row
        
        let oldRow = (self.lastIndexPath != nil) ? self.lastIndexPath.row : -1
        
        if (newRow != oldRow) {
            let newCell = tableView.cellForRow(at: indexPath)
            newCell!.accessoryType = .checkmark
            
            if self.lastIndexPath != nil {
                let oldCell = tableView.cellForRow(at: self.lastIndexPath)
                oldCell!.accessoryType = .none
            }
            
            self.lastIndexPath = indexPath
        }
    }

}
