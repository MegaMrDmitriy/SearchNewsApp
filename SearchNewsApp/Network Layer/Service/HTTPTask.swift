//
//  HTTPTask.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 20.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import Foundation

enum HTTPTask {
	case request
	case requestURLParameters(urlParameters: [String: Any]?)
	case download
}