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
        
        setupViewController()
    }
    
    // MARK: - Private methods
    
    private func setupViewController() {
        
        navigationItem.backButtonTitle = "Back"
        navigationController?.navigationBar.tintColor = UIColor(red: 80/255, green: 173/255, blue: 154/255, alpha: 1)
        collectionView.collectionViewLayout = createLayout()
        
        switch tabBarController?.selectedIndex {
        case 0:
            navigationItem.title = "Creational patterns"
            patterns = fetchPatterns(filter: { $0.type == .creational })
        case 1:
            navigationItem.title = "Structural patterns"
            patterns = fetchPatterns(filter: { $0.type == .structural })
        case 2:
            navigationItem.title = "Behavioral patterns"
            patterns = fetchPatterns(filter: { $0.type == .behavioral })
        default:
            fatalError()
        }
    }
    
    private func fetchPatterns(filter: (Pattern) -> Bool) -> [Pattern] {
        
        let url = Bundle.main.url(forResource: "patterns", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let patterns = try! JSONDecoder().decode([Pattern].self, from: data)
        
        return patterns.filter(filter)
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
        
        let image = UIImage(named: patterns[indexPath.item].image)
        
        cell.imageView.image = image
        cell.label.text = patterns[indexPath.item].title
        
        return cell
    }
    
}

extension PatternsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let pattern = patterns[indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController = storyboard.instantiateViewController(
            withIdentifier: "PatternDetailsViewController") as! PatternDetailsViewController
        
        detailsViewController.pattern = pattern
        
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
