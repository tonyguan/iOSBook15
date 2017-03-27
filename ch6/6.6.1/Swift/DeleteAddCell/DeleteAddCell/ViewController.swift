//
//  ViewController.swift
//  DeleteAddCell
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

class ViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet var txtField: UITextField!
    
    var listTeams : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置导航栏
        self.navigationItem.rightBarButtonItem =  self.editButtonItem
        self.navigationItem.title = "单元格插入和删除"
        
        //设置单元格文本框
        self.txtField.isHidden = true
        self.txtField.delegate = self
        
        self.listTeams = NSMutableArray(array: ["黑龙江", "吉林", "辽宁"])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: --UIViewController生命周期方法，用于响应视图编辑状态变化
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: true)
        if editing {
            self.txtField.isHidden = false
        } else {
            self.txtField.isHidden = true
        }
    }
    
    //MARK: --实现数据源方法
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listTeams.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CellIdentifier"
        
        let b_addCell = ((indexPath as NSIndexPath).row == self.listTeams.count)
        
        let cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if (!b_addCell) {
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = self.listTeams[(indexPath as NSIndexPath).row] as? String
        } else {
            self.txtField.frame = CGRect(x: 40,y: 0,width: 300,height: cell.frame.size.height)
            self.txtField.borderStyle = .none
            self.txtField.placeholder = "Add..."
            self.txtField.text = ""
            cell.addSubview(self.txtField)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let indexPaths = [indexPath]
        
        if (editingStyle == .delete) {
            self.listTeams.removeObject(at: (indexPath as NSIndexPath).row)
            self.tableView.deleteRows(at: indexPaths, with: .fade)
        } else if (editingStyle == .insert) {
            self.listTeams.insert(self.txtField.text! , at: self.listTeams.count)
            self.tableView.insertRows(at: indexPaths, with: .fade)
        }
        self.tableView.reloadData()
    }
    
    //MARK: --实现委托协议方法
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if ((indexPath as NSIndexPath).row == self.listTeams.count) {
            return .insert
        } else {
            return .delete
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if ((indexPath as NSIndexPath).row == self.listTeams.count) {
            return false
        } else {
            return true
        }
    }
    
    //MARK: --UITextFieldDelegate委托方法,关闭键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

