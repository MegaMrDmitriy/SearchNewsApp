//
//  NewsManager.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 18.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import Foundation

class NewsManager {
	
	static let NewsAPIKey = "b59bc1f13f884301a259ebc4a7c68af2"
	
	private let router = Router<NewsEndPoint>()
	
	func getNews(on searchTerm: String, completion: @escaping ([News]?, NetworkError?) -> Void) {
		router.request(.everything(searchTerm: searchTerm)) { (data, response, error) in
			
			if error != nil {
				completion(nil, (error as? NetworkError) ?? NetworkError.failed)
			}
			
			if let response = response as? HTTPURLResponse {
				let result = self.handleNewsResponse(response)
				switch result {
				case .success:
					guard let responseData = data else {
						completion(nil, NetworkError.noData)
						return
					}
					
					do {
						let apiResponse = try JSONDecoder().decode(NewsResponse.self, from: responseData)
						completion(apiResponse.articles, nil)
					} catch {
						print(error)
						completion(nil, NetworkError.unableToDecode)
					}
					
				case .failure(let error):
					completion(nil, error)
				}
			}
		}
	}
	
	private func handleNewsResponse(_ response: HTTPURLResponse) -> ResponseResult {
		switch response.statusCode {
		case 200...299:
			return .success
		case 400:
			return .failure(NetworkError.badRequest)
		case 401:
			return .failure(NetworkError.unauthorized)
		case 429:
			return .failure(NetworkError.tooManyRequests)
		case 500:
			return .failure(NetworkError.serverError)
		default:
			return .failure(NetworkError.failed)
		}
	}
}
