//
//  UIBezierPath+Pie.swift
//  PieView
//
//  Created by Shaps Benkau on 20/05/2018.
//  Copyright © 2018 152percent Ltd. All rights reserved.
//

import CoreGraphics

internal extension CGFloat {
    func radians() -> CGFloat {
        let b = CGFloat.pi * (self / 180)
        return b
    }
}
