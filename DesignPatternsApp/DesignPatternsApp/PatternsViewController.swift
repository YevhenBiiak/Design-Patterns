//
//  PatternsViewController.swift
//  DesignPatternsApp
//
//  Created by Yevhen Biiak on 16.12.2022.
//

import UIKit

class PatternsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var patterns: [Pattern] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createLayout()
        
        setupViewController()
    }
    
    
    private func setupViewController() {
        
        switch tabBarController?.selectedIndex {
        case 0:
            navigationItem.title = "Creational patterns"
            patterns = Pattern.creationalPatterns
        case 1:
            navigationItem.title = "Structural patterns"
            patterns = Pattern.structuralPatterns
        case 2:
            navigationItem.title = "Behavioral patterns"
            patterns = Pattern.behavioralPatterns
        default:
            fatalError()
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let padding = view.frame.width * 0.036
        let cellSide = (view.frame.width - 3 * padding) / 2
        
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .absolute(cellSide),
            heightDimension: .absolute(cellSide))
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(cellSide)),
            subitems: [item]
        )
        
        group.interItemSpacing = .flexible(1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = padding
        section.contentInsets = NSDirectionalEdgeInsets(
            top: padding, leading: padding, bottom: padding, trailing: padding)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension PatternsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        patterns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PatternCollectionViewCell
        
        cell.imageView.image = patterns[indexPath.item].image
        cell.label.text = patterns[indexPath.item].title
        
        return cell
    }
    
}

extension PatternsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
