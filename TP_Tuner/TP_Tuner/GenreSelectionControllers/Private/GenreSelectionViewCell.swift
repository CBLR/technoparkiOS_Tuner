//
//  GenreSelectionViewCell.swift
//  TP_Tuner
//
//  Created by Roma Babajanyan on 28.10.2020.
//

import UIKit

class GenreSelectionViewCell: UICollectionViewCell {

//	struct ViewModel {
//
//		var image: UIImage
//		var titleLabel: String
//	}

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	
	@IBOutlet weak var blurSelectedView: UIVisualEffectView!
	
	var item: Genre? {
		didSet {
			updateView(item!)
		}
	}
	
	fileprivate func updateView(_ item: Genre) {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else {
				return
			}
			DispatchQueue.main.async {
				self.titleLabel.text = item.title
				self.imageView.image = UIImage(named: item.imageStringTitle ?? "volume.2.fill")
				
				if item.isSelected {
					self.blurSelectedView.alpha = 1
				} else {
					self.blurSelectedView.alpha = 0
				}
			
			}
			
			var frame = self.bounds
			frame = frame.offsetBy(dx: 0, dy: 0)

			self.contentView.layer.cornerRadius = 20
			self.contentView.layer.masksToBounds = true

			self.layer.shadowColor = UIColor.gray.cgColor
			self.layer.shadowOffset = .zero
			self.layer.shadowRadius = 5
			self.layer.shadowOpacity = 0.8
			self.layer.masksToBounds = false
			self.layer.shadowPath = UIBezierPath(roundedRect: frame, cornerRadius: self.contentView.layer.cornerRadius).cgPath
			
			self.contentView.layer.shouldRasterize = true
			self.contentView.layer.rasterizationScale = UIScreen.main.scale
			
		}
	}
}
