//
//  LogInUtils.swift
//  Lingva
//
//  Created by Roma Babajanyan on 02.10.2020.
//  Copyright © 2020 Roman Babadzhanian. All rights reserved.
//

import Foundation

class LogInUtils {
	
	static let shared = LogInUtils()
	
	fileprivate init() {}
	
	// Hardcoded to recognize only russian mobile phone number
	func verifyPhoneNumber(_ phoneNumber: String) -> Bool {
		phoneNumber ~= "^9\\d{2}\\d{3}\\d{4}$"
	}
	
	func verifyEmail(_ email: String) -> Bool {
		email ~= "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
	}
	
	func validatePasswords(_ source: String, _ dublicate: String = "") -> Bool {
		source == dublicate
	}
}

extension String {
	
	static func ~=(lhs: String, rhs: String) -> Bool {
		guard let regex = try? NSRegularExpression(pattern: rhs, options: .caseInsensitive) else { return false }
		let range = NSRange(location: 0, length: lhs.count)
		return regex.firstMatch(in: lhs, options: [], range: range) != nil
	}
}
