//
//  ClientViewEditRecord.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/30/24.
//

import SwiftUI

struct VehicleFormEdit: Decodable, Encodable {
    var brand: String
    var model: String
    var logo: String
    var chassisNumber: String
    var yearManufacture: Int
}

struct ClientFormEditRecord {
    var name: String
    var dui: String
    var phone: String
    var address: String
    var vehicles: [VehicleFormEdit]
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
            address: clientModel.address,
            vehicles: [] //clientModel.vehicles
        ))
    }
    
    @State var invalidForm : Bool = false
    
    @State var newVehicle : VehicleFormNew = VehicleFormNew( 
                brand: "",
                model:"",
                logo:"",
                chassisNumber:"",
                yearManufacture: 2000
            )
    
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
            
            
            /*
            Section(header: Text("Skills")) {
                
                ForEach(clientForm.vehicles.indices, id: \.self) { index in
                    TextField("Skill \(index + 1)", text: $clientForm.vehicles[index])
                }
                
                TextField("e.g: Experto en aceite", text: $newSkill)

                Button(action: {
                    clientForm.vehicles.append(newSkill)
                    newSkill = ""
                }) {
                    Text("➕ Push Skill")
                }
            }*/
            
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
        
        ClientViewEditRecord(clientModel: clientExample)
    }
}
