//
//  CustomCell.swift
//  ModernCollectionViews
//
//  Created by Mark Wong on 27/6/20.
//

import UIKit

// Define a custom state for the cell
fileprivate extension UIConfigurationStateCustomKey {
	static let fresh = UIConfigurationStateCustomKey("com.whizbang.modernCollectionViews.fresh")
}

private extension UICellConfigurationState {
	var item: Movie? {
		set { self[.fresh] = newValue }
		get { return self[.fresh] as? Movie }
	}
}

class MovieCell: UICollectionViewListCell {
	
	private let categoryIconView: UIImageView = UIImageView()
	
	private lazy var listContentView = UIListContentView(configuration: .cell())

	private var customViewConstraints: (listContentViewLeading: NSLayoutConstraint, listContentViewTrailing: NSLayoutConstraint)?
	
	private var item: Movie? = nil {
		didSet {
			guard let item = item else { return }
//			updateCellContentWith(movie: item)
			// calls the updateConfiguration function
			setNeedsUpdateConfiguration()
		}
	}
	
	override var configurationState: UICellConfigurationState {
		var state = super.configurationState
		state.item = self.item
		return state
	}
	
	func beginCellConfigurationWith(item: Movie) { self.item = item }
	
	private func updateCellLayoutIfNeeded() {
		
		guard customViewConstraints == nil else { return }
		
		contentView.addSubview(listContentView)
		contentView.addSubview(categoryIconView)
		
		listContentView.translatesAutoresizingMaskIntoConstraints = false
		categoryIconView.translatesAutoresizingMaskIntoConstraints = false
		
		listContentView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		listContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		categoryIconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		categoryIconView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		
		let leading = listContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
		leading.isActive = true
		let trailing = listContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		trailing.isActive = true
		customViewConstraints = (listContentViewLeading: leading, listContentViewTrailing: trailing)
	}
	
	override func updateConfiguration(using state: UICellConfigurationState) {
		updateCellLayoutIfNeeded()
		var content = UIListContentConfiguration.valueCell().updated(for: state)
//		var content = self.defaultContentConfiguration().updated(for: state)
		content.text = state.item?.title
		content.secondaryText = state.item?.genre
		listContentView.configuration = content
		
		categoryIconView.image = UIImage(systemName: "film")
		categoryIconView.tintColor = .systemYellow
	}
	
	private func updateCellContentWith(movie: Movie) {

	}
	
}
