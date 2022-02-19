//
//  ViewController.swift
//  NewsAp
//
//  Created by my macbook on 19/2/22.
//

import UIKit
import SnapKit
import SwiftUI

class MainController: UIViewController {
    private lazy var searchField: UITextField = {
        let view = UITextField()
        view.placeholder = "Search"
        return view
    }()
    private lazy var searchButton: UIButton = {
        let view = UIButton()
        view.setTitle("Search", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.addTarget(self, action: #selector(clickSearch(view:)), for: .touchUpInside)
        return view
    }()
    private lazy var newsTable: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        return view
    }()

    private lazy var models: NewsModule? = nil

    @objc func clickSearch(view: UIButton){
        URLSession.shared.dataTask(with: URL(string: "https://newsapi.org/v2/everything?q=\(searchField.text ?? String())&from=2022-01-19&sortBy=publishedAt&apiKey=1f3677b478754e658fa1853ad97bf3d6")!) { data, response, error  in
            self.models = try! JSONDecoder().decode(NewsModule.self, from: data!)

            DispatchQueue.main.async {
                self.newsTable.reloadData()
            }
        }.resume()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tesla News"
        view.addSubview(searchField)
        searchField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(200)
        }
        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-10)
            make.left.equalTo(searchField.snp.right)
        }
        view.addSubview(newsTable)
        newsTable.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(searchField.snp.bottom).offset(10)

        }


    }
}


extension MainController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.articles?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = models?.articles?[indexPath.row].url
        let controller = NewsDetailiesController()
        controller.url = url
        controller.title = models?.articles?[indexPath.row].title
        navigationController?.pushViewController(controller, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewsCell()
        let model = models?.articles?[indexPath.row]

        cell.fill(model: model)

        return cell
    }
}

