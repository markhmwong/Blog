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
			Movie(title: "First Blood", rating: 0.73, genre: "Action"),
			Movie(title: "Rambo 2", rating: 0.64, genre: "Drama"),
			Movie(title: "Rambo 3", rating: 0.8, genre: "Romantic Comedy"),
			Movie(title: "Rambo Last Blood", rating: 0.3, genre: "Horror"),
			Movie(title: "Rambo Infinity", rating: 0.2, genre: "Indie"),
			Movie(title: "Rocky", rating: 0.7, genre: "Biopic"),
			Movie(title: "First Blood", rating: 0.73, genre: "Action"),
			Movie(title: "Rambo 2", rating: 0.64, genre: "Drama"),
			Movie(title: "Rambo 3", rating: 0.8, genre: "Romantic Comedy"),
			Movie(title: "Rambo Last Blood", rating: 0.3, genre: "Horror"),
			Movie(title: "Rambo Infinity", rating: 0.2, genre: "Indie"),
			Movie(title: "Rocky", rating: 0.7, genre: "Biopic"),
			Movie(title: "First Blood", rating: 0.73, genre: "Action"),
			Movie(title: "Rambo 2", rating: 0.64, genre: "Drama"),
			Movie(title: "Rambo 3", rating: 0.8, genre: "Romantic Comedy"),
			Movie(title: "Rambo Last Blood", rating: 0.3, genre: "Horror"),
			Movie(title: "Rambo Infinity", rating: 0.2, genre: "Indie"),
			Movie(title: "Rocky", rating: 0.7, genre: "Biopic"),
			Movie(title: "First Blood", rating: 0.73, genre: "Action"),
			Movie(title: "Rambo 2", rating: 0.64, genre: "Drama"),
			Movie(title: "Rambo 3", rating: 0.8, genre: "Romantic Comedy"),
			Movie(title: "Rambo Last Blood", rating: 0.3, genre: "Horror"),
			Movie(title: "Rambo Infinity", rating: 0.2, genre: "Indie"),
			Movie(title: "Rocky", rating: 0.7, genre: "Biopic"),
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
		
		let cellRegistration = UICollectionView.CellRegistration<MovieCell, Movie> { (cell, indexPath, item) in
			cell.beginCellConfigurationWith(item: item)
			cell.accessories = [.outlineDisclosure()]
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

