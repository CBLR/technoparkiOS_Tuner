//
//  WelcomeViewCoordinator.swift
//  TP_Tuner
//
//  Created by Roma Babajanyan on 27.10.2020.
//

import Foundation
import UIKit

class WelcomeViewCoordinator {

	weak var viewCtrl: WelcomeViewController?

	init(_ vc: WelcomeViewController) {
		self.viewCtrl = vc
	}

	func performWelcomeAnimation() {

		performOperation {
			UIView.animate(withDuration: 0.95) {
				
				let transformation = CGAffineTransform(translationX: (self.viewCtrl?.logoStackView.bounds.origin.x)!, y: -(self.viewCtrl?.view.bounds.size.height)! / 3.5)
				self.viewCtrl?.logoStackView.transform = transformation.scaledBy(x: 0.8, y: 0.8)
			}
		}

		performOperation(withDelay: 0.5) {
			UIView.animate(withDuration: 1.0) {
				self.viewCtrl?.logInStackView.alpha = 1
			}
		}
	}

	// MARK: - Actions

	func onLogInClicked() {

		UserDefaults.standard.set(true, forKey: "FirstLaunch")

		guard
			let vc = viewCtrl,
			let email = vc.emailTextField.text,
			let password = vc.passwordTextField.text
		else {
			return
		}

		guard LogInUtils.shared.validateEmail(email) else {
			return
		}

		// To be placed in completion

		if UserDefaults.standard.bool(forKey: "FirstLaunch") {
			UserDefaults.standard.set(false, forKey: "FirstLaunch")
			// present selection genre dialog
		} else {
			// present main tuner view
		}
	}
	
	func onSignUpClicked() {
		
	}
	
	func onSignInWithGoogleClicked() {
		
	}
}
