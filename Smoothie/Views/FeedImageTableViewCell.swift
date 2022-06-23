//
//  FeedImageTableViewCell.swift
//  Smoothie
//
//  Created by User on 23/06/22.
//

import UIKit
import SDWebImage


class FeedImageTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    static let Identifier = "FeedImageTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 20;
        bgView.clipsToBounds  =  true
    }
override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)}
    
    func displayImage(url:String,descriptionText:String){
        descriptionLbl.text = "Description: " +  descriptionText
        feedImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
    }
    
}
