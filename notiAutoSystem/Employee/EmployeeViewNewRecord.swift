//
//  EmployeeViewNewRecord.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/28/24.
//

import SwiftUI

struct EmployeeFormNewRecord {
    var name: String
    var dui: String
    var phone: String
    var address: String
    var skills: [String]
}

struct EmployeeViewNewRecord: View {
    @State private var employee = EmployeeFormNewRecord(
            name: "John Doe",
            dui: "0502393-7",
            phone: "2255-8899",
            address: "San Francisco, Palo Alto Home #4",
            skills: ["Experto en motores", "Experto en cajas"]
    )
    
    
    @ObservedObject var employeeService: EmployeeService
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Información del empleado")) {
                    TextField("Nombre", text: $employee.name)
                    TextField("DUI", text: $employee.dui)
                    TextField("Celular", text: $employee.phone)
                    TextField("Dirección", text: $employee.address)
                }
                
                Section(header: Text("Skills")) {
                    /*
                    ForEach($employee.skills.indices, id: \.self) { index in
                        TextField("Skill \(index + 1)", text: $employee.skills[index])
                    }
 */
                    Button(action: {
                        employee.skills.append("")
                    }) {
                        Text("Agregar Skill")
                    }
                }
                
                Button(action: {
                    let new = EmployeeModel(
                        name: employee.name,
                        dui: employee.dui,
                        phone: employee.phone,
                        address: employee.address,
                        skills: employee.skills
                    )
                    
                    employeeService.create(employee: new)
                    
                    // mostrar un popup
                    // regresar a la vista de empleados
                }) {
                    Text("Guardar")
                }
            }
            .navigationBarTitle("Nuevo empleado")
        }
    }
}

struct EmployeeViewNewRecord_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeViewNewRecord(employeeService: EmployeeService())
    }
}
