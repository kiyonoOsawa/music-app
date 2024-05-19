//
//  TabBar.swift
//  Leaders
//
//  Created by 大澤清乃 on 2024/05/19.
//

import UIKit

class TabBar: UITabBar {
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 88
        return sizeThatFits;
    }

}
