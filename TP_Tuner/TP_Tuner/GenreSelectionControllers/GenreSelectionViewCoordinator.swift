//
//  GenreSelectionViewCoordinator.swift
//  TP_Tuner
//
//  Created by Roma Babajanyan on 25.11.2020.
//

import UIKit

class GenreSelectionViewCoordinator {
	
	struct GenreCollectionViewModel {
		
		var genres = [Genre]()
		
		var selectedGenres = [Genre]()
	}
	
//	var genres = [Genre]()
	
	weak var viewCtrl: GenreSelectionViewController?
	
	var model = GenreCollectionViewModel()
	
	let snashotProcessor = SimpleDataProcessor()
	
	init(_ vc: GenreSelectionViewController) {
		self.viewCtrl = vc
	}
	
	typealias CompletionCallback = (_ success: Bool) -> Void
	
	func querryGenres(_ completion: @escaping CompletionCallback) {
		
		RequestAPI.getAllGenresList([:]) { [weak self] response in
			
			switch response {
			case let .success(snapshot):
//				print(snapshot.value)
				if let genresList = self?.snashotProcessor.processGenreSnapshot(snapshot) {
					self?.model.genres = genresList
					completion(true)
					NSLog(ErrorManager.succeededRetieve.localizedDescription)
				}
			case let .failure(error):
				NSLog(error.localizedDescription)
				completion(false)
			}
		}
		
	}
	
	func didSelect(genre item: Genre) {
		model.selectedGenres.append(item)
	}
	
	func didDeselect(genre item: Genre) {
//		model.selectedGenres.remove(at: 0) // TODO: - FIX
	}
	
	func onNextClicked() {
		
		guard !model.selectedGenres.isEmpty else {
			
			let alert = UIAlertController(title: "Select at least one genre to continue", message: nil, preferredStyle: .alert)
			alert.view.tintColor = .systemRed
			let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
			alert.addAction(okAction)
			viewCtrl?.present(alert, animated: true, completion: nil)

			return
		}
		
		let artistsListStoryboard = UIStoryboard(name: "ArtistsSelectionController", bundle: nil)
		let artistsListVC = artistsListStoryboard.instantiateViewController(identifier: "artistsListVC")
		viewCtrl?.navigationController?.pushViewController(artistsListVC, animated: true)
		
	}
}
