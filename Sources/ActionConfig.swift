//
//  ActionConfig.swift
//  SwipeActions
//
//  Created by Eugene Kugut on 26.10.2025.
//

import Foundation

public struct ActionConfig {
    let leadingPadding: CGFloat
    let trailingPadding: CGFloat
    let spacing: CGFloat
    let occupiesFullWidth: Bool

    public init(leadingPadding: CGFloat = 8, trailingPadding: CGFloat = 8, spacing: CGFloat = 8, occupiesFullWidth: Bool = false) {
        self.leadingPadding = leadingPadding
        self.trailingPadding = trailingPadding
        self.spacing = spacing
        self.occupiesFullWidth = occupiesFullWidth
    }
}
