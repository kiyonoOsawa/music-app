//
//  MusicTableViewCell.swift
//  Music
//
//  Created by 大澤清乃 on 2024/05/21.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
