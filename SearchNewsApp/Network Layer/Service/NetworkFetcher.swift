//
//  NetworkFetcher.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 20.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
	
	var networkService = NewsNetworkService()
	
	func fetchNews(searchTerm: String, completion: @escaping (NewsResponse?) -> ()) {
		networkService.request(searchTerm: searchTerm) { (data, error) in
			if let error = error {
				print("Error received requesting data: \(error.localizedDescription)")
				completion(nil)
			}
			
			let decode = self.decodeJSON(type: NewsResponse.self, from: data)
			completion(decode)
		}
	}
	
	private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
		let decoder = JSONDecoder()
		guard let data = from else { return nil }
		
		do {
			let objects = try decoder.decode(type.self, from: data)
			return objects
		} catch let jsonError {
			print("Failed to decode JSON", jsonError)
			return nil
		}
	}
	
	
}
