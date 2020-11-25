//
//  RequestAPI.swift
//  TP_Tuner
//
//  Created by Roman Babajanyan on 03.11.2020.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class DatabasePoint {
	
	static let db = DatabasePoint()
	
	private init() {}
	
	var dbPoint: Database = {
		Database.database()
	}()
}

class AuthenticationPoint {
	
	static let auth = AuthenticationPoint()
	
	private init() {}
	
	var authPoint: Auth = {
		Auth.auth()
	}()
}

class RequestAPI: NSObject {
	
	typealias Constants = ReferenceConstants
	
	static func finalizeReferencePath(path: String, params: [String: String]) -> String {
		
		var res = path
		
		guard let directory = params["directory"],
			  let name = params["name"],
			  let next = params["next"]
		else {
			return res
		}
		
		res = path + "/\(name)/\(directory)/\(next)/"
		return res
	}

	static let shared = RequestAPI()

	typealias CompletionHandler<Response> = (Result<Response, Error>) -> Void
	typealias RequestWithParams<Response> = (_ params: [String: String],_ completionHandler: @escaping CompletionHandler<Response>) -> Void

	@propertyWrapper
	struct QuerryData<T> {

		init(with referencePath: String) {
			self.referencePath = referencePath
		}

		var wrappedValue: RequestWithParams<T> {
			return { (params, completionHandler) in

				let finalizedPath = RequestAPI.finalizeReferencePath(path: self.referencePath, params: params)
				let reference = DatabasePoint.db.dbPoint.reference(withPath: finalizedPath)
				
				reference.observeSingleEvent(of: .value) { (snapshot) in
					
					if snapshot.exists() {
						completionHandler(.success(snapshot as! T))
					} else {
						completionHandler(.failure(ErrorManager.dataRetrieveFailure))
					}
				}
			}
		}

		private var referencePath: String
	}

	typealias UpdateDataRequestWithParams<Response> = (_ params: [String: String]?,_ data: [AnyHashable: Any]?, _ completionHandler: @escaping CompletionHandler<Response>) -> Void
	
	@propertyWrapper
	struct UpdateData<T> {

		init(with referencePath: String) {
			self.referencePath = referencePath
		}

		var wrappedValue: UpdateDataRequestWithParams<T> {
			return { (params, data, completionHandler) in
				
				if
					let values = data,
					let params = params {
					
						let finalizedPath = RequestAPI.finalizeReferencePath(path: self.referencePath, params: params)

						let reference = Database.database().reference(withPath: finalizedPath)
						reference.updateChildValues(values)
						completionHandler(.success(Void() as! T))
				}

				completionHandler(.failure(ErrorManager.dataUpdateFailure))
			}
		}
		
		private var referencePath: String
	}
	
	typealias NewDataUploadRequestWithParams<Response> = (_ params: [String: String],_ data: Any?, _ completionHandler: @escaping CompletionHandler<Response>) -> Void

	//Analog of POST Request for uploading new data
	@propertyWrapper
	struct PostData<T> {

		init(with referencePath: String) {
			self.referencePath = referencePath
		}

		var wrappedValue: NewDataUploadRequestWithParams<T> {
			return { (params, data, completionHandler) in
				
				let finalPath = RequestAPI.finalizeReferencePath(path: self.referencePath, params: params)

				DatabasePoint.db.dbPoint.reference(withPath: finalPath).setValue(data) { (error, ref) in
					if error != nil {
						completionHandler(.failure(error!))
					} else {
						completionHandler(.success("Succeded" as! T))
					}
				}
			}
		}

		private var referencePath: String
	}

	typealias CreateNewUserRequest<Response> = (_ completionHandler: @escaping CompletionHandler<Response>) -> Void

//	@propertyWrapper
//	struct NewUser<T> {
//
//		init(with credentials: AuthCredentials) {
//			self.credentials = credentials
//		}
//
//		var wrappedValue: CreateNewUserRequest<T> {
//			return { (completionHandler) in
//
//				Auth.auth().createUser(withEmail: self.credentials.email, password: self.credentials.password) { (_, error) in
//
//					if error != nil {
//						completionHandler(.failure(error))
//					}
//
//					completionHandler(.success(Void() as! T))
//				}
//
//			}
//		}
//
//		private var credentials: AuthCredentials
//	}
}

// MARK: - Actions
extension RequestAPI {
	
	@QuerryData(with: Constants.shared.allBands)
	static var getAllArtistsList: RequestWithParams<DataSnapshot>
	
	@QuerryData(with: Constants.shared.allGenres)
	static var getAllGenresList: RequestWithParams<DataSnapshot>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@UpdateData(with: "")
	static var patchData: UpdateDataRequestWithParams<DataSnapshot>
	
	@PostData(with: "")
	static var uploadData: NewDataUploadRequestWithParams<DataSnapshot>
	
	
	
	@QuerryData(with: "Users/id_here")
	static var getUserAccount: RequestWithParams<NSDictionary>
	
	@QuerryData(with: "Tunings")
	static var getMainTunings: RequestWithParams<NSDictionary>
	
	@UpdateData(with: "Preferences/id_here")
	static var uploadInitialAccountSettings: UpdateDataRequestWithParams<NSDictionary>
}
