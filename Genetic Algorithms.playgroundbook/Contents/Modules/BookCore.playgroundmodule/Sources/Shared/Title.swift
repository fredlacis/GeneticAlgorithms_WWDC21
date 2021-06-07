//
//  Title.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 13/04/21.
//

import SwiftUI

struct Title: View {
    
    var title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(.custom("Montserrat-Regular", size: 30))
            .padding(.bottom)
    }
}
