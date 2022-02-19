//
//  NewsModule.swift
//  NewsAp
//
//  Created by my macbook on 19/2/22.
//

import Foundation

struct NewsModule: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?

    init(status: String?, totalResults: Int?, articles: [Article]?) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}

// MARK: - Article
class Article: Codable {
    let author: String?
    let title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }

}
