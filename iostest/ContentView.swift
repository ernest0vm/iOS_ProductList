//
//  ContentView.swift
//  iostest
//
//  Created by Ernesto Valdez on 30/06/20.
//  Copyright © 2020 Ernesto Valdez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchText = ""
    @State private var itemList = [Record]()
    
    var body: some View {
        VStack {
            TextField("Buscar un producto",text: $searchText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(10.0)
            
            Button(action: {
                ApiManager.shared.getRecordsFromApi(
                    searchString: self.searchText,
                    completion: {dataIsReady, records in
                    self.itemList = records
                })
            }) {
                Text("Buscar Productos")
            }
            
            
            
            List {
                ForEach(self.itemList) { recordItem in
                    ItemRow(item: recordItem)
                }
            }
        }
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
