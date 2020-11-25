//
//  SimpleDataProcessor.swift
//  TP_Tuner
//
//  Created by Roma Babajanyan on 24.11.2020.
//

import Foundation
import FirebaseDatabase

extension DataSnapshot {

	var data: Data? {
		try? JSONSerialization.data(withJSONObject: self.value as Any, options: [])
	}

	var json: String? { data?.string }
}

extension Data {

	var string: String? { String(data: self, encoding: .utf8) }
}

class SimpleDataProcessor {

	var decoder: JSONDecoder!
	var encoder: JSONEncoder!
//	var serialiser: JSONSerialization!
	
	init() {
		decoder = JSONDecoder()
		encoder = JSONEncoder()
//		serialiser = JSONSerialization()
	}
	
	func processSnapshot<T: Codable>(_ snapshot: DataSnapshot) -> T? {
		
		guard let jsonData = snapshot.data else {
			return nil
		}
		
		do {
			let object = try decoder.decode(T.self, from: jsonData)
			return object
		} catch let error {
			NSLog("[\(String(describing: self))]: %s", error.localizedDescription)
		}
		
		return nil
	}
	
	func processGenreSnapshot(_ snapshot: DataSnapshot) -> [Genre]? {
		
		guard let values = snapshot.value as? Dictionary<String, Any> else {
			return nil
		}
		
		let sorted = values.sorted { $0.0 < $1.0 }
		
		var genres = [Genre]()
		
		sorted.forEach { (_, value) in
			guard
				let jsonData = try? JSONSerialization.data(withJSONObject: value as Any, options: []),
				let genre = try? decoder.decode(Genre.self, from: jsonData)
			else {
				return
			}
			
			genres.append(genre)
		}
		
		return genres
	}
	func encodeObject<T: Codable>(_ object: T) -> Data? {
		
		do {
			let encodedData = try encoder.encode(object)
			return encodedData
		} catch let error {
			NSLog("[\(String(describing: self))]: %s", error.localizedDescription)
		}
		
		return nil
	}
}
