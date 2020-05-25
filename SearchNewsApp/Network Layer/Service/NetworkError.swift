//
//  NetworkError.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 20.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import Foundation

enum NetworkError: Error {
	case badRequest
	case unauthorized
	case tooManyRequests
	case serverError
	case failed
	case noData
	case unableToDecode
	case unableToMakeURL
	
	var localizedDescription: String {
		switch self {
		case .badRequest:
			return "Bad request"
		case .unauthorized:
			return "Unauthorized"
		case .tooManyRequests:
			return "Too Many Requests"
		case .serverError:
			return "Server Error"
		case .failed:
			return "Request failed"
		case .noData:
			return "No data"
		case .unableToDecode:
			return "Unable to decode"
		case .unableToMakeURL:
			return "Unable to make URL"
		}
	}
}
