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

	func validateEmail(_ email: String) -> Bool {
		
		let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
		
		guard let regExpression = try? NSRegularExpression(pattern: emailRegEx, options: .caseInsensitive) else {
			return false
		}
		
		guard let _ = regExpression.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) else {
			return false
		}
		
		return true
	}
}
