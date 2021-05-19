//
//  SecondaryLabel.swift
//  CalculatorUI_Programmatic
//
//  Created by James Chun on 5/18/21.
//

import UIKit

class SecondaryLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabel()
    }
    
    func setupLabel() {
        self.textColor = Colors.customGray
        updateFontTo()
    }
    
    func updateFontTo() {
        self.font = UIFont(name: FontNames.digital, size: 24)
    }

}//End of class
