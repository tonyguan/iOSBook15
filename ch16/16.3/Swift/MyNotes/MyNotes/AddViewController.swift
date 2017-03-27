//
//  AddViewController.swift
//  PresentationLayer
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

class AddViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var txtView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func onclickCancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func onclickSave(_ sender: AnyObject) {
        self.txtView.resignFirstResponder()
        self.startRequest()
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    //MARK: - 开始请求Web Service
    func startRequest() {

        //准备参数
        let date = Date()
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFormatter.string(from: date)

        //设置参数
        let post = NSString(format: "email=%@&type=%@&action=%@&date=%@&content=%@", "<你的51work6.com用户邮箱>", "JSON", "add", dateStr, self.txtView.text)
        let postData: Data = post.data(using: String.Encoding.utf8.rawValue)!

        let strURL = "http://www.51work6.com/service/mynotes/WebService.php"
        let url = URL(string: strURL)!

        let mutableURLrequest = NSMutableURLRequest(url: url)
        mutableURLrequest.httpMethod = "POST"
        mutableURLrequest.httpBody = postData
        let request =  mutableURLrequest as URLRequest

        let defaultConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: defaultConfig, delegate: nil, delegateQueue: OperationQueue.main)

        let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            NSLog("请求完成...")
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
                    NSLog("返回数据解析失败")
                }

            } else {
                NSLog("error : %@", error!.localizedDescription)
            }
        })
        task.resume()
    }
}
