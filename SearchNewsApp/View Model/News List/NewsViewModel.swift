//
//  NewsViewModel.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 18.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import Foundation

class NewsViewModel {
	
	private weak var newsManager: NewsManager!
	private var cellViewModels = [NewsCellViewModel]()
	private var newsList = [News]()
	private var detailsNewsViewModel: DetailNewsViewModel!
	
	private var networkError: NetworkError?
	
	func getNews(on word: String, completion: @escaping (_ isSuccessed: Bool) -> Void) {
		cellViewModels.removeAll()
		networkError = nil
		
		newsManager.getNews(on: word) { [weak self] (newsList, error)  in
			guard let self = self else { return }
			if error != nil {
				self.networkError = error
				completion(false)
			} else {
				self.newsList = newsList ?? []
				for news in self.newsList {
					self.cellViewModels.append(NewsCellViewModel(news: news))
				}
				completion(true)
			}
		}
	}
	
	func cleanNews(completion: () -> Void) {
		cellViewModels.removeAll()
		newsList.removeAll()
		completion()
	}
	
	func numberOfRows() -> Int {
		return cellViewModels.count
	}
	
	func cellViewModel(index: Int) -> NewsCellViewModel? {
		if index > cellViewModels.count {
			return nil
		}
		return cellViewModels[index]
	}
	
	func detailsViewModel(index: Int) -> DetailNewsViewModel {
		newsList[index].isViewed = true
		cellViewModels[index] = NewsCellViewModel(news: newsList[index])
		detailsNewsViewModel = DetailNewsViewModel(news: newsList[index])
		return detailsNewsViewModel
	}
	
	func getError() -> String {
		guard let error = networkError else { return "" }
		return error.localizedDescription
	}
	
	init(newsManager: NewsManager) {
		self.newsManager = newsManager
	}
}
