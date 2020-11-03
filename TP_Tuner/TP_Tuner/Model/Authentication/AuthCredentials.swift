//
//  AuthCredentials.swift
//  TP_Tuner
//
//  Created by Roma Babajanyan on 03.11.2020.
//

import Foundation

struct AuthCredentials{
	
	enum LogInType {
		case phoneNumber
		case email
		case other
	}
	
	var logInType: LogInType = .email
	
	var email: String?
	var password: String?
	var phoneNumber: String?
	
	var uuid: String
	
	init() {
		self.uuid = UUID().uuidString
	}
}
