//
//  ViewController.swift
//  IndexTable
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

    //从team_dictionary.plist文件中读取出来的数据
    var dictData : NSDictionary!
    //小组名集合
    var listGroupname : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = Bundle.main.path(forResource: "team_dictionary", ofType: "plist")
        //获取属性列表文件中的全部数据
        self.dictData = NSDictionary(contentsOfFile: plistPath!)
        
        let tempList  = self.dictData.allKeys as! [String]
        //对key进行排序
        self.listGroupname = tempList.sorted(by: <) as NSArray!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: --实现数据源协议方法
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //按照节索引从小组名数组中获得组名
        let groupName = self.listGroupname[section] as! String
        //将组名作为key，从字典中取出球队数组集合
        let listTeams = self.dictData[groupName] as! NSArray
        
        return listTeams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CellIdentifier"
        
        let cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        //获得选择的节
        let section = (indexPath as NSIndexPath).section
        //获得选择节中选中的行索引
        let row = (indexPath as NSIndexPath).row
        //按照节索引从小组名数组中获得组名
        let groupName = self.listGroupname[section] as! String
        //将组名作为key，从字典中取出球队数组集合
        let listTeams = self.dictData[groupName] as! NSArray
        
        cell.textLabel?.text = listTeams[row] as? String
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.listGroupname.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let groupName = self.listGroupname[section] as! String
        return groupName
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var listTitles = [String]()
        //把 A组 改为 A
        for item in self.listGroupname {
            let title = (item as AnyObject).substring(to: 1) as String
            listTitles.append(title)
        }
        return listTitles
    }

}

