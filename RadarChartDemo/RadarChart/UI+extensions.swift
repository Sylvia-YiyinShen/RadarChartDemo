//
//  UIColor+extension.swift
//  RadarChartDemo
//
//  Created by Yiyin Shen on 24/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var radarChartGray: UIColor {
        return UIColor(displayP3Red: 219 / 255, green: 221 / 255, blue: 220 / 255, alpha: 1.0)
    }

    static var radarChartRed: UIColor {
        return UIColor(displayP3Red: 139 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1.0)
    }
}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = image?.withRenderingMode(.alwaysTemplate)
        image = templateImage
        tintColor = color
    }
}

extension UIView {
    static func loadFromNib<T : UIView>() -> T? {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self)).instantiate(withOwner: nil, options: nil).first as? T
    }
}
