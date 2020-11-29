//
//  HomeTableViewCell.swift
//  TP_Tuner
//
//  Created by Roma Babajanyan on 28.11.2020.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
		self.contentView.layer.cornerRadius = 20
		self.contentView.layer.masksToBounds = true
	}
	
	// MARK: - Internal
	
	@IBOutlet weak var coverImageView: UIImageView!
	
	@IBOutlet weak var bandTitleLabel: UILabel!
	@IBOutlet weak var genresLabel: UILabel!
	@IBOutlet weak var tuningsLabel: UILabel!
	
	func configureView() {
	}
	
	fileprivate func castShadow() {
		var frame = self.contentView.bounds
		frame = frame.offsetBy(dx: 300, dy: 3)

		self.contentView.layer.shadowColor = UIColor.systemGray.cgColor
		self.contentView.layer.shadowOffset = .zero
//		self.contentView.layer.shadowOffset = CGSize()

		self.contentView.layer.shadowRadius = 5.5
		self.contentView.layer.shadowOpacity = 1
		self.contentView.layer.masksToBounds = false
		self.layer.shadowPath = UIBezierPath(roundedRect: frame, cornerRadius: 20).cgPath
		
		self.contentView.layer.shouldRasterize = true
		self.contentView.layer.rasterizationScale = UIScreen.main.scale
		
		self.coverImageView.layer.cornerRadius = 20.0
		self.coverImageView.layer.masksToBounds = true
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 10, bottom: 8, right: 10))
		castShadow()
	}
}
