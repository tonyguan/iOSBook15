//
//  NotesXMLParser.swift
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

import Foundation

class NotesXMLParser: NSObject, XMLParserDelegate {

    //解析出的数据内部是字典类型
    private var listData: NSMutableArray!

    //当前标签的名字
    private var currentTagName: String!

    //开始解析
    func start() {

        let path = Bundle.main.path(forResource: "Notes", ofType: "xml")!
        let url = URL(fileURLWithPath: path)

        //开始解析XML
        let parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()

    }

    // MARK: --实现NSXMLParserDelegate委托方法
    //文档开始的时候触发
    func parserDidStartDocument(_ parser: XMLParser) {
        self.listData = NSMutableArray()
    }

    //文档出错的时候触发
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
    }

    //遇到一个开始标签时候触发
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String:String]) {

        self.currentTagName = elementName
        if self.currentTagName == "Note" {
            let id = attributeDict["id"]
            let dict = NSMutableDictionary()
            dict["id"] = id
            self.listData.add(dict)
        }

    }

    //遇到字符串时候触发
    func parser(_ parser: XMLParser, foundCharacters string: String) {

        //替换回车符和空格
        let s1 = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if s1 == "" {
            return
        }

        let dict = self.listData.lastObject as! NSMutableDictionary
        if (self.currentTagName == "CDate") {
            dict["CDate"] = string
        }

        if (self.currentTagName == "Content") {
            dict["Content"] = string
        }

        if (self.currentTagName == "UserID") {
            dict["UserID"] = string
        }
    }


    //遇到结束标签时候出发
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.currentTagName = nil
    }

    //遇到文档结束时候触发
    func parserDidEndDocument(_ parser: XMLParser) {
        print("NSXML解析完成...")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadViewNotification"), object: self.listData)
    }

}
