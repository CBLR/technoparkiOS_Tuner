//
//  RequestAPI.swift
//  TP_Tuner
//
//  Created by Roman Babajanyan on 03.11.2020.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class RequestAPI: NSObject {

	static let shared = RequestAPI()
	
	fileprivate authenticationPoint : Auth = {
		return Auth.auth()
	}()

	typealias CompletionHandler<Response> = (Result<Response, Error>) -> Void
	typealias Request<Response> = (_ completionHandler: @escaping CompletionHandler<Response>) -> Void

	@propertyWrapper
	struct QuerryData<T> {

		init(with referencePath: String) {
			self.referencePath = referencePath
		}

		var wrappedValue: Request<T> {
			return { (completionHandler) in

				let reference = Database.database().reference(withPath: self.referencePath)
				
				reference.observeSingleEvent(of: .value) { (snapshot) in
					completionHandler(.success(snapshot as! T))
				}
			}
		}

		private var referencePath: String
	}

	typealias UpdateDataRequest<Response> = (_ data: [AnyHashable: Any]?, _ completionHandler: @escaping CompletionHandler<Response>) -> Void
	
	@propertyWrapper
	struct UpdateData<T> {

		init(with referencePath: String) {
			self.referencePath = referencePath
		}

		var wrappedValue: UpdateDataRequest<T> {
			return { (data, completionHandler) in

				if let values = data {

					let reference = Database.database().reference(withPath: self.referencePath)
					reference.updateChildValues(values)
					completionHandler(.success(Void() as! T))
				}

				completionHandler(.failure(NSError.init(domain: "RequestAPI", code: 0, userInfo: ["descr": "Unknown error occured"])))}
		}
		
		private var referencePath: String
	}

	typealias CreateNewUserRequest<Response> = (_ completionHandler: @escaping CompletionHandler<Response>) -> Void

	@propertyWrapper
	struct NewUser<T> {

		init(with credentials: AuthCredentials) {
			self.credentials = credentials
		}

		var wrappedValue: CreateNewUserRequest<T> {
			return { (completionHandler) in

				Auth.auth().createUser(withEmail: self.credentials.email, password: self.credentials.password) { (_, error) in

					if error != nil {
						completionHandler(.failure(error))
					}

					completionHandler(.success(Void() as! T))
				}

			}
		}

		private var credentials: AuthCredentials
	}
}

// MARK: - Actions
extension RequestAPI {
	
	@QuerryData(with: "Users/id_here")
	static var getUserAccount: Request<NSDictionary>
	
	@QuerryData(with: "Tunings")
	static var getMainTunings: Request<NSDictionary>
	
	@UpdateData(with: "Preferences/id_here")
	static var uploadInitialAccountSettings: UpdateDataRequest<NSDictionary>
}
