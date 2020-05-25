//
//  NewsCellViewModel.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 18.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import Foundation

class NewsCellViewModel {
	
	let title: String
	let imageUrl: String?
	let isViewed: Bool
	
	init(news: News) {
		title = news.title
		imageUrl = news.urlToImage
		isViewed = news.isViewed
	}
}
