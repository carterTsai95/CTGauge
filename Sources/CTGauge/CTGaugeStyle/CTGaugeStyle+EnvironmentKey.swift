//
//  GaugeStyle+EnvironmentKey.swift
//  PostureGuard
//
//  Created by Hung-Chun Tsai on 2023-03-19.
//

import SwiftUI

/**
An environment key for passing the CTGaugeStyle through the environment.

This key allows the CTGaugeStyle to be passed down the SwiftUI view hierarchy using the environment.
*/
struct CTGaugeStyleKey: EnvironmentKey {
    static var defaultValue = AnyCTGaugeStyle(style: DefaultCTGaugeStyle())
}

struct CTGaugeForegroundKey: EnvironmentKey {
    static var defaultValue: AnyShapeStyle = AnyShapeStyle(.black)
}

struct CTGaugeInicatorColorKey: EnvironmentKey {
    static var defaultValue: Color = .white
}

struct CTGaugeNeedleIndicatorColorKey: EnvironmentKey {
    static var defaultValue: Color = .black
}

/**
An extension of the EnvironmentValues struct to include the CTGaugeStyle and custom configuration environment key.
*/
extension EnvironmentValues {
    var ctGaugeStyle: AnyCTGaugeStyle {
        get { self[CTGaugeStyleKey.self] }
        set { self[CTGaugeStyleKey.self] = newValue }
    }

    var ctGaugeIndicatorColor: Color {
        get { self[CTGaugeInicatorColorKey.self] }
        set { self[CTGaugeInicatorColorKey.self] = newValue }
    }

    var ctForegroundColor: AnyShapeStyle {
        get { self[CTGaugeForegroundKey.self] }
        set { self[CTGaugeForegroundKey.self] = newValue }
    }

    var ctNeedleIndicatorColor: Color {
        get { self[CTGaugeNeedleIndicatorColorKey.self] }
        set { self[CTGaugeNeedleIndicatorColorKey.self] = newValue }
    }
}
