//
//  PSViewItemTable.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/31/24.
//

import SwiftUI

struct PSViewItemTable: View {
    var productService: ProductServiceModel
    
    var body: some View {
       
        VStack(alignment: .leading){
            Text(productService.description).font(.title)
            Text("⚙️ TIPO: \(productService.type)").font(.subheadline)
            Divider()
            Text("💲 PRECIO: \(productService.pricing)")
        }
    }
}

struct PSViewItemTable_Previews: PreviewProvider {
    static var previews: some View {
        let productServiceExample = ProductServiceModel(
            id: "0001",
            description: "Cambio de aceite y filtro",
            pricing: "2.45",
            type: "SERVICIO"
        )
        
        PSViewItemTable(
            productService: productServiceExample
        )
    }
}
