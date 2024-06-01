//
//  PSViewTable.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/31/24.
//

import SwiftUI

struct PSViewTable: View {
    @ObservedObject var psService: PSServcie = PSServcie()
    
    var body: some View {
        // listado
        List {
            ForEach(psService.productsServices) { item in
                VStack {
                    NavigationLink(
                        // edit view
                        destination: PSViewEditRecord(
                            productServiceModel: item
                        )
                    ){
                        PSViewItemTable(productService: item)
                    }
                    .padding()
                }
            }
        }
        .onAppear() {
            psService.getAll()
        }
        .navigationBarTitle("Productos y Servicios", displayMode:.inline)
        .toolbar {
            NavigationLink(
                destination: PSViewNewRecord(psService: psService)
            ){
                Text("➕")
            }
        }
    }
}

struct PSViewTable_Previews: PreviewProvider {
    static var previews: some View {
        PSViewTable()
    }
}