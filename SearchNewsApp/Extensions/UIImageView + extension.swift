//
//  UIImageView + extension.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 20.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
	
	func loadImage(from urlString: String?) {
		self.image = UIImage(named: "placeholder")
		guard let urlString = urlString else { return }
		
		if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
			if let cachedImage = imageFromCache as? UIImage {
				self.image = cachedImage
			}
			return
		}
		
		let manager = ImageManager()
		manager.downloadImage(from: urlString) { [weak self] (data) in
			guard let self = self else { return }
			if let data = data {
				guard let imageToCache = UIImage(data: data) else { return }
				imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
				self.image = imageToCache
			}
		}
	}
}
