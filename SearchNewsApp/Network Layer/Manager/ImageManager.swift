//
//  ImageManager.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 20.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import Foundation

class ImageManager {
	
	private let router = Router<ImageEndPoint>()
	
	func downloadImage(from urlString: String, completion: @escaping (Data?) -> Void) {
		router.request(.downloadImage(urlString: urlString)) { (data, response, error) in
			if error != nil {
				completion(nil)
				return
			}
			
			guard let data = data else { return }
			DispatchQueue.main.async() {
				completion(data)
			}
		}
	}
	
}
