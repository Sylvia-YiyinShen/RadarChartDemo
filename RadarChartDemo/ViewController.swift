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
        smallRadarChartView.configure(with: smallRadarChartModels2,
                                      sectionLayout: .even,
                                      borderColor: UIColor.radarChartRed)
    }

    private var smallRadarChartModels: [RadarChartSectionModel] {
        return [
            RadarChartSectionModel(currentValue: 8, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_build", sectionName: "Build"),
            RadarChartSectionModel(currentValue: 5, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_create", sectionName: "Create"),
            RadarChartSectionModel(currentValue: 3, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_feedback", sectionName: "Feedback"),
            RadarChartSectionModel(currentValue: 7, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_hourglass", sectionName: "Hourglass"),
            RadarChartSectionModel(currentValue: 4, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_pan", sectionName: "Pan"),
            RadarChartSectionModel(currentValue: 6, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_search", sectionName: "Search")
        ]
    }

    private var smallRadarChartModels2: [RadarChartSectionModel] {
        return [
            RadarChartSectionModel(currentValue: 8, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_build", sectionName: "Build"),
            RadarChartSectionModel(currentValue: 5, maximumValue: 10, sectionColor: UIColor.blue, iconName: "icon_create", sectionName: "Create"),
            RadarChartSectionModel(currentValue: 3, maximumValue: 10, sectionColor: UIColor.black, iconName: "icon_feedback", sectionName: "Feedback"),
            RadarChartSectionModel(currentValue: 7, maximumValue: 10, sectionColor: UIColor.radarChartRed, iconName: "icon_hourglass", sectionName: "Hourglass"),
            RadarChartSectionModel(currentValue: 4, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_pan", sectionName: "Pan"),
            RadarChartSectionModel(currentValue: 6, maximumValue: 10, sectionColor: UIColor.blue, iconName: "icon_search", sectionName: "Search"),
            RadarChartSectionModel(currentValue: 10, maximumValue: 10, sectionColor: UIColor.black, iconName: "icon_visibility", sectionName: "Visibility"),
            RadarChartSectionModel(currentValue: 5, maximumValue: 10, sectionColor: UIColor.radarChartRed, iconName: "icon_voice", sectionName: "Voice")
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
            RadarChartSectionModel(currentValue: 8, maximumValue: 10, sectionColor: UIColor.radarChartRed, iconName: "icon_build", sectionName: "Build"),
            RadarChartSectionModel(currentValue: 5, maximumValue: 10, sectionColor: UIColor.radarChartRed, iconName: "icon_create", sectionName: "Create"),
            RadarChartSectionModel(currentValue: 3, maximumValue: 10, sectionColor: UIColor.radarChartRed, iconName: "icon_feedback", sectionName: "Feedback"),
            RadarChartSectionModel(currentValue: 7, maximumValue: 10, sectionColor: UIColor.radarChartRed, iconName: "icon_hourglass", sectionName: "Hourglass"),
            RadarChartSectionModel(currentValue: 4, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_pan", sectionName: "Pan"),
            RadarChartSectionModel(currentValue: 6, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_search", sectionName: "Search"),
            RadarChartSectionModel(currentValue: 10, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_visibility", sectionName: "Visibility"),
            RadarChartSectionModel(currentValue: 5, maximumValue: 10, sectionColor: UIColor.orange, iconName: "icon_voice", sectionName: "Voice")
        ]
    }
}

