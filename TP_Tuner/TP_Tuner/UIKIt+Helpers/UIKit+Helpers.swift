//
//  UIKit+Helpers.swift
//  TP_Tuner
//
//  Created by Roman Babajanyan on 27.10.2020.
//

import UIKit


func performOperation(block: @escaping () -> Void) {
		
	DispatchQueue.main.async {
		block()
	}
}
	
func performOperation(withDelay delay: TimeInterval, block: @escaping () -> Void) {
	
	DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
		block()
	}
}


extension UIViewController {

	func setUpKeyboard() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)

		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
			NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}

	@objc func keyboardWillShow(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			if self.view.frame.origin.y == 0 {
				self.view.frame.origin.y -= keyboardSize.height
			}
		}
	}

	@objc func keyboardWillHide(notification: NSNotification) {
		if self.view.frame.origin.y != 0 {
			self.view.frame.origin.y = 0
		}
	}

	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}

extension UIView {
	
	@IBInspectable
	var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
			layer.masksToBounds = newValue > 0
		}
	}
}
