//
//  CTGaugeStyle+DefaultGaugeStyle.swift
//  PostureGuard
//
//  Created by Hung-Chun Tsai on 2023-03-19.
//

import SwiftUI

/**
A default gauge style for the CTGauge view.

This style is used as the default and returns the CircularGaugeStyle as the default style.
*/
struct DefaultCTGaugeStyle: CTGaugeStyle {
    func makeBody(configuration: Configuration) -> some View {
        return CircularGaugeStyle()
            .makeBody(configuration: configuration)
    }
}

/**
A type-erased wrapper for CTGaugeStyle.

This allows the CTGaugeStyle to be passed through the environment without having to specify the exact type of CTGaugeStyle.
*/
struct AnyCTGaugeStyle: CTGaugeStyle {
    private var _makeBody: (Configuration) -> AnyView
    
    init<S: CTGaugeStyle>(style: S) {
        _makeBody = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        _makeBody(configuration)
    }
}
