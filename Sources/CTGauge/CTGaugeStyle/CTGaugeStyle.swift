//
//  CTGaugeStyle.swift
//  PostureGuard
//
//  Created by Hung-Chun Tsai on 2023-03-19.
//

import Foundation
import SwiftUI

public protocol CTGaugeStyle {
    associatedtype Body: View
    typealias Configuration = CTGaugeStyleConfiguration
    
    func makeBody(configuration: Self.Configuration) -> Self.Body
}

public extension CTGaugeStyle where Self == CircularGaugeStyle {
    static var circularGauge: CircularGaugeStyle {
        get {
            CircularGaugeStyle()
        }
    }
}

public extension CTGaugeStyle where Self == NeedleGaugeStyle {
    static var needleGauge: NeedleGaugeStyle {
        get {
            NeedleGaugeStyle()
        }
    }
}
