//
//  Action.swift
//  SwipeActions
//
//  Created by Eugene Kugut on 26.10.2025.
//

import SwiftUI

public struct Action: Identifiable {
    public var id = UUID().uuidString
    public var symbolImage: String
    public var tint: Color
    public var background: Color

    public var font: Font = .title2
    public var fontWeight: Font.Weight = .regular
    public var size: CGSize = .init(width: 45, height: 45)
    public var shape: some Shape = .circle
    public var action: (inout Bool) -> ()
}
