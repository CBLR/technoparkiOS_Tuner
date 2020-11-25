//
//  ErrorManager.swift
//  TP_Tuner
//
//  Created by Roman Babajanyan on 23.11.2020.
//

import Foundation

enum ErrorManager: Error {
	
	case dataRetrieveFailure
	case dataUpdateFailure
	case dataCreateFailure
	case authFailure
	case succeededRetieve
}

extension ErrorManager: LocalizedError {
	
	var errorDescription: String? {
		switch self {
		case .authFailure:
			return "Failed to authenticate user"
		case .dataCreateFailure:
			return "Failed to load new data"
		case .dataRetrieveFailure:
			return "Failed to querry data"
		case .dataUpdateFailure:
			return "Failed to patch data"
		case .succeededRetieve:
			return "Successfully rerieved data"
		}
	}
}
