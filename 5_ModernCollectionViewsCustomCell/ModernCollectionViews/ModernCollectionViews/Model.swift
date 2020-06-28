//
//  Model.swift
//  ModernCollectionViews
//
//  Created by Mark Wong on 26/6/20.
//

import Foundation

struct Movie: Hashable, Identifiable {
	var id: UUID = UUID()
	/// Movie's Main Title
	var title: String
	/// Rating represted as a percentage
	var rating: Double
	/// Genre
	var genre: String
}
