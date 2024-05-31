//
//  PSViewEditRecord.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/31/24.
//

import SwiftUI

struct ProductServiceFormEditRecord {
    var description: String
    var pricing: Double
    var type: String
}

struct PSViewEditRecord: View {
   
    @State private var documentId: String
    
    @State private var form : ProductServiceFormEditRecord
    
    init(productServiceModel: ProductServiceModel){
        _documentId = State(initialValue: productServiceModel.id!)
        _form = State(initialValue: ProductServiceFormEditRecord(
            description: productServiceModel.description,
            pricing: productServiceModel.pricing,
            type: productServiceModel.type
        ))
    }
    
    @State var invalidForm : Bool = false
    
    var psService: PSServcie = PSServcie()
    
    @Environment(\.presentationMode) var presentationMode
    
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
                
                // update in firestore
                psService.update(
                    productServiceDocumentId: documentId,
                    productServiceForm: form
                )
                
                self.presentationMode.wrappedValue.dismiss() // close view
            }) {
                Text("✅ Actualizar")
            }
            
            Button(action: {             
                // delete in firestore
                psService.delete(productServiceDocumentId: documentId)
                
                self.presentationMode.wrappedValue.dismiss() // close view
            }) {
                Text("🗑 Eliminar").foregroundColor(.red)
            }
        }
        .navigationBarTitle("Editar Producto/Servicio", displayMode:.inline)
    }
}

struct PSViewEditRecord_Previews: PreviewProvider {
    static var previews: some View {
        let productServiceExample = ProductServiceModel(
            id: "0001",
            description: "Cambio de aceite y filtro",
            pricing: 2.0,
            type: "SERVICIO"
        )
        
        PSViewEditRecord(productServiceModel: productServiceExample)
    }
}