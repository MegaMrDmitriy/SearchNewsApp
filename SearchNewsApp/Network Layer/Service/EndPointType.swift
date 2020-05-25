//
//  EndPointType.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 20.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import Foundation

protocol EndPointType {
	var scheme: String { get }
	var host: String { get }
	var path: String { get }
	var url: URL? { get }
	var httpMethod: HTTPMethod { get }
	var task: HTTPTask { get }
	var headers: [String: String]? { get }
}
