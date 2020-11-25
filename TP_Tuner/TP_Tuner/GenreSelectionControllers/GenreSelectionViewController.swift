//
//  GenreSelectionViewController.swift
//  TP_Tuner
//
//  Created by Roman Babajanyan on 28.10.2020.
//

import UIKit

class GenreSelectionViewController: UIViewController {

	let cellHeightScale: CGFloat = 0.69
	let cellWidthScale: CGFloat = 0.85
	
	var genreSelectionViewCoordinator: GenreSelectionViewCoordinator?

	@IBOutlet weak var genreSelectionCollectionView: UICollectionView!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		genreSelectionCollectionView.delegate = self
		genreSelectionCollectionView.dataSource = self
		genreSelectionViewCoordinator = GenreSelectionViewCoordinator(self)
		
		configureCollectionViewCellLayout()
		
		genreSelectionViewCoordinator?.querryGenres{ [weak self] success in
			guard let self = self else { return }
			
			performOperation {
				self.genreSelectionCollectionView.reloadData()
			}
		}
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()

		configureCollectionViewCellLayout()
	}
	
	// MARK: - Internal
	
	fileprivate func configureCollectionViewCellLayout() {

		let viewSize = UIScreen.main.bounds.size
		let cellWidth = floor(viewSize.width * cellWidthScale)
		let cellHeight = floor(viewSize.height * cellHeightScale)
		
		let xInset = (view.bounds.width - cellWidth) / 2.0
		let yInset = (view.bounds.height - cellHeight) / 2.0

		let layout = genreSelectionCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
		layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
		genreSelectionCollectionView.contentInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
		genreSelectionCollectionView.layoutIfNeeded()
	}
	
	@IBAction func onNextClicked(_ sender: Any) {
		genreSelectionViewCoordinator?.onNextClicked()
	}
}

// MARK: - UICollectionView routine

extension GenreSelectionViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		genreSelectionViewCoordinator?.model.genres.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreCollectionViewCellId", for: indexPath) as! GenreSelectionViewCell

		if let item = genreSelectionViewCoordinator?.model.genres[indexPath.item] {
			cell.item = item
		}

		return cell
	}

}

extension GenreSelectionViewController: UICollectionViewDelegate, UIScrollViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let cell = collectionView.cellForItem(at: indexPath) as? GenreSelectionViewCell else { return }
		
		let selectionBlurViewShown = cell.item!.isSelected
		cell.item?.isSelected = !selectionBlurViewShown
		
		guard cell.item!.isSelected else {
			return
		}
		
		(cell.item!.isSelected) ? genreSelectionViewCoordinator?.didSelect(genre: cell.item!) : genreSelectionViewCoordinator?.didDeselect(genre: cell.item!)
	}

	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

		let layout = genreSelectionCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
		let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing

		var offset = targetContentOffset.pointee
		let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
		let roundedIndex = round(index)

		offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)

		targetContentOffset.pointee = offset

		let hapticFeedbackGenerator = UINotificationFeedbackGenerator()
		hapticFeedbackGenerator.notificationOccurred(.warning)
	}
}
