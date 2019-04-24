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
    private var sectionLayout: SectionLayout = .even
    private var sectionGrayColor: CGColor = UIColor.radarChartGray.cgColor
    private var verticalMargin: CGFloat = 0
    private var marginAngle: CGFloat = 0 

    private var borderColor: CGColor = UIColor.radarChartGray.cgColor
    private var borderAboveColor: CGColor = UIColor.radarChartGray.cgColor
    private var borderBelowColor: CGColor = UIColor.radarChartGray.cgColor
    private var borderEnabled: Bool = true
    private var borderWidth: CGFloat = 0
    private var iconLength: CGFloat = 0

    override func draw(_ rect: CGRect) {
        drawSections()
    }

    func configure(with models: [RadarChartSectionModel],
                   sectionLayout: SectionLayout = .even,
                   sectionDefaultColor: UIColor = UIColor.radarChartGray,
                   verticalMargin: CGFloat? = nil,
                   marginAngle: CGFloat? = nil,
                   borderEnabled: Bool = true,
                   borderWidth: CGFloat? = nil,
                   borderColor: UIColor? = nil,
                   borderAboveColor: UIColor? = nil,
                   borderBelowColor: UIColor? = nil,
                   iconLength: CGFloat? = nil
                   ) {
        self.models = models
        self.sectionLayout = sectionLayout
        self.sectionGrayColor = sectionDefaultColor.cgColor
        self.verticalMargin = verticalMargin ?? 6 * bounds.width / 375
        self.marginAngle = marginAngle ?? 8 * CGFloat.pi / 180
        self.borderWidth = borderWidth ?? 12 * bounds.width / 375
        self.borderColor = borderColor?.cgColor ?? UIColor.radarChartGray.cgColor
        self.borderAboveColor = borderAboveColor?.cgColor ?? UIColor.radarChartGray.cgColor
        self.borderBelowColor = borderBelowColor?.cgColor ?? UIColor.radarChartGray.cgColor
        self.borderEnabled = borderEnabled
        self.iconLength = iconLength ?? 25 * bounds.width / 375
    }

    private func drawSections() {
        switch sectionLayout {
        case .even:
            drawSectionsForEvenLayout()
        case .horizontalAlign:
            drawSectionsForHorizontalAlignLayout()
        }
    }

    private func drawBorderForEvenLayout() {
        let radius = (bounds.width - borderWidth) / CGFloat(2)
        let arcCenter = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let circlePath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = borderColor
        shapeLayer.lineWidth = borderWidth
        layer.addSublayer(shapeLayer)
    }

    private func drawBorderForHorizontalAlignLayout(arcCenterAbove: CGPoint, arcCenterBelow: CGPoint) {
        let radius = (bounds.width - borderWidth) / CGFloat(2)

        // border above
        let circlePathAbove = UIBezierPath(arcCenter: arcCenterAbove, radius: radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
        let shapeLayerAbove = CAShapeLayer()
        shapeLayerAbove.path = circlePathAbove.cgPath
        shapeLayerAbove.fillColor = UIColor.clear.cgColor
        shapeLayerAbove.strokeColor = borderAboveColor
        shapeLayerAbove.lineWidth = borderWidth
        layer.addSublayer(shapeLayerAbove)

        // border below
        let circlePathBelow = UIBezierPath(arcCenter: arcCenterBelow, radius: radius, startAngle: 0, endAngle: CGFloat.pi, clockwise: true)
        let shapeLayerBelow = CAShapeLayer()
        shapeLayerBelow.path = circlePathBelow.cgPath
        shapeLayerBelow.fillColor = UIColor.clear.cgColor
        shapeLayerBelow.strokeColor = borderBelowColor
        shapeLayerBelow.lineWidth = borderWidth
        layer.addSublayer(shapeLayerBelow)
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
            drawSection(model: models[i - 1], arcCenter: arcCenterBelow, startAngle: startAngle, endAngle: endAngle)
        }

        // sections above
        for i in 1...models.count / 2 {
            let startAngle = degree2angle(180) + CGFloat(i - 1) * (deltaAngle + marginAngle)
            let endAngle = startAngle + deltaAngle
            drawSection(model: models[i - 1 + models.count / 2], arcCenter: arcCenterAbove, startAngle: startAngle, endAngle: endAngle)
        }

        if borderEnabled {
            drawBorderForHorizontalAlignLayout(arcCenterAbove: arcCenterAbove, arcCenterBelow: arcCenterBelow)
        }
    }

    private func drawSectionsForEvenLayout() {
        guard models.count != 0 else { return }

        let deltaAngle = (degree2angle(360) - (CGFloat(models.count) * marginAngle)) / CGFloat(models.count)
        let arcCenter = CGPoint(x: bounds.width / 2, y: bounds.height / 2)

        for i in 1...models.count {
            let startAngle = marginAngle / 2 + CGFloat(i + 1) * (marginAngle + deltaAngle)
            let endAngle = startAngle + deltaAngle
            drawSection(model: models[i - 1], arcCenter: arcCenter, startAngle: startAngle, endAngle: endAngle)
        }

        if borderEnabled {
            drawBorderForEvenLayout()
        }
    }

    private func drawSection(model: RadarChartSectionModel, arcCenter: CGPoint, startAngle: CGFloat, endAngle: CGFloat) {

        let icon = UIImageView(image: UIImage(named: model.iconName))
        icon.setImageColor(color:model.sectionColor)
        icon.contentMode = .scaleAspectFill
        let angle = (startAngle + endAngle) / 2
        let iconRadius = borderEnabled ? (bounds.width) / 2 - borderWidth - iconLength * sqrt(2) / 2 : bounds.width / 2 - iconLength * sqrt(2) / 2
        let iconCenter = CGPoint(x: arcCenter.x + cos(angle) * iconRadius, y: arcCenter.y + iconRadius * sin(angle))
        icon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(icon)
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: iconLength),
            icon.heightAnchor.constraint(equalToConstant: iconLength),
            icon.centerXAnchor.constraint(equalTo: leftAnchor, constant: iconCenter.x),
            icon.centerYAnchor.constraint(equalTo: topAnchor, constant: iconCenter.y)])


        let maxRadius: CGFloat = iconRadius - iconLength * sqrt(2) / 3
        let minRadius: CGFloat = 25 * bounds.width / 375
        let marginWidthRate: CGFloat = 0.4
        let lineWidth: CGFloat = (maxRadius - minRadius) / CGFloat(model.maximumValue) / (CGFloat(1) + marginWidthRate)
        let lineMargin: CGFloat = marginWidthRate * lineWidth

        for i in 1...model.maximumValue {
            let radiusForLine = minRadius + (lineWidth + lineMargin) * CGFloat(i - 1)
            let circlePath = UIBezierPath(arcCenter: arcCenter, radius: radiusForLine, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = i <= model.currentValue ? model.sectionColor.cgColor : sectionGrayColor
            shapeLayer.lineWidth = lineWidth
            layer.addSublayer(shapeLayer)
        }
    }

    private func degree2angle(_ degree: CGFloat) -> CGFloat {
        return degree * CGFloat.pi / 180
    }
}
