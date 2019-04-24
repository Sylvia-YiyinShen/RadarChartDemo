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
    var sectionGrayColor = UIColor(displayP3Red: 219 / 255, green: 221 / 255, blue: 220 / 255, alpha: 1.0).cgColor
    var numOfSections = 10
    var marginAngle = 10 * CGFloat.pi / 180
    var verticalMargin: CGFloat = 6
    var sectionLayout: SectionLayout = .horizontalAlign

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func draw(_ rect: CGRect) {
        drawSections()
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
        let arcCenterAbove = CGPoint(x: bounds.width / 2, y: bounds.height / 2 - verticalMargin / 2)
        let arcCenterBelow = CGPoint(x: bounds.width / 2, y: bounds.height / 2 + verticalMargin / 2)
        let deltaAngle = (degree2angle(360) - (CGFloat(numOfSections - 2) * marginAngle)) / CGFloat(numOfSections)
        // sections below
        for i in 1...numOfSections / 2 {
            let startAngle = CGFloat(i - 1) * (marginAngle + deltaAngle)
            let endAngle = startAngle + deltaAngle
            drawSection(arcCenter: arcCenterBelow, sectionColor: UIColor.orange.cgColor, startAngle: startAngle, endAngle: endAngle)
        }

        // sections above
        for i in 1...numOfSections / 2 {
            let startAngle = degree2angle(180) + CGFloat(i - 1) * (deltaAngle + marginAngle)
            let endAngle = startAngle + deltaAngle
            drawSection(arcCenter: arcCenterAbove, sectionColor: UIColor.orange.cgColor, startAngle: startAngle, endAngle: endAngle)
        }

    }

    private func drawSectionsForEvenLayout() {
        let deltaAngle = (degree2angle(360) - (CGFloat(numOfSections) * marginAngle)) / CGFloat(numOfSections)
        let arcCenter = CGPoint(x: bounds.width / 2, y: bounds.height / 2)

        for i in 1...numOfSections {
            let startAngle = marginAngle / 2 + CGFloat(i + 1) * (marginAngle + deltaAngle)
            let endAngle = startAngle + deltaAngle
            drawSection(arcCenter: arcCenter, sectionColor: UIColor.orange.cgColor, startAngle: startAngle, endAngle: endAngle)
        }
    }

    private func drawSection(arcCenter: CGPoint, sectionColor: CGColor, startAngle: CGFloat, endAngle: CGFloat) {
        drawLinesInSection(arcCenter: arcCenter, sectionColor: sectionColor, startAngle: startAngle, endAngle: endAngle)
    }

    private func drawLinesInSection(arcCenter: CGPoint, sectionColor: CGColor, startAngle: CGFloat, endAngle: CGFloat) {
        let initRadius: CGFloat = 20
        let lineWidth: CGFloat = 8
        let lineMargin: CGFloat = 4

        let maxValue = 10
        let curValue = 8

        for i in 1...maxValue {
            let radiusForLine = initRadius + (lineWidth + lineMargin) * CGFloat(i - 1)
            let circlePath = UIBezierPath(arcCenter: arcCenter, radius: radiusForLine, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = i <= curValue ? sectionColor : sectionGrayColor
            shapeLayer.lineWidth = lineWidth
            layer.addSublayer(shapeLayer)
        }
    }

    private func degree2angle(_ degree: CGFloat) -> CGFloat {
        return degree * CGFloat.pi / 180
    }
}
