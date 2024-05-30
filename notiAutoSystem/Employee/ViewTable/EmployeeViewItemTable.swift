//
//  EmployeeViewItemTable.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/28/24.
//

import SwiftUI

struct EmployeeViewItemTable: View {
    var employee: EmployeeModel
    
    @ObservedObject var employeeService: EmployeeService
    
    var body: some View {
       
        VStack(alignment: .leading){
            Text(employee.name).font(.title)
            Text("💳 DUI: \(employee.dui)").font(.subheadline)
            Divider()
            Text("🛠 Skills: \(employee.skills.joined(separator: ", "))")
            Divider()
            
            Button(action: {
                employeeService.delete(employee: employee) // delete in firestore
            }) {
                Text("Eliminar")
            }
        }
    }
}

struct EmployeeViewItemTable_Previews: PreviewProvider {
    static var previews: some View {
        var employeeExample = EmployeeModel(
            id: "0001",
            name: "Maraleni Diaz",
            dui: "05023937-7",
            phone: "2282-4545",
            address: "Mejicanos, col. Buena Vista",
            skills: ["Torno", "Enderazado y pintura", "Electromecanico"]
        )
        EmployeeViewItemTable(
            employee: employeeExample,
            employeeService: EmployeeService()
        )
    }
}
