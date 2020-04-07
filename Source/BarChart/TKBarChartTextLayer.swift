//
//  TKBarChartTextLayer.swift
//  TKChartView
//
//  Created by caanvu on 2020/4/7.
//

import UIKit

open class TKBarChartTextLayer: CATextLayer {
    /// Let layer text in center
    ///
    /// - Parameter ctx: <#ctx description#>
    open override func draw(in ctx: CGContext) {
        let height = self.bounds.size.height
        let fontSize = self.fontSize
        let yDiff = (height-fontSize)/2 - fontSize/10
        
        ctx.saveGState()
        ctx.translateBy(x: 0, y: yDiff) // Use -yDiff when in non-flipped coordinates (like macOS's default)
        super.draw(in: ctx)
        ctx.restoreGState()
    }
}
