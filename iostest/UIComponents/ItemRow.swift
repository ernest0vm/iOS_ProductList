//
//  ItemRow.swift
//  iostest
//
//  Created by Ernesto Valdez on 30/06/20.
//  Copyright © 2020 Ernesto Valdez. All rights reserved.
//

import Foundation
import SwiftUI

struct ItemRow: View {
    var item: Record
    @Environment(\.imageCache) var cache: ImageCache

    var body: some View {
        HStack(alignment: .center, spacing: 5.0) {
            AsyncImage(
                url: URL(string: item.smImage)!,
                cache: self.cache,
                placeholder: Text("Cargando..."),
                configuration: { $0.resizable() }
             )
            .frame(width: 150.0, height: 150.0)
            .padding(5.0)
            
            VStack(alignment: .leading, spacing: 3.0) {
                Text(item.productDisplayName)
                Spacer()
                Text("$ \(item.listPrice)")
                Spacer()
            }
        }
    }
}
