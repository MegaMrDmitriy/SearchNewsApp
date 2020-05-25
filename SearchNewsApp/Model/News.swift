//
//  News.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 18.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import Foundation

struct NewsResponse: Codable {
	var status: String
	var totalResults: Int
	var articles: [News]
}

struct News {
	var title: String
	var urlToImage: String?
	var description: String
	var url: String
	var publishedAt: Date
	
	var isViewed: Bool
}

extension News: Codable {
	private enum NewsCodingKeys: String, CodingKey {
		case title
		case urlToImage
		case description
		case url
		case publishedAt
	}
	
	init(from decoder: Decoder) throws {
		let conteiner = try decoder.container(keyedBy: NewsCodingKeys.self)
		
		title = try conteiner.decode(String.self, forKey: .title)
		urlToImage = try? conteiner.decode(String.self, forKey: .urlToImage)
		description = try conteiner.decode(String.self, forKey: .description)
		url = try conteiner.decode(String.self, forKey: .url)
		
		let publishedAt = try conteiner.decode(String.self, forKey: .publishedAt)
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ssZ"
		self.publishedAt = dateFormatter.date(from: publishedAt) ?? Date()
		isViewed = false
	}
}
