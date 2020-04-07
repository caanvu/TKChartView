//
//  ViewController.swift
//  Demo
//
//  Created by 吴炜 on 2020/4/7.
//

import UIKit
import TKChartView
class ViewController: UIViewController {
    
    @IBOutlet weak var chartView: TKBarChartView!
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        chartView.updateDatas(barModels: createRandomData(),yAxisTexts: ["100","50"])
        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(repeatTest), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
        let barView = TKBarChartView()
        let barModels = [TKBarChartModel(topText: "10", bottomText: "4.1", heightRadio: 0.5)
            ,TKBarChartModel(topText: "20", bottomText: "4.2", heightRadio: 1.0),
             TKBarChartModel(topText: "10", bottomText: "4.1", heightRadio: 0.1)
        ]
        barView.updateDatas(barModels: barModels)
    }
    @objc func repeatTest() {
        chartView.updateDatas(barModels: self.createRandomData())
    }
    
    func createRandomData() -> [TKBarChartModel] {
        var result: [TKBarChartModel] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "M.dd"
        for i in 0..<7 {
            let value = (arc4random() % 90) + 10
            let height: Double = Double(value) / 100.0
            
            var date = Date()
            date.addTimeInterval(TimeInterval(24*60*60*i))
            result.append(TKBarChartModel(topText: "\(value)", bottomText: formatter.string(from: date), heightRadio: height))
        }
        return result
    }
    
    
}

