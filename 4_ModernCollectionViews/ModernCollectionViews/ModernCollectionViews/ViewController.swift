//
//  ViewController.swift
//  ModernCollectionViews
//
//  Created by Mark Wong on 26/6/20.
//	Rebuilding the Simple List

import UIKit

enum Section {
	case main
}

class ViewController: UIViewController {
	
	var dataSource: UICollectionViewDiffableDataSource<Section, Movie>? = nil
	var collectionView: UICollectionView! = nil
	
	var movieList: [Movie] {
		get {
			return movies
		}
	}
	
	private var movies: [Movie] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		prepareMovieList()
		createCollectionView()
		configureDataSource()
		applySnapshot()
	}
	

}

// Datasource prep
extension ViewController {
	private func prepareMovieList() {
		movies = [
			Movie(title: "First Blood"),
			Movie(title: "Rambo 2"),
			Movie(title: "Rambo 3"),
			Movie(title: "Rambo Last Blood"),
			Movie(title: "Rambo Infinity"),
			Movie(title: "Rocky"),
			Movie(title: "Rocky 2"),
			Movie(title: "Rocky 3"),
			Movie(title: "Rocky 4"),
			Movie(title: "Rocky 5"),
			Movie(title: "First Blood"),
			Movie(title: "Rambo 2"),
			Movie(title: "Rambo 3"),
			Movie(title: "Rambo Last Blood"),
			Movie(title: "Rambo Infinity"),
			Movie(title: "Rocky"),
			Movie(title: "Rocky 2"),
			Movie(title: "Rocky 3"),
			Movie(title: "Rocky 4"),
			Movie(title: "Rocky 5"),
		]
	}
}

// Collection View creation

extension ViewController {
	private func createCollectionView() {
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.delegate = self
		view.addSubview(collectionView)
		
		collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
	}
	
	private func createCompositionalLayout() -> UICollectionViewLayout {
		let config = UICollectionLayoutListConfiguration(appearance: .sidebarPlain)
		return UICollectionViewCompositionalLayout.list(using: config)
	}
	
	private func configureDataSource() {
		
		let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Movie> { (cell, indexPath, item) in
			var content = cell.defaultContentConfiguration()
			content.text = "\(item.title)"
			cell.contentConfiguration = content
		}
		
		dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, item: Movie) -> UICollectionViewCell? in
			return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
		})
	}
	
	private func applySnapshot() {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
		snapshot.appendSections([.main])
		snapshot.appendItems(movieList)
		dataSource?.apply(snapshot, animatingDifferences: false)
	}
	
}

extension ViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
	}
}

