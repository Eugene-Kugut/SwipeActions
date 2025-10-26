//
//  Action.swift
//  SwipeActions
//
//  Created by Eugene Kugut on 26.10.2025.
//

import SwiftUI

public enum ActionShape {
    case circle
    case rectangle
    case rounded(radius: CGFloat)
}

//extension ActionShape {
////    @ViewBuilder
//    var shape: some Shape {
//        switch self {
//        case .circle:
//            return .circle
//        case .rectangle:
//            return .roundedRectangle
//        case .rounded(let radius):
//            return .circle //RoundedRectangle(cornerRadius: radius)
//        }
//    }
//}

public struct Action: Identifiable {
    public let id: String
    let symbolImage: String
    let tint: Color
    let background: Color

    let font: Font
    let fontWeight: Font.Weight
    let size: CGSize
    let actionShape: ActionShape
    let action: (inout Bool) -> Void

    public init(
        id: String = UUID().uuidString,
        symbolImage: String,
        tint: Color,
        background: Color,
        font: Font = .title2,
        fontWeight: Font.Weight = .regular,
        size: CGSize = .init(width: 45, height: 45),
        shape: ActionShape = .circle,
        action: @escaping (inout Bool) -> Void
    ) {
        self.id = id
        self.symbolImage = symbolImage
        self.tint = tint
        self.background = background
        self.font = font
        self.fontWeight = fontWeight
        self.size = size
        self.actionShape = shape
        self.action = action
    }
}
