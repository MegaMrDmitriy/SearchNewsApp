//
//  ImageEndPoint.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 20.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import Foundation

enum ImageEndPoint {
	case downloadImage(urlString: String)
}

extension ImageEndPoint: EndPointType {
	
	var url: URL? {
		switch self {
		case .downloadImage(let urlString):
			return URL(string: urlString)
		}
	}
	
	var scheme: String {
		return ""
	}
	
	var host: String {
		return ""
	}
	
	var path: String {
		return ""
	}
	
	var httpMethod: HTTPMethod {
		.get
	}
	
	var task: HTTPTask {
		.download
	}
	
	var headers: [String : String]? {
		return nil
	}
}
