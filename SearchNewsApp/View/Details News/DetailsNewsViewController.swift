//
//  DetailsNewsViewController.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 18.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import UIKit

class DetailsNewsViewController: UIViewController {

	weak var viewModel: DetailNewsViewModel! {
		didSet {
			titleLabel.text = viewModel.title
			dateLabel.text = viewModel.date
			descriptionLabel.text = viewModel.newsDescription
			urlTextView.text = viewModel.url
			newsImageView.loadImage(from: viewModel.imageUrl)
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .systemBackground
		setupView()
    }
	
	private var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		return scrollView
	}()
	
	private let newsImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	private var dateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.alpha = 0.7
		label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		return label
	}()
	
	private var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 32, weight: .medium)
		return label
	}()
	
	private var descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
		return label
	}()
	
	private var urlTextView: UITextView = {
		let textView = UITextView()
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.isScrollEnabled = false
		textView.isEditable = false
		textView.dataDetectorTypes = [.link]
		textView.font = UIFont.systemFont(ofSize: 14)
		return textView
	}()
	
	private func setupView() {
		
		view.addSubview(scrollView)
		scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		
		scrollView.addSubview(newsImageView)
		newsImageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
		newsImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
		newsImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
		newsImageView.heightAnchor.constraint(equalTo: newsImageView.widthAnchor).isActive = true
		
		scrollView.addSubview(dateLabel)
		dateLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 25).isActive = true
		dateLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 36).isActive = true
		
		scrollView.addSubview(titleLabel)
		titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
		titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 36).isActive = true
		titleLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -72).isActive = true
		
		scrollView.addSubview(descriptionLabel)
		descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
		descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 36).isActive = true
		descriptionLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -72).isActive = true
		
		scrollView.addSubview(urlTextView)
		urlTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
		urlTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 36).isActive = true
		urlTextView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -72).isActive = true
		
		view.layoutIfNeeded()
		
		var contentRect = CGRect.zero
		for view in scrollView.subviews {
			contentRect = contentRect.union(view.frame)
		}
		scrollView.contentSize.height = contentRect.size.height + 5
	}
}
