//
//  TKBarChartModel.swift
//  TKChartView
//
//  Created by caanvu on 2020/4/7.
//

import UIKit

public struct TKBarChartModel {

    let topText: String

    let bottomText: String
    /// 0.0 ~ 1.0
    let heightRadio: Double
    public init(topText:String,bottomText:String,heightRadio:Double) {
        self.topText = topText
        self.bottomText = bottomText
        self.heightRadio = heightRadio
    }
}
