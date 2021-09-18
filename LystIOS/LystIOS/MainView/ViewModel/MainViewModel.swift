//
//  MainViewModel.swift
//  LystIOS
//
//  Created by HariRamya on 15/09/2021.
//

import Foundation
import UIKit

class MainViewModel: NSObject {
    
    var dataProvider = [BreedSearchModel]()
    var filteredDataProvider = [BreedSearchModel]()
    var reloadCollectionView: ()->() = {}
    var loading : (Bool)->() = {_ in}
    var shouldShowDetailsView : ()->(UIViewController) = {return UIViewController()}
    
    override init() {
        super.init()
        setupInitial()
    }
    
}

//MARK: COllectionView related Items
extension MainViewModel {
    private func setupInitial(){
        //API Call
        getDataFromServer(url: AnimalConstants.BreedAPIUrlCat)
    }
    
    func getDataFromServer(url:String) {
        //Activity Indicator
        self.loading(true)
        ApiClient.getDataFromServer(urlString: url, completion: { result, data in
            guard result,
                  let apiData = data,
                  let breedModel = ApiClient.parse(type: [BreedModel].self, data: apiData),
                  let breedList = self.asSearchModel(breeds: breedModel) else{
                //Response failed
                print("Failed fetching data")
                self.loading(false)
                return
            }
            
            self.dataProvider.append(contentsOf: breedList)
            self.filteredDataProvider = self.dataProvider
            self.reloadCollectionView()
            self.loading(false)
        })
    }
    
    func asSearchModel(breeds: [BreedModel]) -> [BreedSearchModel]? {
        var searchModel = [BreedSearchModel]()
        breeds.forEach({ model in
            let internalModel = BreedSearchModel()
            internalModel.breed = model
            searchModel.append(internalModel)
        })
        return searchModel
    }
    
    func didSelectItem(row: Int) {
        //Tableview selected and Item
        if let vc = shouldShowDetailsView() as? DetailedViewController{
            vc.viewModel = DetailViewModel(model: dataProvider[row])
            
        }
    }
}

//MARK: Searchbar related items
extension MainViewModel {
    
    func searchBarUpdating(text: String) {
        filteredDataProvider = dataProvider.filter({val in
            val.breed?.name?.contains(text) ?? false ? true : false
        })
    }
    
    func searchBarUpdated(text: String) {
        if text.isEmpty{
            resetSearchItems()
            self.reloadCollectionView()
            return
        }
        filteredDataProvider = dataProvider.filter({val in
            val.breed?.name?.contains(text) ?? false ? true : false
        })
        self.reloadCollectionView()
    }
    
    func resetSearchItems() {
        filteredDataProvider = dataProvider
    }
}
