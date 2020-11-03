//
//  GenreSelectionViewController.swift
//  TP_Tuner
//
//  Created by Roman Babajanyan on 28.10.2020.
//

import UIKit

class GenreSelectionViewController: UIViewController {

	struct ViewModel {

		var genreCount: Int
	}

	@IBOutlet weak var genreSelectionCollectionView: UICollectionView!

	var viewModel: ViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		genreSelectionCollectionView.delegate = self
		genreSelectionCollectionView.dataSource = self
		// Do any additional setup after loading the view.
	}
}

extension GenreSelectionViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.genreCount
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreCollectionViewCellId", for: indexPath) as! GenreSelectionViewCell
		
		return cell
	}
}

extension GenreSelectionViewController: UICollectionViewDelegate {
	
}
