//
//  NewsEndPoint.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 20.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import Foundation

enum NewsEndPoint {
	case everything(searchTerm: String)//, pageSize: Int?, page: Int?)
}

extension NewsEndPoint: EndPointType {
	
	var url: URL? {
		return nil
	}
	
	var scheme: String {
		switch self {
		case .everything(_):
			return "https"
		}
	}
	
	var host: String {
		switch self {
		case .everything(_):
			return "newsapi.org"
		}
	}
	
	var path: String {
		switch self {
		case .everything(_)://, _, _):
			return "/v2/everything"
		}
	}
	
	var httpMethod: HTTPMethod {
		return .get
	}
	
	var task: HTTPTask {
		switch self {
		case .everything(let searchTerm)://, let pageSize, let page):
			return .requestURLParameters(urlParameters: prepareParameters(searchTerm: searchTerm))//, pageSize: pageSize, page: page))
		}
	}
	
	var headers: [String : String]? {
		return nil
	}
	
	private func prepareParameters(searchTerm: String, pageSize: Int? = nil, page: Int? = nil) -> [String: Any]? {
		var parameters = [String: Any]()
		parameters["q"] = searchTerm
		parameters["pageSize"] = pageSize ?? 50
		parameters["page"] = page ?? 1
		parameters["apiKey"] = NewsManager.NewsAPIKey
		return parameters
	}
}
