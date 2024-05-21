//
//  EmotionTableViewCell.swift
//  Music
//
//  Created by 大澤清乃 on 2024/05/21.
//

import UIKit

class EmotionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var emotion1: UIButton!
    @IBOutlet weak var emotion2: UIButton!
    @IBOutlet weak var emotion3: UIButton!
    @IBOutlet weak var emotion4: UIButton!
    @IBOutlet weak var emotion5: UIButton!
    @IBOutlet weak var emotion6: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
