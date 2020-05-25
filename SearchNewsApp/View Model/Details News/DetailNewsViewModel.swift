//
//  DetailNewsViewModel.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 18.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import Foundation

class DetailNewsViewModel {
	
	var title: String
	var newsDescription: String
	var date: String
	var url: String
	var imageUrl: String?
	
	init(news: News) {
		title = news.title
		newsDescription = news.description
		url = news.url
		imageUrl = news.urlToImage
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "YYYY-MM-dd hh:mm"
		dateFormatter.locale = .current
		date = dateFormatter.string(from: news.publishedAt)
	}
}
