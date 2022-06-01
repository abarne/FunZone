//
//  NotesTableViewCell.swift
//  FunZone
//
//  Created by admin on 5/31/22.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
   
    @IBOutlet weak var cellText: UILabel!
    
    @IBOutlet weak var cellDate: UILabel!
}
