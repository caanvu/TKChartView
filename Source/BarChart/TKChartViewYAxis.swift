//
//  TKChartViewYAxis.swift
//  TKChartView
//
//  Created by caanvu on 2020/4/7.
//

import UIKit

open class TKChartViewYAxis {
    var maxValue = 0
    var minValue = 0
    var distance = 0
    class func getChartViewValue(_ arr: [Int], yAxisCount : Int, min: Int? = nil) -> TKChartViewYAxis {
        let model = TKChartViewYAxis()
        var unit = 1
        if let min = arr.min(), let max = arr.max() {
            while unit < (max - min) / yAxisCount {
                unit *= 10
            }
            if unit >= 10 {
                unit /= 10
            }
            let value = unit
            while unit < (max - min) / yAxisCount {
                unit += value
            }
        }
        model.distance = unit
        model.minValue = Int.max
        model.maxValue = yAxisCount * model.distance
        if arr.count == 0 {
            model.minValue = 0
        }
        if let value = min {
            model.minValue = value
        }
        for item in arr {
            let value1 = Int(Float(item) * 1.2)
            let value2 = Int(Float(item) * 0.8) / unit * unit
            if model.maxValue < value1 {
                model.maxValue = value1
            }
            if item >= 0, model.minValue > value2 {
                model.minValue = value2
            }
        }
        
        while model.maxValue > model.minValue + (model.distance * (yAxisCount - 1)) {
            model.distance += unit
        }
        model.maxValue = model.minValue + (model.distance * (yAxisCount - 1))
        return model
    }
}
