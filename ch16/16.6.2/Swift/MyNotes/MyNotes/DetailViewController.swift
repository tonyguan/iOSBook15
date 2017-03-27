//
//  DetailViewController.swift
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

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var txtView: UITextView!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {

        if let detail = self.detailItem as? NSDictionary {
            if self.txtView != nil {
                self.txtView.text = detail["Content"] as! String
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        self.txtView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onclickSave(_ sender: AnyObject) {
        self.startRequest()
        self.txtView.resignFirstResponder()        
    }

    func textView(_ textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    // MARK: --开始请求Web Service
    func startRequest() {
        //准备参数
        let date = Date()
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFormatter.string(from: date)
        
        let dict = self.detailItem as! NSDictionary
        let id = dict["ID"] as! NSNumber
        
        //设置参数
        let post = NSString(format: "email=%@&type=%@&action=%@&date=%@&content=%@&id=%@", "<你的51work6.com用户邮箱>", "JSON", "modify", dateStr, self.txtView.text, id)
        let postData: Data = post.data(using: String.Encoding.utf8.rawValue)!
        
        let strURL = "http://www.51work6.com/service/mynotes/WebService.php"
        
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
                        
                    } catch {
                        print("返回数据解析失败")
                    }
                    
                } else {
                    print("error : ", error!.localizedDescription)
                }
        })
        
        task.resume()
    }
}

