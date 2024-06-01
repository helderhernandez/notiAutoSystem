//
//  PSViewNewRecord.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/31/24.
//

import SwiftUI

struct ProductServcieFormNewRecord {
    var description: String
    var pricing: String
    var type: String
}

struct PSViewNewRecord: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var psService: PSServcie = PSServcie()
    
    @State private var form = ProductServcieFormNewRecord(
            description: "",
            pricing: "0.00",
            type: "PRODUCTO"
    )
    
    @State var invalidForm : Bool = false
    
    let types = ["PRODUCTO", "SERVICIO"]
    
    var body: some View {
        Form {
            
            Section(header: Text("Información del Producto/Servicio")) {
                TextField("Descripción", text: $form.description)
                TextField("Precio", text: $form.pricing)
                
                
                Picker("Tipo", selection: $form.type) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            if(invalidForm){
                Text("Formulario invalido, se requiere la descripción y el precio")
            }
            
            Button(action: {
                
                if(form.description == ""){
                    invalidForm = true;
                    
                    // cerramos el mensaje de error luego de un tiempo
                    _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                        invalidForm = false;
                    }

                    return;
                }
                
                invalidForm = false; // clean error
                
                // save in firestore
                psService.create(productServiceForm: form)
                
                self.presentationMode.wrappedValue.dismiss() // close view
            }) {
                Text("✅ Guardar")
            }
        }
        .navigationBarTitle("Crear Producto/Servicio", displayMode:.inline)
    }
}

struct PSViewNewRecord_Previews: PreviewProvider {
    static var previews: some View {
        PSViewNewRecord()
    }
}
