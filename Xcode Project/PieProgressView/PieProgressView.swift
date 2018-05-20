//
//  PieView.swift
//  PieView
//
//  Created by Shaps Benkau on 20/05/2018.
//  Copyright © 2018 152percent Ltd. All rights reserved.
//

#if os(OSX)
import AppKit
public typealias View = NSView

extension NSView {
    internal var nonOptionalLayer: CALayer {
        return layer!
    }
}
#else
import UIKit
public typealias View = UIView

extension UIView {
    internal var nonOptionalLayer: CALayer {
        return layer
    }
}
#endif

@IBDesignable
public final class PieProgressView: View {

    @IBInspectable
    public var progress: CGFloat = 0 {
        didSet { invalidate() }
    }

    @IBInspectable
    public var strokeThickness: CGFloat = 1 {
        didSet { invalidate() }
    }

    @IBInspectable
    public var margin: CGFloat = 4 {
        didSet { invalidate() }
    }

    #if os(OSX)
    @IBInspectable
    public var color: NSColor = .lightGray {
        didSet { invalidate() }
    }
    #else
    @IBInspectable
    public var color: UIColor = .lightGray {
        didSet { invalidate() }
    }
    #endif

    private var progressLayer: PieProgressLayer!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    #if os(OSX)
    public override var isFlipped: Bool {
        return true
    }

    public override func layout() {
        super.layout()
        progressLayer.frame = bounds
        invalidate()
    }
    #else
    public override func layoutSubviews() {
        super.layoutSubviews()
        progressLayer.frame = bounds
        invalidate()
    }
    #endif

}

extension PieProgressView {

    private func commonInit() {
        #if os(OSX)
        wantsLayer = true
        #endif

        progressLayer = PieProgressLayer()
        nonOptionalLayer.addSublayer(progressLayer)

        invalidate()
    }

    private func invalidate() {
        nonOptionalLayer.borderColor = color.cgColor
        nonOptionalLayer.borderWidth = strokeThickness
        nonOptionalLayer.cornerRadius = bounds.width / 2
        progressLayer.color = color.cgColor
        progressLayer.progress = progress
        progressLayer.margin = margin
    }

}
