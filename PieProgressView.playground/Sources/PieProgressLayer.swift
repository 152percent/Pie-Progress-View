//
//  PieLayer.swift
//  PieView
//
//  Created by Shaps Benkau on 20/05/2018.
//  Copyright © 2018 152percent Ltd. All rights reserved.
//

import QuartzCore

#if os(OSX)
    import AppKit
    public typealias Color = NSColor
    private func scale() -> CGFloat {
        return NSScreen.main?.backingScaleFactor ?? 1
    }
#else
    import UIKit
    public typealias Color = UIColor
    internal func scale() -> CGFloat {
        return UIScreen.main.scale
    }
#endif

internal final class PieProgressLayer: CALayer {

    @NSManaged internal var progress: CGFloat
    @NSManaged internal var margin: CGFloat
    @NSManaged internal var color: CGColor

    internal override init() {
        super.init()
        contentsScale = scale()
    }

    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentsScale = scale()
    }

    internal override init(layer: Any) {
        super.init(layer: layer)
        guard let layer = layer as? PieProgressLayer else { return }

        progress = layer.progress
        margin = layer.margin
        color = layer.color
        contentsScale = layer.contentsScale
    }

    internal override class func defaultValue(forKey key: String) -> Any? {
        switch key {
        case #keyPath(progress): return 0
        case #keyPath(margin): return 3
        case #keyPath(color): return Color.lightGray.cgColor
        default: return super.defaultValue(forKey: key)
        }
    }

    internal override func action(forKey key: String) -> CAAction? {
        let animation = CABasicAnimation(keyPath: key)
        animation.fromValue = presentation()?.value(forKey: key)

        switch key {
        case #keyPath(progress):
            animation.duration = 0.5
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        default: return super.action(forKey: key)
        }

        return animation
    }

    internal override class func needsDisplay(forKey key: String) -> Bool {
        guard key == #keyPath(progress)
            || key == #keyPath(margin)
            || key == #keyPath(color) else {
            return super.needsDisplay(forKey: key)
        }

        return true
    }

    internal override func draw(in ctx: CGContext) {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = bounds.width / 2 - margin
        let startAngle: CGFloat = -90
        let endAngle = 360 * progress - 90

        ctx.beginPath()
        ctx.move(to: center)
        ctx.addArc(center: center, radius: radius, startAngle: startAngle.radians(), endAngle: endAngle.radians(), clockwise: false)
        ctx.closePath()

        ctx.setFillColor(color)
        ctx.fillPath()
    }

}
