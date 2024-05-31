//
//  PSViewNewRecord.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/31/24.
//

import SwiftUI

struct ProductServcieFormNewRecord {
    var description: String
    var pricing: Double
    var type: String
}

struct PSViewNewRecord: View {
    @State private var form = ProductServcieFormNewRecord(
            description: "",
            pricing: 0,
            type: "PRODUCTO"
    )

    let types = ["PRODUCTO", "SERVICIO"]
        
    var psService: PSServcie = PSServcie()
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var invalidForm : Bool = false
    
    var body: some View {
        Form {
            
            Section(header: Text("Información del Producto/Servicio")) {
                TextField("Descripción", text: $form.description)
                TextField("Precio", value: $form.pricing, formatter: NumberFormatter.currency)
                
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
                if(form.description == "" || form.pricing == 0){
                    invalidForm = true;
                    
                    // cerramos el mensaje de error luego de un tiempo
                    _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                        invalidForm = false;
                    }

                    return;
                }
                
                invalidForm = false; // clean error
                
                // save in firestore
                psService.create(productoServicioForm: form)
                
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