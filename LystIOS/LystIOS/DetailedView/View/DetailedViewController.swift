//
//  DetailedViewController.swift
//  LystIOS
//
//  Created by HariRamya on 17/09/2021.
//

import UIKit

class DetailedViewController : UIViewController {
    
    var viewModel : DetailViewModel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var temperment: UILabel!
    @IBOutlet weak var lifeSpan: UILabel!
    @IBOutlet weak var dogDescription: UILabel!
    @IBOutlet weak var indoor: RatingsView!
    @IBOutlet weak var grooming: RatingsView!
    @IBOutlet weak var energy: RatingsView!
    @IBOutlet weak var intelligence: RatingsView!
    @IBOutlet weak var experimental: RatingsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        let breedModel = viewModel.breedSearchModel
        
        titleLbl.text = breedModel.breed?.name
        animalImage.image = breedModel.image
        origin.text = breedModel.breed?.origin
        temperment.text = breedModel.breed?.temperament
        lifeSpan.text = breedModel.breed?.lifeSpan
        dogDescription.text = breedModel.breed?.mainSearchModelDescription
        indoor.rating = Ratings(ratingVal: breedModel.breed?.indoor ?? 0, title: "Indoor Rating")
        grooming.rating = Ratings(ratingVal: breedModel.breed?.grooming ?? 0, title: "Grooming Rating")
        energy.rating = Ratings(ratingVal: breedModel.breed?.energyLevel ?? 0, title: "Energy Level Rating")
        intelligence.rating = Ratings(ratingVal: breedModel.breed?.intelligence ?? 0, title: "Intelligence Rating")
        experimental.rating = Ratings(ratingVal: breedModel.breed?.experimental ?? 0, title: "Experimental Rating")
    }
    
}
