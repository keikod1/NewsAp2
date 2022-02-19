//
//  NewsDetailesController.swift
//  NewsAp
//
//  Created by my macbook on 19/2/22.
//

import Foundation
import SnapKit
import WebKit
import UIKit


class NewsDetailiesController: UIViewController{
    var url: String? = nil

    private lazy var webView: WKWebView = {
        return WKWebView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        webView.load(URLRequest(url: URL(string: url!)!))
    }

}
