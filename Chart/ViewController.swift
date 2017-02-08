//
//  ViewController.swift
//  Chart
//
//  Created by ideapress on 2017/2/7.
//  Copyright © 2017年 ideapress. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON

class ViewController: UIViewController, WKNavigationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let configuration = WKWebViewConfiguration.init()
        
        let webview = WKWebView.init(frame: CGRect.init(x: 0, y: 44, width: view.bounds.size.width, height: view.bounds.size.width), configuration: configuration)
        let indexPath = Bundle.main.path(forResource: "index", ofType: "html")
        webview.loadFileURL(URL.init(fileURLWithPath: indexPath!), allowingReadAccessTo: URL.init(fileURLWithPath: indexPath!))
        
        webview.navigationDelegate = self
        view.addSubview(webview)
        
//        {
//            title: {
//                text: '入门示例'
//            },
//            tooltip: {},
//            legend: {
//                data:['销量']
//            },
//            xAxis: {
//                data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
//            },
//            yAxis: {},
//            series: [{
//            name: '销量',
//            type: 'bar',
//            data: [5, 20, 36, 10, 10, 20]
//            }]
//        };
        
    }
    

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        let options:JSON = [
            "title": [
                "text": "气温变化",
                "subtext": "纯属虚构"
            ],
            "tooltip": [
                "trigger": "axis"
            ],
            "legend": [
                "data": ["最高气温", "最低气温"]
            ],
            "dataZoom": [[          // 这个dataZoom组件，默认控制x轴。
                "type": "inside",   // 这个 dataZoom 组件是 slider 型 dataZoom 组件
                "start": 0, // 左边在 10% 的位置。
                "end": 60   // 右边在 60% 的位置。
            ]],
            "toolbox": [
                "show": false,
            ],
            "xAxis": [
                "type": "category",
                "boundaryGap": false,
                "data": ["周一", "周二", "周三", "周四", "周五", "周六", "周日"]
            ],
            "yAxis": [
                "type": "value",
                "axisLabel": [
                    "formatter": "{value} °C"
                ]
            ],
            "series":
                [[
                    "name": "最高气温",
                    "type": "line",
                    "data": [11, 11, 15, 13, 12, 13, 10],
                ], [
                    "name": "最低气温",
                    "type": "line",
                    "data": [1, -2, 2, 5, 3, 2, 0],
                ]]
        ];

        

        let code = "options =\(options.rawString()!);Chart.setOption(options)"
        
//        print(code)
        
        webView.evaluateJavaScript(code, completionHandler: {(results, error) in
            print(results)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

