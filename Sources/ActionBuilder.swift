//
//  ActionBuilder.swift
//  SwipeActions
//
//  Created by Eugene Kugut on 26.10.2025.
//

import SwiftUI

@resultBuilder
public struct ActionBuilder {
    public static func buildBlock(_ components: Action...) -> [Action] {
        components
    }
}
