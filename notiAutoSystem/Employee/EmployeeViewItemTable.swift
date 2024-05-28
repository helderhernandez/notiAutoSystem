//
//  EmployeeViewItemTable.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/28/24.
//

import SwiftUI

struct EmployeeViewItemTable: View {
    var employee: EmployeeModel
    
    var body: some View {
       
        HStack{
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .padding()
            
            VStack(alignment: .leading){
                Text(employee.name).font(.title)
                Text("💳 DUI: \(employee.dui)").font(.subheadline)
                Divider()
                Text("🛠 Skills: \(employee.skills.joined(separator: ", "))")
            }
        }
    }
}

struct EmployeeViewItemTable_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeViewItemTable(
            employee: EmployeeModel(
                id: "0001",
                name: "Maraleni Diaz",
                dui: "05023937-7",
                phone: "2282-4545",
                address: "Mejicanos, col. Buena Vista",
                skills: ["Torno", "Enderazado y pintura", "Electromecanico"]
            )
        )
    }
}
