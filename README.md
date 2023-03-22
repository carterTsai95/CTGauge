# CTGauge

**CTGauge** is your companion to work with Gauge view on iOS.

<p align="center">
    <a href="LICENSE">
        <img src="https://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://swift.org">
        <img src="https://img.shields.io/badge/swift-5.5-brightgreen.svg" alt="Swift 5.5">
    </a>
</p>

</br>

## Features

### Type of Gauges
**CTGauge** currently provides 2 type of common gauges view for customize.


1. A circular gauge style for the CTGauge view.

This style represents the gauge as a circular arc with an indicator dot that moves along the arc based on the gauge value.

```swift
public struct DemoView: View {
    @State var value = 0.0
    private let minValue = 0.0
    private let maxValue = 1.0
    
    public var body: some View {
        VStack {
            /// As default the CTGauge use circular gauge style.
            CTGauge(value: value)
        }
    }
}
```

<p align="center">
    <img src="Assets/dominant_colors.jpg">
</p>

2. A needle gauge style for the CTGauge view.

This style represents the gauge as a circular arc with a needle that rotates around the center based on the gauge value.

With `.ctGaugeStyle(.needleGauge)` ViewModifier, user could change the existing guage style to needleGauge style.

```swift
public struct DemoView: View {
    @State var value = 0.0
    private let minValue = 0.0
    private let maxValue = 1.0
    
    public var body: some View {
        VStack {
            CTGauge(value: value)
        }
        .ctGaugeStyle(.needleGauge)
    }
}
```

---

### Accessibility

**CTGauge** allows the size of the gauge view to be scaled relative to the font size specified by the user's device settings which Apple's native gauge view does not handle font size changes by the user. It can lead to readability and accessibility issues for users who require larger or smaller text sizes. By contrast, the CTGauge view's use of ScaledPointSize ensures that the gauge view remains legible and accessible to all users, regardless of their device settings.



---

### Customization

1. **CTGauge** provides users to add custom minimum and maximum labels to the gauge view. This can be achieved by passing custom view. As default the label will be omitted.

By including the minimum and maximum value labels in the gauge view, users can provide additional context and information about the values being displayed. This is particularly useful when the gauge is being used to show values within a specific range, such as temperature or speed. The labels can be used to indicate the minimum and maximum values, as well as any units of measurement associated with the gauge.

```swift
    CTGauge(
        value: value
    ) {
        Text(minValue, format: .number)
    } maximumValueLabel: {
        Text(maxValue, format: .number)
    }
```

2. **CTGauge** provides several customization functions that allow developers to personalize the appearance of the gauge view. These functions include:


```swift
func ctGaugeForegroundColor(_ color: ShapeStyle) -> some View
```

- This function allows developers to set the foreground color of the CTGauge view. The ShapeStyle parameter can be any valid ShapeStyle such as Color or LinearGradient. The foreground color applies to the gauge's arc.



```swift
func ctIndicatorColor(_ color: ShapeStyle) -> some View
```

- This function allows developers to set the color of the gauge's indicator.


```swift
func ctNeedleColor(_ color: ShapeStyle) -> some View
```

- This function allows developers to set the color of the gauge's needle.


These functions use environment values to apply the specified colors, allowing users to customize the colors at any level of the view hierarchy. For example, the ctGaugeForegroundColor(_:) function sets the ctForegroundColor environment value, which sets the foreground color of the CTGauge view.

</br>

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is the easiest way to install and manage **CTGauge** as a dependecy.  
Simply add **CTGauge** to your dependencies in your `Package.swift` file:
```swift
dependencies: [
    .package(url: "https://github.com/tsaihong1995/CTGauge")
]
```

Alternatively, you can also use XCode to add **CTGauge** to your existing project, by using `File > Swift Packages > Add Package Dependency...`.

### Manually

**CTGauge** can also be added to your project manually. Download the **CTGauge** project from Github, then drag and drop the folder `CTGauge` into your XCode project.

</br>
