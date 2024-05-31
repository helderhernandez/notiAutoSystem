//
//  ClientViewItemTable.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/30/24.
//

import SwiftUI

struct ClientViewItemTable: View {
    var client: ClientModel
    
    var body: some View {
       
        VStack(alignment: .leading){
            Text(client.name).font(.title)
            Text("💳 DUI: \(client.dui)").font(.subheadline)
            Divider()
            //Text("🛠 Skills: \(client.skills.joined(separator: ", "))")
        }
    }
}

struct ClientViewItemTable_Previews: PreviewProvider {
    static var previews: some View {
        let clientExample = ClientModel(
            id: "0001",
            name: "Maraleni Diaz",
            dui: "05023937-7",
            phone: "2282-4545",
            address: "Mejicanos, col. Buena Vista",
            vehicles: [
                VehicleModel( 
                    brand: "TOYOTA",
                    model:"yaris",
                    logo:"toyota",
                    chassisNumber:"456789456",
                    yearManufacture: 2012
                )
            ]
        )
        
        ClientViewItemTable(
            client: clientExample
        )
    }
}
