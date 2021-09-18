//
//  RatingsView.swift
//  LystIOS
//
//  Created by HariRamya on 17/09/2021.
//

import UIKit

class RatingsView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var ratingTitle : UILabel!
    @IBOutlet var starImg: [UIImageView]!

    
    var rating : Ratings! {
        didSet {
            ratingTitle.text = rating.ratingTitle
            starImg.forEach({ img in
                let enableStar = img.tag < rating.rating
                img.image = UIImage(named: enableStar ? RatingConstants.starImage_Enable : RatingConstants.starImage_Disable)
            })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupRating()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupRating(){
        let viewFromXib = Bundle.main.loadNibNamed(RatingConstants.NIB_RatingsView, owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
}

struct Ratings {
    let rating : Int
    let ratingTitle: String
    
    init(ratingVal: Int, title: String) {
        rating = ratingVal
        ratingTitle = title
    }
}
