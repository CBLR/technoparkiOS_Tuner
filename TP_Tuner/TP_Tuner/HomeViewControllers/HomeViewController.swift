//
//  HomeViewController.swift
//  TP_Tuner
//
//  Created by Roman Babajanyan on 28.11.2020.
//

import UIKit

class HomeViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.dataSource = self
		tableView.delegate = self
	}
}

extension HomeViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		5
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		tableView.dequeueReusableCell(withIdentifier: "honeTableViewCellID") as! HomeTableViewCell
	}
}

extension HomeViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		140
	}
}
