//
//  GeometryGetterMod.swift
//  AudioInterativoSwiftUI
//
//  Created by Frederico Lacis de Carvalho on 06/11/20.
//

import Foundation
import SwiftUI

struct GeometryGetterMod: ViewModifier {

    @Binding var rect: CGRect

    func body(content: Content) -> some View {
        return GeometryReader { (g) -> Color in // (g) -> Content in - is what it could be, but it doesn't work
            DispatchQueue.main.async { // to avoid warning
                self.rect = g.frame(in: .global)
            }
            return Color.clear // return content - doesn't work
        }
    }
}
