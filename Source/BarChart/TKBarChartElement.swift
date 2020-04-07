//
//  TKBarChartElement.swift
//  TKChartView
//
//  Created by caanvu on 2020/4/7.
//

import UIKit

open class TKBarChartElement: CALayer {
    var barModel: TKBarChartModel

    var topTextHeight: CGFloat = 15

    var topTextSpace: CGFloat = 5

    var topTextWidth: CGFloat = 35

    var bottomTextHeight: CGFloat = 20
    
    var animationDuration = 1.0
    
    var animated = true
    
    let rectangleLayer = CAGradientLayer()
    let topTextLayer = createTextLayer(color: UIColor.lightGray.cgColor, fontSize: 9.0)
    let bottomTextLayer = createTextLayer(color: UIColor.lightGray.cgColor, fontSize: 12.0)
    var barFrame: CGRect = .zero
    var barColors: [UIColor] = []
    var topTextColor = UIColor.lightGray
    var topTextBackgroundColor = UIColor.white
    var bottomTextColor = UIColor.lightGray
    override init() {
        self.barModel = TKBarChartModel(topText: "", bottomText: "", heightRadio: 1.0)
        super.init()
        setupUI()
    }
    init(model:TKBarChartModel) {
        self.barModel = model
        super.init()
        setupUI()
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(layer: Any) {
        self.barModel = TKBarChartModel(topText: "", bottomText: "", heightRadio: 1.0)
        super.init(layer: layer)
    }

    func setupUI() {
        self.topTextLayer.backgroundColor = UIColor.white.cgColor
        self.topTextLayer.cornerRadius = 2.4
        self.topTextLayer.addCommonShadow(UIColor.lightGray)
        self.rectangleLayer.startPoint = CGPoint(x: 0.5, y: 0)
        self.rectangleLayer.endPoint = CGPoint(x: 0.5, y: 1)
        self.addSublayer(topTextLayer)
        self.addSublayer(rectangleLayer)
        self.addSublayer(bottomTextLayer)
    }
    func updateColor(barColors:[UIColor],topTextColor:UIColor,topTextBackgroundColor:UIColor,bottomTextColor:UIColor) {
        self.barColors = barColors
        self.topTextColor = topTextColor
        self.topTextBackgroundColor = topTextBackgroundColor
        self.bottomTextColor = bottomTextColor
    }
    
    func updateFrame(index: Int, height: CGFloat, barSpace: CGFloat, barWidth: CGFloat) {
        self.frame = CGRect(x: CGFloat(index) * (barWidth + barSpace), y: 0.0, width: barSpace + barWidth, height: height)
        let barHeight = CGFloat(self.barModel.heightRadio) * (height - topTextHeight - topTextSpace - bottomTextHeight)
        self.rectangleLayer.frame = CGRect(x: barSpace/2.0 , y: height - barHeight - bottomTextHeight, width: barWidth, height: barHeight)
        self.rectangleLayer.colors = barColors.map{ $0.cgColor }
        self.rectangleLayer.cornerRadius = barWidth/2.0
        
        //        self.topTextLayer.frame = CGRect(x: topTextSpace/2.0, y: self.rectangleLayer.frame.origin.y - topTextHeight - topTextSpace, width: self.frame.width - topTextSpace, height: topTextHeight)
        self.topTextLayer.frame = CGRect(x: (self.frame.width - topTextWidth) / 2.0 , y: self.rectangleLayer.frame.origin.y - topTextHeight - topTextSpace, width: topTextWidth, height: topTextHeight)
        self.topTextLayer.string = self.barModel.topText
        self.topTextLayer.backgroundColor = topTextBackgroundColor.cgColor
        self.topTextLayer.foregroundColor = topTextColor.cgColor

        self.bottomTextLayer.frame = CGRect(x: 0.0, y: self.frame.height - bottomTextHeight, width: self.frame.width, height: bottomTextHeight)
        self.bottomTextLayer.string = self.barModel.bottomText
        if self.animated {
            // 初始化状态给个默认值
            if barFrame == CGRect.zero {
                let rect = self.rectangleLayer.frame
                barFrame = CGRect(x: rect.origin.x, y: rect.maxY, width: rect.size.width, height: 0.0)
            }
            self.startAnimation()
        }
        barFrame = self.rectangleLayer.frame
    }

    func startAnimation() {
        let textFromPosition = CGPoint(x: barFrame.midX, y: barFrame.minY - topTextSpace - topTextHeight/2.0)
        self.animate(layer: self.topTextLayer, fromValue: textFromPosition, toValue: self.topTextLayer.position, keyPath: "position")
        
        let rectFromPosition = CGPoint(x: barFrame.midX, y: barFrame.midY)
        self.animate(layer: self.rectangleLayer, fromValue: rectFromPosition, toValue: self.rectangleLayer.position, keyPath: "position")
        
        let fromRect = CGRect(x: 0, y: 0, width: barFrame.size.width, height: barFrame.size.height)
        self.animate(layer: self.rectangleLayer, fromValue: fromRect, toValue: self.rectangleLayer.bounds, keyPath: "bounds")
    }
    
    func animate(layer:CALayer, fromValue: Any , toValue: Any, keyPath: String) {
        let anim = CABasicAnimation(keyPath: keyPath)
        anim.fromValue = fromValue
        anim.toValue = toValue
        anim.duration = animationDuration
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        layer.add(anim, forKey: keyPath)
    }
}
internal extension CALayer {
    func addCommonShadow(_ color: UIColor) {
        self.masksToBounds = false
        self.shadowColor = color.cgColor
        self.shadowOffset = CGSize(width: 0.5, height: 1.0)
        self.shadowOpacity = 1.0
        self.shadowRadius = 2.4
    }
    class func createTextLayer(color: CGColor, fontSize: CGFloat) -> TKBarChartTextLayer {
        let textLayer = TKBarChartTextLayer()
        textLayer.foregroundColor = color
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.contentsScale = UIScreen.main.scale
        let font = UIFont.systemFont(ofSize: fontSize)
        textLayer.font = font
        textLayer.truncationMode = .start
        textLayer.fontSize = font.pointSize
        return textLayer
    }
}
