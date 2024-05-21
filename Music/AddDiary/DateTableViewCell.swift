//
//  DateTableViewCell.swift
//  Music
//
//  Created by 大澤清乃 on 2024/05/21.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var datePicker: UIDatePicker!

    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
