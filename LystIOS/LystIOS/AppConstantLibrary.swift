//
//  AppConstantLibrary.swift
//  LystIOS
//
//  Created by HariRamya on 15/09/2021.
//
import UIKit

struct AnimalConstants {
    static let animalCellID = "animalCellId"
    static let animalCellName = "AnimalCell"
    static let BreedAPIUrlCat = "https://api.thecatapi.com/v1/breeds"
    static let BreedAPIUrlDog = "https://api.thedogapi.com/v1/breeds"
}

struct RatingConstants {
    static let starImage_Enable = "star_enable"
    static let starImage_Disable = "star_disable"
    static let NIB_RatingsView = "RatingsView"
}

struct CommonConstants {
    static let storyBoardName = "DetailedView"
    static let detailedStoryBoardID = "animalDetailVC"
}


extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

