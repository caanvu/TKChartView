//
//  TKBarChartView.swift
//  TKChartView
//
//  Created by caanvu on 2020/4/7.
//

import UIKit

open class TKBarChartView: UIView {

    private let mainLayer = CALayer()

    var barsLayers: [TKBarChartElement] = []
    private var yAxis: [String] = [] {
        didSet {
            updateYTextLayers()
        }
    }
    private var yTextLayers: [TKBarChartTextLayer] = []

    open var barWidth:CGFloat = 7.0

    open var barSpace:CGFloat = 20.0
//    var isShowYAxis = false
    open var yAxisWidth: CGFloat = 40
    open var barColors: [UIColor] = [UIColor(red: 254/255.0, green: 179/255.0, blue: 128/255.0, alpha: 1.0),
                                     UIColor(red: 254/255.0, green: 92/255.0, blue: 92/255.0, alpha: 1.0)]
    open var topTextColor = UIColor.white
    open var topTextBackgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 157/255.0, alpha: 1.0)
    open var bottomTextColor = UIColor.lightGray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        layer.addSublayer(mainLayer)
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }

    func updateUI() {
        let height = self.frame.size.height
        let width = yAxis.count > 0 ? self.frame.size.width - yAxisWidth: self.frame.size.width
        let count = self.barsLayers.count
        barSpace = (width - CGFloat(count) * barWidth) / CGFloat(count)
        mainLayer.frame = CGRect(x: yAxis.count > 0 ? yAxisWidth: 0, y: 0, width: width, height: height)
        for (index, item) in barsLayers.enumerated() {
            item.updateColor(barColors: barColors, topTextColor: topTextColor, topTextBackgroundColor: topTextBackgroundColor, bottomTextColor: bottomTextColor)
            item.updateFrame(index: index, height: height, barSpace: barSpace, barWidth: barWidth)
        }
        if yTextLayers.count > 0 {
            let yTextHeight = (height - 10.0) / CGFloat(yTextLayers.count)
            for index in 0 ..< yTextLayers.count {
                yTextLayers[index].frame = CGRect(x: 0 , y: yTextHeight * CGFloat(index), width: yAxisWidth, height: yTextHeight)
            }
        }
    }
    func updateYTextLayers() {
        yTextLayers.forEach { (value) in
            value.removeFromSuperlayer()
        }
        yTextLayers.removeAll()
        for item in yAxis {
            let value = CALayer.createTextLayer(color: UIColor.lightGray.cgColor, fontSize: 12)
            value.string = item
            layer.addSublayer(value)
            yTextLayers.append(value)
        }
    }

    public func updateDatas(barModels: [TKBarChartModel],yAxisTexts:[String]? = nil) {
        for (index,item) in barModels.enumerated() {
            if index < barsLayers.count {
                barsLayers[index].barModel = item
            } else {
                let barLayer = TKBarChartElement(model: item)
                barsLayers.append(barLayer)
                mainLayer.addSublayer(barLayer)
            }
        }
        if let value = yAxisTexts {
            yAxis = value
        }
        setNeedsLayout()
    }
    
    public func refreshDataWithValues(barModels: [TKBarChartModel],yAxisTexts:[String]? = nil) {
        for item in barsLayers {
            item.removeFromSuperlayer()
        }
        barsLayers.removeAll()
        updateDatas(barModels: barModels,yAxisTexts: yAxisTexts)
    }
}
