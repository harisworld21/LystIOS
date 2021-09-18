//
//  AnimalCell.swift
//  LystIOS
//
//  Created by HariRamya on 15/09/2021.
//

import UIKit

class AnimalCell : UICollectionViewCell {
    
    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.animalImage?.image = nil
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    
    var viewModel: BreedSearchModel! = nil {
        didSet {
            //Update cells when value is ready
            animalName.text = viewModel.breed?.name
            age.text = viewModel.breed?.origin
            let weightVal = "\(viewModel.breed?.weight?.metric ?? "")" + "\(viewModel.breed?.weight?.imperial ?? "")"
            weight.text = weightVal
            self.loadImage(img: viewModel.image)
            viewModel.isImageReady = {
                self.loadImage(img: self.viewModel.image)
            }
        }
    }
    
    func loadImage(img: UIImage?)
    {
        DispatchQueue.main.async {
            if self.animalImage.image != nil {
                return
            }
            let width = self.frame.width/2
            self.animalImage.image = self.viewModel.image?.resized(to: CGSize(width: width, height: width))
            self.activityIndicator.stopAnimating()
        }
    }
}
