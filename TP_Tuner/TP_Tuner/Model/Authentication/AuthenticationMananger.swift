//
//  AuthenticationMananger.swift
//  TP_Tuner
//
//  Created by Roman Babajanyan on 03.11.2020.
//

import Foundation
import FirebaseAuth

class AuthenticationMananger: NSObject {
	
	var credentials: AuthCredentials!

	override init() {
		self.credentials = AuthCredentials()
	}
	
	fileprivate var authPoint : Auth = {
		return Auth.auth()
	}()
	
	func registerNewUser() {
		
		switch credentials.logInType {
		case .email:
			break
		case .phoneNumber:
			//
			break
		case .other:
			break
		}
	}
}
