//
//  PatternCollectionViewCell.swift
//  DesignPatternsApp
//
//  Created by Yevhen Biiak on 19.12.2022.
//

import UIKit

class PatternCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    private var cornerRadius: CGFloat = 17
    private lazy var shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        
        layer.shadowRadius = 5.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = shadowPath.cgPath
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        alpha = state.isSelected ? 0.5 : 1.0
    }
}
