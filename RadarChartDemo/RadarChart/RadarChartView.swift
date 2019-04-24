//
//  RadarChartView.swift
//  RadarChartDemo
//
//  Created by Yiyin Shen on 24/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import Foundation
import UIKit

enum SectionLayout {
    case even
    case horizontalAlign
}

class RadarChartView: UIView {

    private var models: [RadarChartSectionModel] = []
    private var sectionLayout: SectionLayout = .horizontalAlign
    private var sectionGrayColor: CGColor = UIColor.radarChartGray.cgColor
    private var verticalMargin: CGFloat = 6
    private var marginAngle = 10 * CGFloat.pi / 180

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.red
    }

    override func draw(_ rect: CGRect) {
        drawSections()
    }

    func configure(with models: [RadarChartSectionModel],
                   sectionLayout: SectionLayout = .horizontalAlign,
                   sectionDefaultColor: UIColor = UIColor.radarChartGray,
                   verticalMargin: CGFloat = 6,
                   marginAngle: CGFloat = 10 * CGFloat.pi / 180
                   ) {
        self.models = models
        self.sectionLayout = sectionLayout
        self.sectionGrayColor = sectionDefaultColor.cgColor
        self.verticalMargin = verticalMargin
        self.marginAngle = marginAngle
    }

    private func drawSections() {
        switch sectionLayout {
        case .even:
            drawSectionsForEvenLayout()
        case .horizontalAlign:
            drawSectionsForHorizontalAlignLayout()
        }
    }

    private func drawSectionsForHorizontalAlignLayout() {
        guard models.count != 0 else { return }

        let arcCenterAbove = CGPoint(x: bounds.width / 2, y: bounds.height / 2 - verticalMargin / 2)
        let arcCenterBelow = CGPoint(x: bounds.width / 2, y: bounds.height / 2 + verticalMargin / 2)
        let deltaAngle = (degree2angle(360) - (CGFloat(models.count - 2) * marginAngle)) / CGFloat(models.count)

        // sections below
        for i in 1...models.count / 2 {
            let startAngle = CGFloat(i - 1) * (marginAngle + deltaAngle)
            let endAngle = startAngle + deltaAngle
            drawSection(model: models[i - 1], arcCenter: arcCenterBelow, sectionColor: UIColor.orange.cgColor, startAngle: startAngle, endAngle: endAngle)
        }

        // sections above
        for i in 1...models.count / 2 {
            let startAngle = degree2angle(180) + CGFloat(i - 1) * (deltaAngle + marginAngle)
            let endAngle = startAngle + deltaAngle
            drawSection(model: models[i - 1 + models.count / 2], arcCenter: arcCenterAbove, sectionColor: UIColor.orange.cgColor, startAngle: startAngle, endAngle: endAngle)
        }
    }

    private func drawSectionsForEvenLayout() {
        guard models.count != 0 else { return }

        let deltaAngle = (degree2angle(360) - (CGFloat(models.count) * marginAngle)) / CGFloat(models.count)
        let arcCenter = CGPoint(x: bounds.width / 2, y: bounds.height / 2)

        for i in 1...models.count {
            let startAngle = marginAngle / 2 + CGFloat(i + 1) * (marginAngle + deltaAngle)
            let endAngle = startAngle + deltaAngle
            drawSection(model: models[i - 1], arcCenter: arcCenter, sectionColor: UIColor.orange.cgColor, startAngle: startAngle, endAngle: endAngle)
        }
    }

    private func drawSection(model: RadarChartSectionModel, arcCenter: CGPoint, sectionColor: CGColor, startAngle: CGFloat, endAngle: CGFloat) {
        let initRadius: CGFloat = 20
        let lineWidth: CGFloat = 10
        let lineMargin: CGFloat = 4

        for i in 1...model.maximumValue {
            let radiusForLine = initRadius + (lineWidth + lineMargin) * CGFloat(i - 1)
            let circlePath = UIBezierPath(arcCenter: arcCenter, radius: radiusForLine, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = i <= model.currentValue ? sectionColor : sectionGrayColor
            shapeLayer.lineWidth = lineWidth
            layer.addSublayer(shapeLayer)
        }
    }

    private func degree2angle(_ degree: CGFloat) -> CGFloat {
        return degree * CGFloat.pi / 180
    }
}
