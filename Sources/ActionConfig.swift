//
//  ActionConfig.swift
//  SwipeActions
//
//  Created by Eugene Kugut on 26.10.2025.
//

import SwiftUI

public struct ActionConfig {
    let leadingPadding: CGFloat
    let trailingPadding: CGFloat
    let spacing: CGFloat
    let occupiesFullWidth: Bool
    let size: CGSize
    let actionShape: ActionShape
    let alignment: VerticalAlignment
    let verticalPadding: CGFloat

    public init(
        leadingPadding: CGFloat = 8,
        trailingPadding: CGFloat = 8,
        spacing: CGFloat = 8,
        occupiesFullWidth: Bool = false,
        size: CGSize = .init(width: 45, height: 45),
        shape: ActionShape = .circle,
        alignment: VerticalAlignment = .center,
        verticalPadding: CGFloat = 0
    ) {
        self.leadingPadding = leadingPadding
        self.trailingPadding = trailingPadding
        self.spacing = spacing
        self.occupiesFullWidth = occupiesFullWidth
        self.size = size
        self.actionShape = shape
        self.alignment = alignment
        self.verticalPadding = verticalPadding
    }
}
