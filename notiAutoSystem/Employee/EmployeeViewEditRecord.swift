//
//  EmployeeViewEditRecord.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/28/24.
//

import SwiftUI

struct EmployeeFormEditRecord {
    var name: String
    var dui: String
    var phone: String
    var address: String
    var skills: [String]
}

struct EmployeeViewEditRecord: View {
   
    @State private var employeeDocumentId: String
    
    @State private var employeeForm : EmployeeFormEditRecord
    
    init(employeeModel: EmployeeModel){
        _employeeDocumentId = State(initialValue: employeeModel.id!)
        _employeeForm = State(initialValue: EmployeeFormEditRecord(
            name: employeeModel.name,
            dui: employeeModel.dui,
            phone: employeeModel.phone,
            address: employeeModel.address,
            skills: employeeModel.skills
        ))
    }
    
    @State var invalidForm : Bool = false
    
    var body: some View {
        Form {
            
            if(invalidForm){
                Text("Formulario invalido, se requiere por lo menos un nombre")
            }
            
            Section(header: Text("Información del empleado")) {
                TextField("Nombre", text: $employeeForm.name)
                TextField("DUI", text: $employeeForm.dui)
                TextField("Celular", text: $employeeForm.phone)
                TextField("Dirección", text: $employeeForm.address)
            }
            
            /*
            Section(header: Text("Skills")) {
                
                ForEach(employeeForm.skills.indices, id: \.self) { index in
                    TextField("Skill \(index + 1)", text: $employeeForm.skills[index])
                }
                
                TextField("Experto en aceite", text: $newSkill)

                Button(action: {
                    employeeForm.skills.append(newSkill)
                    newSkill = ""
                }) {
                    Text("Push Skill")
                }
            }*/
            
            /*
            Button(action: {
                if(employeeForm.name == ""){
                    invalidForm = true;
                    
                    // cerramos el mensaje de error luego de un tiempo
                    _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
                        invalidForm = false;
                    }

                    return;
                }
                
                invalidForm = false;
                employeeService.create(employeeForm: employeeForm) // save in firestore
                self.presentationMode.wrappedValue.dismiss() // close view
            }) {
                Text("Guardar")
            }*/
        }
        //.navigationTitle("Registrar")
        //.navigationBarTitleDisplayMode(.inline)
        //.navigationBarHidden(false)
        .navigationBarTitle("Editar Empleado", displayMode:.inline)
        /*
        VStack{
            Text(employeeDocumentId)
            Text(employeeForm.name)
            Text(employeeForm.address)
            Text(employeeForm.skills.joined(separator: ", "))
        }*/
    }
}

struct EmployeeViewEditRecord_Previews: PreviewProvider {
    static var previews: some View {
        let employeeExample = EmployeeModel(
            id:"00001",
            name: "Maraleni Diaz",
            dui: "05023937-7",
            phone: "2233-4455",
            address: "Mejicanos, S.S",
            skills: ["Mecanico automotriz Senior", "Electrico"]
        )
        
        EmployeeViewEditRecord(employeeModel: employeeExample)
    }
}
