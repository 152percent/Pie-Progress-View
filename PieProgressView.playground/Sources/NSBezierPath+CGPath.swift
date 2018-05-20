//
//  NSBezierPath+CGPath.swift
//  PieView
//
//  Created by Shaps Benkau on 20/05/2018.
//  Copyright © 2018 152percent Ltd. All rights reserved.
//

#if os(OSX)
import AppKit

public extension NSBezierPath {

    var cgPath: CGPath {
        let path = CGMutablePath()
        let points = NSPointArray.allocate(capacity: 3)

        for i in 0 ..< elementCount {
            let type = element(at: i, associatedPoints: points)
            switch type {
            case .moveToBezierPathElement:
                path.move(to: points[0])
            case .lineToBezierPathElement:
                path.addLine(to: points[0])
            case .curveToBezierPathElement:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePathBezierPathElement:
                path.closeSubpath()
            }
        }
        return path
    }

}
#endif
