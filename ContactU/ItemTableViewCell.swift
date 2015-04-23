//
//  ItemTableViewCell.swift
//  ContactU
//
//  Created by HuCharlie on 4/23/15.
//  Copyright (c) 2015 HuCharlie. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactDate: UILabel!
    @IBOutlet weak var contactNote: UITextView!
    
    
    
    
    @IBOutlet weak var CallBtn: UIButton!
    @IBOutlet weak var TextBtn: UIButton!
    @IBOutlet weak var MailBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
