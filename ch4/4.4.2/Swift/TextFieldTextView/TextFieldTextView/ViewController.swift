//
//  ViewController.swift
//  TextFieldTextView
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

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen = UIScreen.main.bounds
        
        let textFieldWidth:CGFloat = 223
        let textFieldHeight:CGFloat = 30
        let textFieldTopView:CGFloat = 150
        let textFieldFrame = CGRect(x: (screen.size.width - textFieldWidth)/2,
                                    y: textFieldTopView, width: textFieldWidth, height: textFieldHeight)
        let textField = UITextField(frame: textFieldFrame)
        
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.delegate = self
        
        self.view.addSubview(textField)
        
        //labelName标签与textField之间的距离
        let labelNameTextFieldSpace: CGFloat = 30
        let labelNameFrame = CGRect(x: textField.frame.origin.x,
                                    y: textField.frame.origin.y - labelNameTextFieldSpace,
                                    width: 51, height: 21)
        let labelName = UILabel(frame: labelNameFrame)
        labelName.text = "Name:"
        self.view.addSubview(labelName)
        
        let textViewWidth:CGFloat = 236
        let textViewHeight: CGFloat = 198
        let textViewTopView: CGFloat = 240
        let textViewFrame = CGRect(x: (screen.size.width - textViewWidth)/2,
                                   y: textViewTopView, width: textViewWidth,
                                   height: textViewHeight)
        
        let textView = UITextView(frame: textViewFrame)
        
        textView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        
        textView.delegate = self
        self.view.addSubview(textView)
        
        //labelAbstract标签与textView之间的距离
        let labelAbstractTextViewSpace: CGFloat = 30
        let labelAbstractFrame = CGRect(x: textView.frame.origin.x,
                                        y: textView.frame.origin.y - labelAbstractTextViewSpace, width: 103, height: 21)
        let labelAbstract = UILabel(frame: labelAbstractFrame)
        
        labelAbstract.text = "Abstract:"
        self.view.addSubview(labelAbstract)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 实现UITextFieldDelegate委托协议方法
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField获得焦点，点击return键")
        return true
    }
    
    // MARK: - 实现UITextViewDelegate委托协议方法
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            print("TextView获得焦点，点击return键")
            return false
        }
        return true
    }
    
}

