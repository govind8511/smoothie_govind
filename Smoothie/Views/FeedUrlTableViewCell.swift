//
//  FeedUrlTableViewCell.swift
//  Smoothie
//
//  Created by User on 23/06/22.
//

import UIKit

class FeedUrlTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    static let Identifier = "FeedUrlTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 20;
        bgView.clipsToBounds  =  true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
}
    
    func showUrl(url:String,descriptionText:String){
        descriptionLbl.text = "Description: " +  descriptionText
        self.textLbl.text = url
    }
       
    
}
