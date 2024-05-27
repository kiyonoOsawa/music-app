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
        design()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func design() {
        emotion1.layer.cornerRadius = 28
        emotion2.layer.cornerRadius = 28
        emotion3.layer.cornerRadius = 28
        emotion4.layer.cornerRadius = 28
        emotion5.layer.cornerRadius = 28
        emotion6.layer.cornerRadius = 28
        emotion1.backgroundColor = UIColor.systemPink
        emotion2.backgroundColor = UIColor.systemPink
        emotion3.backgroundColor = UIColor.systemPink
        emotion4.backgroundColor = UIColor.systemPink
        emotion5.backgroundColor = UIColor.systemPink
        emotion6.backgroundColor = UIColor.systemPink

    }
    
}
