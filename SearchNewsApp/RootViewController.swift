//
//  RootViewController.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 18.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

	private var current: UIViewController
	private var newsManager = NewsManager()
	private var newsViewModel: NewsViewModel!
	
	init() {
		newsViewModel = NewsViewModel(newsManager: newsManager)
		let newsViewController = NewsViewController()
		newsViewController.viewModel = newsViewModel
		current = UINavigationController(rootViewController: newsViewController)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(current)
		current.view.frame = view.bounds
		view.addSubview(current.view)
		current.didMove(toParent: self)
    }

	
	func pushDetailsViewController(with viewModel: DetailNewsViewModel) {
		let new = DetailsNewsViewController()
		new.viewModel = viewModel
		(current as? UINavigationController)?.pushViewController(new, animated: true)
	}
}
