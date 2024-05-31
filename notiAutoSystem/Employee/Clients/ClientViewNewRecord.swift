//
//  ClientViewNewRecord.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/30/24.
//

import SwiftUI

struct VehicleFormNew: Decodable, Encodable {
    var brand: String
    var model: String
    var logo: String
    var chassisNumber: String
    var yearManufacture: Int
}

struct ClientFormNewRecord {
    var name: String
    var dui: String
    var phone: String
    var address: String
    var vehicles: [VehicleFormNew]
}

struct ClientViewNewRecord: View {
    @State private var clientForm = ClientFormNewRecord(
            name: "",
            dui: "",
            phone: "",
            address: "",
            vehicles: []
    )
    
    
    var clientService: ClientService = ClientService()
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var newVehicle : VehicleFormNew = VehicleFormNew( 
                brand: "",
                model:"",
                logo:"",
                chassisNumber:"",
                yearManufacture: 2000
            )
    
    @State var invalidForm : Bool = false
    
    var body: some View {
        Form {
            
            Section(header: Text("Información del cliente")) {
                TextField("Nombre", text: $clientForm.name)
                TextField("DUI", text: $clientForm.dui)
                TextField("Celular", text: $clientForm.phone)
                TextField("Dirección", text: $clientForm.address)
            }
            
            /*
            Section(header: Text("Skills")) {
                
                ForEach(clientForm.vehicles.indices, id: \.self) { index in
                    TextField("Skill \(index + 1)", text: $clientForm.vehicles[index])
                }
                
                TextField("e.g: Experto en aceite", text: $newVehicle)

                Button(action: {
                    clientForm.vehicles.append(newVehicle)
                    newVehicle = ""
                }) {
                    Text("➕ Push Skill")
                }
            }
            */
            
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
