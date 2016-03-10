//
//  AnnonceTableViewCell.swift
//  JSON
//
//  Created by Matthieu Hannequin on 09/03/2016.
//  Copyright © 2016 Hector. All rights reserved.
//

import UIKit

class AnnonceTableViewCell: UITableViewCell {

    @IBOutlet var labelMarque : UILabel!
    @IBOutlet var labelEtat : UILabel!
    @IBOutlet var labelPrix : UILabel!
    @IBOutlet var labelTel : UILabel!
    @IBOutlet var imageAnnonce : UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
