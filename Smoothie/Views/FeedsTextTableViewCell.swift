//
//  FeedsTextTableViewCell.swift
//  Smoothie
//
//  Created by User on 23/06/22.
//

import UIKit

class FeedsTextTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var textlbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    static let Identifier = "FeedsTextTableViewCell"
   override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 20;
        bgView.clipsToBounds  =  true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
}
    func showText(textString:String,descriptionText:String){
        self.textlbl.text = textString
        self.descriptionLbl.text = "Description: " +  descriptionText
    }
    
}
