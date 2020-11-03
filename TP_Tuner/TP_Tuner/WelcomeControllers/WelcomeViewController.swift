//
//  ViewController.swift
//  TP_Tuner
//
//  Created by Roma Babajanyan on 04.10.2020.
//

import UIKit

class WelcomeViewController: UIViewController {

	var coordinator: WelcomeViewCoordinator!

	@IBOutlet weak var logoStackView: UIStackView!
	@IBOutlet weak var logInStackView: UIStackView!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setUpKeyboard()
		self.coordinator = WelcomeViewCoordinator(self)
		logInStackView.alpha = 0
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		coordinator.performWelcomeAnimation()
	}
	
	// MARK: - Internal
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	// MARK: - Actions
	
	@IBAction func onLogInClicked(_ sender: Any) {
		coordinator.onLogInClicked()
	}
	
	@IBAction func onSignUpClicked(_ sender: Any) {
		coordinator.onSignUpClicked()
	}
	
	@IBAction func onSignInWithGoogleClicked(_ sender: Any) {
		coordinator.onSignInWithGoogleClicked()
	}
}
