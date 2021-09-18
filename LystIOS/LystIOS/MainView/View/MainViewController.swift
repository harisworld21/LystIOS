//
//  ViewController.swift
//  LystIOS
//
//  Created by HariRamya on 16/09/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel : MainViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.registerCollectionCell()
    }
    
    func setupUI() {
        viewModel = MainViewModel()
        collectionView.alwaysBounceVertical = true
        //Reload collectionView request from ViewModel
        viewModel.reloadCollectionView = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        //Update activity indicator request from ViewModel
        viewModel.loading = { loading in
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = !loading
                loading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
            }
        }
        
        //Navigate to Details View request from ViewModel
        viewModel.shouldShowDetailsView = {
            let storyboard = UIStoryboard(name: CommonConstants.storyBoardName, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: CommonConstants.detailedStoryBoardID)
            DispatchQueue.main.async {
                self.present(vc, animated: true)
            }
            return vc
        }
    }
}


extension MainViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    
    func registerCollectionCell () {
        self.collectionView.register(UINib(nibName:AnimalConstants.animalCellName, bundle: nil), forCellWithReuseIdentifier:AnimalConstants.animalCellID)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredDataProvider.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimalConstants.animalCellID, for: indexPath) as? AnimalCell {
            cell.viewModel = viewModel.filteredDataProvider[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(row: indexPath.row)
    }
}

extension MainViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchBarUpdated(text: self.searchBar.text ?? "")
    }
}
