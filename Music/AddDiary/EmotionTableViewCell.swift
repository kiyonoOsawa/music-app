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
//        emotion1.imageView?.image = UIImage(named: "happy")
//        emotion2.imageView?.image = UIImage(named: "reject")
//        emotion3.imageView?.image = UIImage(named: "unhappy")
//        emotion4.imageView?.image = UIImage(named: "sad")
//        emotion5.imageView?.image = UIImage(named: "love")
//        emotion6.imageView?.image = UIImage(named: "happiness")
        let buttons = [emotion1, emotion2, emotion3, emotion4, emotion5, emotion6]
        for button in buttons {
            button?.imageView?.contentMode = .scaleAspectFit
        }

    }
    
}
