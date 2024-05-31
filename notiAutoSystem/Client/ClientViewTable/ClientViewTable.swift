//
//  ClientViewTable.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/30/24.
//

import SwiftUI

struct ClientViewTable: View {
    @ObservedObject var clientService: ClientService = ClientService()
    
    var body: some View {
        // listado
        List {
            ForEach(clientService.clients) { client in
                VStack {
                    NavigationLink(
                        // edit view
                        destination: ClientViewEditRecord(
                            clientModel: client
                        )
                    ){
                        ClientViewItemTable(client: client)
                    }
                    .padding()
                }
            }
        }
        .onAppear() {
            clientService.getAll()
        }
        .navigationBarTitle("Clientes", displayMode:.inline)
        .toolbar {
            NavigationLink(
                destination: ClientViewNewRecord(clientService: clientService)
            ){
                Text("➕")
            }
        }
    }
}

struct ClientViewTable_Previews: PreviewProvider {
    static var previews: some View {
        ClientViewTable()
    }
}
