//
//  ViewController.swift
//  WebViewSample
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
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen = UIScreen.main.bounds
        
        ///按钮栏
        //按钮栏宽
        let buttonBarWidth: CGFloat = 316
        let buttonBar = UIView(frame: CGRect(x: (screen.size.width - buttonBarWidth) / 2, y: 20, width: buttonBarWidth, height: 30))
        self.view.addSubview(buttonBar)
        
        /// 1.添加LoadHTMLString按钮
        let buttonLoadHTMLString = UIButton(type: UIButtonType.system)
        buttonLoadHTMLString.setTitle("LoadHTMLString", for: UIControlState())
        buttonLoadHTMLString.frame = CGRect(x: 0, y: 0, width: 117, height: 30)
        //指定事件处理方法
        buttonLoadHTMLString.addTarget(self, action: #selector(testLoadHTMLString(_:)), for: .touchUpInside)
        buttonBar.addSubview(buttonLoadHTMLString)
        
        /// 2.添加LoadData按钮
        let buttonLoadData = UIButton(type: UIButtonType.system)
        buttonLoadData.setTitle("LoadData", for: UIControlState())
        buttonLoadData.frame = CGRect(x: 137, y: 0, width: 67, height: 30)
        //指定事件处理方法
        buttonLoadData.addTarget(self, action: #selector(testLoadData(_:)), for: .touchUpInside)
        buttonBar.addSubview(buttonLoadData)
        
        /// 3.添加LoadRequest按钮
        let buttonLoadRequest = UIButton(type: UIButtonType.system)
        buttonLoadRequest.setTitle("LoadRequest", for: UIControlState())
        buttonLoadRequest.frame = CGRect(x: 224, y: 0, width: 92, height: 30)
        //指定事件处理方法
        buttonLoadRequest.addTarget(self, action: #selector(testLoadRequest(_:)), for: .touchUpInside)
        buttonBar.addSubview(buttonLoadRequest)
        
        /// 4.添加WKWebView
        self.webView = WKWebView(frame: CGRect(x: 0, y: 60, width: screen.size.width, height: screen.size.height - 80))
        self.view.addSubview(self.webView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func testLoadHTMLString(_ sender: AnyObject) {
        
        let htmlPath = Bundle.main.path(forResource: "index", ofType: "html")
        let bundleUrl = URL(fileURLWithPath: Bundle.main.bundlePath)
        
        do {
            let html = try NSString(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8.rawValue)
            self.webView.loadHTMLString(html as String, baseURL: bundleUrl)
            
        } catch let err as NSError {
            NSLog("加载失败 error :  %@", err.localizedDescription)
        }
    }
    
    func testLoadData(_ sender: AnyObject) {
        
        let htmlPath = Bundle.main.path(forResource: "index", ofType: "html")
        let bundleUrl = URL(fileURLWithPath: Bundle.main.bundlePath)
        let htmlData = try? Data(contentsOf: URL(fileURLWithPath: htmlPath!))
        
        self.webView.load(htmlData!, mimeType: "text/html", characterEncodingName: "UTF-8", baseURL: bundleUrl)
        
    }
    
    func testLoadRequest(_ sender: AnyObject) {
        let url = URL(string: "http://51work6.com")
        let request = URLRequest(url: url!)
        self.webView.load(request)
        self.webView.navigationDelegate = self
    }
    
    // MARK: --实现WKNavigationDelegate委托协议
    //开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        NSLog("开始加载")
    }
    
    //当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        NSLog("内容开始返回")
    }
    
    //加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        NSLog("加载完成")
    }
    
    //加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        NSLog("加载失败 error :  ", error.localizedDescription)
    }
    
}
