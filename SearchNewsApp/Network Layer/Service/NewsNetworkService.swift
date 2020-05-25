//
//  NetworkService.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 20.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import Foundation

protocol NetworkService {
	func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void)
	func prepareHeader() -> [String: String]?
	func prepareParaments(searchTerm: String?) -> [String: String]
	func url(params: [String: String]) -> URL
	func createDataTask(from request: URLRequest, completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask
}

class NewsNetworkService: NetworkService {
	
	// построение запроса данных по URL
	func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void)  {
		
		let parameters = self.prepareParaments(searchTerm: searchTerm)
		let url = self.url(params: parameters)
		var request = URLRequest(url: url)
		request.allHTTPHeaderFields = prepareHeader()
		request.httpMethod = "get"
		let task = createDataTask(from: request, completion: completion)
		task.resume()
	}
	
	internal func prepareHeader() -> [String: String]? {
		var headers = [String: String]()
		//        headers["Authorization"] = "Client-ID dc1bcc94279ed5b3be81b9f5b7188d01565f5e9eefad81f9fb9b805daf5dec30"
		return headers
	}
	
	internal func prepareParaments(searchTerm: String?) -> [String: String] {
		var parameters = [String: String]()
		parameters["q"] = searchTerm
		parameters["apiKey"] = "b59bc1f13f884301a259ebc4a7c68af2"
		parameters["pageSize"] = String(50)
		return parameters
	}
	
	internal func url(params: [String: String]) -> URL {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "newsapi.org"
		components.path = "/v2/everything"
		components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
		return components.url!
	}
	
	internal func createDataTask(from request: URLRequest, completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask {
		return URLSession.shared.dataTask(with: request) { (data, response, error) in
			DispatchQueue.main.async {
				completion(data, error)
			}
		}
	}
}
