//
//  Genre.swift
//  TP_Tuner
//
//  Created by Roma Babajanyan on 24.11.2020.
//

import Foundation


struct Genre: Codable {
	
	var title: String
	var subGenre: [String: String]?
	var imageStringTitle: String?
	
	var isSelected = false
}
