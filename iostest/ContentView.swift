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
    @State private var totalRecs = ""
    @State private var recsPerPage = ""
    @State private var currentPage = 1
    @State private var itemsPerPage = 10
    @State private var itemList = [Record]()
//    @State private var totalPages = 1..<2
    let defaults = UserDefaults.standard
    @State private var searchHistory = [String]()
    
    private func fetchData(){
        
        self.searchHistory.append(self.searchText)
        defaults.set(self.searchHistory, forKey: "History")
        self.currentPage = 1
        
        ApiManager.shared.getRecordsFromApi(
            searchString: self.searchText,
            pageNumber: self.currentPage,
            itemsPerPage: self.itemsPerPage,
            completion: {dataIsReady, response in
                
                if (response?.plpResults.records != nil){
                
                    self.itemList = response!.plpResults.records
                    self.totalRecs = String(response!.plpResults.plpState.totalNumRecs)
                    self.recsPerPage = String(response!.plpResults.plpState.recsPerPage)
//                  self.totalPages = 1..<(Int(self.totalRecs)! / Int(self.recsPerPage)!)
                } else {
                    return
                }
        })
        
        self.searchHistory = self.defaults.object(forKey: "History") as? [String] ?? [String]()
        
    }
    
    var body: some View {
        VStack {
            TextField("Buscar un producto",text: $searchText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(10.0)
                .contextMenu {
                    ForEach (self.searchHistory, id: \.self) {item in
                        Button(action: {
                            self.searchText = item
                            self.fetchData()
                        }) {
                            Text(item)
                        }
                    }
            }
        
            
            Button(action: {
                
                if (self.searchText.isEmpty){
                    return
                } else {
                    self.fetchData()
                }
                
                
            }) {
                Text("Buscar Productos")
                    .foregroundColor(.white)
                    .padding(.all)
                    .cornerRadius(5.0)
            }.background(Color.blue)
            
            HStack {
                Text("Encontrados: \(self.totalRecs)")
                Spacer()
                Text("Mostrando: \(self.itemsPerPage)")
                .contextMenu {
                    Text("Mostrar Productos en Pagina")
                    Button(action: {
                        self.itemsPerPage = 10
                        self.fetchData()
                    }) {
                        Text("10")
                    }

                    Button(action: {
                        self.itemsPerPage = 25
                        self.fetchData()
                    }) {
                        Text("25")
                    }
                    
                    Button(action: {
                       self.itemsPerPage = 50
                        self.fetchData()
                    }) {
                        Text("50")
                    }
                }
            }.padding(10.0)
            
            List {
                ForEach(self.itemList) { recordItem in
                    ItemRow(item: recordItem)
                }
            }
            
            HStack {
                Button(action: {
                    if (self.currentPage == 1){
                        return
                    } else {
                        self.currentPage = self.currentPage - 1
                        self.fetchData()
                    }
                }) {
                    Text("<").foregroundColor(.white)
                        .padding(.all)
                        .cornerRadius(5.0)
                    }.background(Color.blue)
                
                Spacer()
                
                Text("Pagina: \(self.currentPage)")
//                .contextMenu {
//
//                        Text("Navegar a Pagina")
//                    ForEach (self.totalPages) { n in
//                            Button(action: {
//                               self.itemsPerPage = 50
//                                self.fetchData()
//                            }) {
//                                Text(String(n))
//                            }
//                        }
//
//
//                }
                
                Spacer()
                Button(action: {
                    if (self.currentPage == (Int(self.totalRecs)! / Int(self.recsPerPage)!)){
                        return
                    } else {
                        self.currentPage = self.currentPage + 1
                        self.fetchData()
                    }
                }) {
                    Text(">").foregroundColor(.white)
                        .padding(.all)
                    .cornerRadius(5.0)
                    }.background(Color.blue)
                
            }.padding(10.0)
            
            
        }.onAppear{
            self.searchHistory = self.defaults.object(forKey: "History") as? [String] ?? [String]()
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
