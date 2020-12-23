//
//  SuperCarsCollectionViewController.swift
//  In-App-LanguageChange
//
//  Created by Milos Malovic on 20.12.20..
//

import UIKit


class SuperCarsCollectionViewController: UICollectionViewController {
    
    var viewModel: CarsListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.carsCount ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCell", for: indexPath) as? CarCollectionViewCell else { return UICollectionViewCell() }
        cell.model = viewModel?.createCarsCellModel(for: indexPath.row)
        return cell
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(245))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        self.navigationController?.navigationBar.prefersLargeTitles = true  
        let titles = ["en", "es"]
        let seg = UISegmentedControl(items: titles)
        seg.addTarget(self, action: #selector(self.changeLang(sender:)), for: .valueChanged)
        if LanguageManager.shared.currentLanguage == .es {
            seg.selectedSegmentIndex = 1
        } else {
            seg.selectedSegmentIndex = 0
        }
        navigationItem.titleView = seg
    }
    
    @objc private func changeLang(sender: UISegmentedControl) {
        ChangeLanguage.shared.changeLanguage(sender: sender)
    }
}
