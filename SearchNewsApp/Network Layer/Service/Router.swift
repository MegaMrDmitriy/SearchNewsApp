//
//  Router.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 20.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import Foundation

protocol NetworkRouter: class {
	associatedtype EndPoint: EndPointType
	func request(_ route: EndPoint, completion: @escaping (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> Void)
	func cancel()
}

class Router<EndPoint: EndPointType>: NetworkRouter {
	
	private var task: URLSessionTask?
	
	func request(_ route: EndPoint, completion: @escaping (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> Void) {
		let session = URLSession.shared
		do {
			let request = try buildRequest(from: route)
			task = session.dataTask(with: request, completionHandler: { (data, response, error) in
				DispatchQueue.main.async {
					completion(data, response, error)
				}
			})
		} catch {
			completion(nil, nil, error)
		}
		task?.resume()
	}
	
	func cancel() {
		task?.cancel()
	}
	
	private func buildRequest(from route: EndPoint) throws -> URLRequest {
		
		var requestURL: URL!
		
		if let url = route.url {
			requestURL = url
		} else {
			var urlComponents = URLComponents()
			urlComponents.scheme = route.scheme
			urlComponents.host = route.host
			urlComponents.path = route.path
			
			switch route.task {
			case .request:
				break
			case .requestURLParameters(let urlParameters):
				if let urlParameters = urlParameters {
					urlComponents.queryItems = urlParameters.map { URLQueryItem(name: $0, value: "\($1)")}
				}
			case .download:
				break
			}
			
			guard let url = urlComponents.url else { throw NetworkError.unableToMakeURL }
			requestURL = url
		}
		var request = URLRequest(url: requestURL)
		request.httpMethod = route.httpMethod.rawValue
		
		return request
	}
}
