//
//  CTGauge+ViewExtension.swift
//  PostureGuard
//
//  Created by Hung-Chun Tsai on 2023-03-19.
//

import SwiftUI

public extension View {
    func ctGaugeStyle<S: CTGaugeStyle>(_ style: S) -> some View {
        environment(\.ctGaugeStyle, AnyCTGaugeStyle(style: style))
    }
    func ctGaugeForegroundColor(_ color: any ShapeStyle) -> some View {
        environment(\.ctForegroundColor, AnyShapeStyle(color))
    }

    func ctIndicatorColor(_ color: any ShapeStyle) -> some View {
        environment(\.ctGaugeIndicatorColor, AnyShapeStyle(color))
    }

    func ctNeedleColor(_ color: any ShapeStyle) -> some View {
        environment(\.ctNeedleIndicatorColor, AnyShapeStyle(color))
    }
}
