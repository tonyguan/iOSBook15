//
//  ViewController.swift
//  SearchbarTable
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

class ViewController: UITableViewController , UISearchBarDelegate, UISearchResultsUpdating {
    
    var searchController : UISearchController!
    
    //全部数据
    var listTeams : NSArray!
    //过滤后的数据
    var listFilterTeams : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = Bundle.main.path(forResource: "team", ofType: "plist")
        //获取属性列表文件中的全部数据
        self.listTeams = NSArray(contentsOfFile: plistPath!)
        //查询所有数据
        self.filterContentForSearchText("", scope:-1)
        
        //实例化UISearchController
        self.searchController = UISearchController(searchResultsController: nil)
        //设置self为更新搜索结果对象
        self.searchController.searchResultsUpdater = self
        //在搜索是背景设置为灰色
        self.searchController.dimsBackgroundDuringPresentation = false
        
        //设置搜索范围栏中的按钮
        self.searchController.searchBar.scopeButtonTitles = ["中文", "英文"]
        self.searchController.searchBar.delegate = self
        
        //将搜索栏放到表视图的表头中
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        self.searchController.searchBar.sizeToFit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: --内容过滤方法
    func filterContentForSearchText(_ searchText: NSString, scope: Int) {
        if(searchText.length == 0) {
            //查询所有
            self.listFilterTeams = NSMutableArray(array:self.listTeams)
            return
        }
        var tempArray : NSArray!
        
        if (scope == 0) {       //中文 name字段是中文名
            let scopePredicate = NSPredicate(format:"SELF.name contains[c] %@", searchText)
            tempArray = self.listTeams.filtered(using: scopePredicate) as NSArray!
            self.listFilterTeams = NSMutableArray(array: tempArray)
        } else if (scope == 1) { //英文 image字段保存英文名
            let scopePredicate = NSPredicate(format:"SELF.image contains[c] %@", searchText)
            tempArray = self.listTeams.filtered(using: scopePredicate) as NSArray!
            self.listFilterTeams = NSMutableArray(array: tempArray)
        } else {                //查询所有
            self.listFilterTeams = NSMutableArray(array: self.listTeams)
        }
    }
    
    //MARK: --UITableViewDataSource 协议方法
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listFilterTeams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        let row = (indexPath as NSIndexPath).row
        
        let rowDict = self.listFilterTeams[row] as! NSDictionary
        cell.textLabel?.text = rowDict["name"] as? String
        cell.detailTextLabel?.text = rowDict["image"] as? String
        
        let imagePath = String(format: "%@.png", rowDict["image"] as! String)
        cell.imageView?.image = UIImage(named: imagePath)
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    //MARK: --实现UISearchBarDelegate协议方法
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.updateSearchResults(for: self.searchController)
    }
    
    //MARK: --实现UISearchResultsUpdating协议方法
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        self.filterContentForSearchText(searchString! as NSString, scope: searchController.searchBar.selectedScopeButtonIndex)
        self.tableView.reloadData()
    }
    
}

