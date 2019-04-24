//
//  ViewController.swift
//  RadarChartDemo
//
//  Created by Yiyin Shen on 24/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var radarChartView: RadarChartView!
    @IBOutlet weak var smallRadarChartView: RadarChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureRadarChart()
        configureSmallRaderChart()
    }

    private func configureSmallRaderChart() {
        smallRadarChartView.configure(with: smallRadarChartModels,
                                      sectionLayout: .even,
                                      borderColor: UIColor.orange)
    }

    private var smallRadarChartModels: [RadarChartSectionModel] {
        return [
            RadarChartSectionModel(currentValue: 8, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_build"),
            RadarChartSectionModel(currentValue: 5, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_create"),
            RadarChartSectionModel(currentValue: 3, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_feedback"),
            RadarChartSectionModel(currentValue: 7, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_hourglass"),
            RadarChartSectionModel(currentValue: 4, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_pan"),
            RadarChartSectionModel(currentValue: 6, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_search")
        ]
    }

    private func configureRadarChart() {
        radarChartView.configure(with: radarChartModels,
                                 sectionLayout: .horizontalAlign,
                                 borderAboveColor: UIColor.orange,
                                 borderBelowColor: UIColor.radarChartRed)
    }

    private var radarChartModels: [RadarChartSectionModel] {
        return [
            RadarChartSectionModel(currentValue: 8, maximumValue: 10, sectionColor: UIColor.radarChartRed, iconName: "icon_build"),
            RadarChartSectionModel(currentValue: 5, maximumValue: 10, sectionColor: UIColor.radarChartRed, iconName: "icon_create"),
            RadarChartSectionModel(currentValue: 3, maximumValue: 10, sectionColor: UIColor.radarChartRed, iconName: "icon_feedback"),
            RadarChartSectionModel(currentValue: 7, maximumValue: 10, sectionColor: UIColor.radarChartRed, iconName: "icon_hourglass"),
            RadarChartSectionModel(currentValue: 4, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_pan"),
            RadarChartSectionModel(currentValue: 6, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_search"),
            RadarChartSectionModel(currentValue: 10, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_visibility"),
            RadarChartSectionModel(currentValue: 5, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_voice")
        ]
    }
}

