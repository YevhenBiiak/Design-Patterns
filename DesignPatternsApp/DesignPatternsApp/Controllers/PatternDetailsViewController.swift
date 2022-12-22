//
//  PatternDetailsViewController.swift
//  DesignPatternsApp
//
//  Created by Yevhen Biiak on 19.12.2022.
//

import UIKit

class PatternDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var popularityStarsStack: UIStackView!
    @IBOutlet weak var complexityStarsStack: UIStackView!
    @IBOutlet weak var intentLabel: UILabel!
    @IBOutlet weak var structureImageView: UIImageView!
    @IBOutlet weak var structImageViewConstraint: NSLayoutConstraint!
    
    var pattern: Pattern!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = pattern.title
        imageView.image = UIImage(named: pattern.image)
        intentLabel.text = pattern.intent
        structureImageView.image = UIImage(named: pattern.structure)
        
        setPopularity(stars: pattern.popularity)
        setComplexity(stars: pattern.complexity)
        adjustStructureImageViewSize()
    }
    
    @IBAction func seeCodeButton(_ sender: UIButton) {
        
    }
    
    private func adjustStructureImageViewSize() {
        
        let image = structureImageView.image!
        let aspectRatio = image.size.height / image.size.width
        let height = structureImageView.frame.width * aspectRatio
    
        structImageViewConstraint.constant = height
    }
    
    private func setPopularity(stars: Int) {
        guard let imageViews = popularityStarsStack.arrangedSubviews as? [UIImageView] else { return }
        
        for (i, imageView) in imageViews.enumerated() where i < stars {
            imageView.image = UIImage(systemName: "star.fill")
        }
    }
    
    private func setComplexity(stars: Int) {
        guard let imageViews = complexityStarsStack.arrangedSubviews as? [UIImageView] else { return }
        
        for (i, imageView) in imageViews.enumerated() where i < stars {
            imageView.image = UIImage(systemName: "star.fill")
        }
    }
}

