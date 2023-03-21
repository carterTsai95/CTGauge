//
//  CGFloat+Extension.swift
//  PostureGuard
//
//  Created by Hung-Chun Tsai on 2023-03-16.
//

import Foundation

public extension CGFloat {
    static func degreesToRadians(_ degrees: Double) -> CGFloat {
        return degrees * .pi / 180.0
    }
}
