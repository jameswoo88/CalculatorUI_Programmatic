//
//  StyleGuide.swift
//  CalculatorUI_Programmatic
//
//  Created by James Chun on 5/18/21.
//

import UIKit

extension UIView {
    
    func addCornerRadius(_ radius: CGFloat = 30) {
        self.layer.cornerRadius = radius
        self.layer.borderColor = Colors.customGray.cgColor
        self.layer.borderWidth = 3
    }
    
    func makeIntoCircle() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
    }
    
    func setBackgroundColor(_ color: UIColor) {
        self.backgroundColor = color
    }
    
}//End of extension

struct Colors {
    static let customYellow = UIColor(red: 240/255, green: 220/255, blue: 104/255, alpha: 1)
    static let customBlack = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1)
    static let customWhite = UIColor(red: 254/255, green: 250/255, blue: 237/255, alpha: 1)
    static let customGray = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
}

struct FontNames {
    static let menlo = "Menlo-Regular"
    static let menloBold = "Menlo-Bold"
    static let digital = "Digital-7"
    static let digitalMono = "Digital-7 Mono"
}
