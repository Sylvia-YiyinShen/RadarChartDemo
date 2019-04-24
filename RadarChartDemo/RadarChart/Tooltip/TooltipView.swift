//
//  TooltipView.swift
//  RadarChartDemo
//
//  Created by Yiyin Shen on 24/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import Foundation
import UIKit

class TooltipView: UIView {
    @IBOutlet weak var descriptionLabel: UILabel!

    func configure(with model: RadarChartSectionModel) {
        descriptionLabel.text = String("\(model.sectionName): \(model.currentValue)")
        descriptionLabel.textColor = model.sectionColor
    }
}
