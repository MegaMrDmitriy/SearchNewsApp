//
//  NewsTableViewCell.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 18.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

	weak var viewModel: NewsCellViewModel! {
		didSet {
			titleLabel.text = viewModel.title
			isViewedLabel.isHidden = !viewModel.isViewed
			newsImageView.loadImage(from: viewModel.imageUrl)//.image = UIImage(systemName: "heart")
		}
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setupCell()
		setupImageView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	let newsImageView = UIImageView()
	
	private func setupImageView() {
		newsImageView.translatesAutoresizingMaskIntoConstraints = false
		newsImageView.layer.cornerRadius = 6
		newsImageView.layer.masksToBounds = true
		newsImageView.isUserInteractionEnabled = true
		newsImageView.contentMode = .scaleAspectFill
	}
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		return label
	}()
	
	let isViewedLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Viewed"
		return label
	}()
	
	private func setupCell() {
		
		backgroundColor = .systemBackground
		
		contentView.addSubview(newsImageView)
		contentView.addSubview(titleLabel)
		contentView.addSubview(isViewedLabel)
		
		NSLayoutConstraint.activate([
			newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
			newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			newsImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/4),
			newsImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/4),
			
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
			titleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 10),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
			
			isViewedLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 10),
			isViewedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
			isViewedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
			
			contentView.bottomAnchor.constraint(greaterThanOrEqualTo: newsImageView.bottomAnchor, constant: 12),
			contentView.bottomAnchor.constraint(greaterThanOrEqualTo: isViewedLabel.bottomAnchor, constant: 12),
		])
	}
}
