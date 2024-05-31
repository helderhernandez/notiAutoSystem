//
//  ClientViewNewRecord.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/30/24.
//

import SwiftUI

struct ClientFormNewRecord {
    var name: String
    var dui: String
    var phone: String
    var address: String
}

struct ClientViewNewRecord: View {
    @State private var clientForm = ClientFormNewRecord(
            name: "",
            dui: "",
            phone: "",
            address: ""
    )
        
    var clientService: ClientService = ClientService()
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var invalidForm : Bool = false
    
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
                
                // save in firestore
                clientService.create(clientForm: clientForm)
                
                self.presentationMode.wrappedValue.dismiss() // close view
            }) {
                Text("✅ Guardar")
            }
        }
        .navigationBarTitle("Crear Cliente", displayMode:.inline)
    }
}

struct ClientViewNewRecord_Previews: PreviewProvider {
    static var previews: some View {
        ClientViewNewRecord()
    }
}
