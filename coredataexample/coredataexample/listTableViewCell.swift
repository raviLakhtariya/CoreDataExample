//
//  listTableViewCell.swift
//  coredataexample
//
//  Created by Elluminati Mac Mini 1 on 05/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit

class listTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    

    
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var delete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
