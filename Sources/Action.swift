//
//  Action.swift
//  SwipeActions
//
//  Created by Eugene Kugut on 26.10.2025.
//

import SwiftUI

public struct Action: Identifiable {
    public let id: String
    let symbolImage: String
    let tint: Color
    let background: Color
    let font: Font
    let fontWeight: Font.Weight
    let action: (inout Bool) -> Void

    public init(
        id: String = UUID().uuidString,
        symbolImage: String,
        tint: Color,
        background: Color,
        font: Font = .title2,
        fontWeight: Font.Weight = .regular,
        action: @escaping (inout Bool) -> Void
    ) {
        self.id = id
        self.symbolImage = symbolImage
        self.tint = tint
        self.background = background
        self.font = font
        self.fontWeight = fontWeight
        self.action = action
    }
}
