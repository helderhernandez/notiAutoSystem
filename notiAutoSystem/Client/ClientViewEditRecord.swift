//
//  ClientViewEditRecord.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/30/24.
//

import SwiftUI

struct ClientFormEditRecord {
    var name: String
    var dui: String
    var phone: String
    var address: String
}

struct ClientViewEditRecord: View {
   
    @State private var clientDocumentId: String
    
    @State private var clientForm : ClientFormEditRecord
    
    init(clientModel: ClientModel){
        _clientDocumentId = State(initialValue: clientModel.id!)
        _clientForm = State(initialValue: ClientFormEditRecord(
            name: clientModel.name,
            dui: clientModel.dui,
            phone: clientModel.phone,
            address: clientModel.address
        ))
    }
    
    @State var invalidForm : Bool = false
    
    var clientService: ClientService = ClientService()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            
            Section(header: Text("Información del cliente")) {
                TextField("Nombre", text: $clientForm.name)
                TextField("DUI", text: $clientForm.dui)
                TextField("Celular", text: $clientForm.phone)
                TextField("Dirección", text: $clientForm.address)
            }
            
            if(invalidForm){
                Text("Formulario invalido, se requiere por lo menos un nombre")
            }
            
            Button(action: {
                if(clientForm.name == ""){
                    invalidForm = true;
                    
                    // cerramos el mensaje de error luego de un tiempo
                    _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                        invalidForm = false;
                    }

                    return;
                }
                
                invalidForm = false; // clean error
                
                // update in firestore
                clientService.update(
                    clientDocumentId: clientDocumentId,
                    clientForm: clientForm
                )
                
                self.presentationMode.wrappedValue.dismiss() // close view
            }) {
                Text("✅ Actualizar")
            }
            
            Button(action: {             
                // delete in firestore
                clientService.delete(clientDocumentId: clientDocumentId)
                
                self.presentationMode.wrappedValue.dismiss() // close view
            }) {
                Text("🗑 Eliminar").foregroundColor(.red)
            }
        }
        .navigationBarTitle("Editar Cliente", displayMode:.inline)
    }
}

struct ClientViewEditRecord_Previews: PreviewProvider {
    static var previews: some View {
        let clientExample = ClientModel(
            id: "0001",
            name: "Maraleni Diaz",
            dui: "05023937-7",
            phone: "2282-4545",
            address: "Mejicanos, col. Buena Vista"
        )
        
        ClientViewEditRecord(clientModel: clientExample)
    }
}
