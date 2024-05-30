//
//  EmployeeTableView.swift
//  notiAutoSystem
//
//  Created by user208646 on 5/16/24.
//

import SwiftUI

struct EmployeeViewTable: View {
    @ObservedObject var employeeService: EmployeeService = EmployeeService()
    
    var body: some View {
        // listado de empleados
        List {
            ForEach(employeeService.employees) { employee in
                VStack {
                    NavigationLink(destination: EmployeeViewEditRecord()){
                        EmployeeViewItemTable(
                            employee: employee,
                            employeeService: employeeService
                        )
                    }
                }
            }
        }
        .onAppear() {
            employeeService.getAll()
        }
        //.navigationTitle("Empleados")
        //.navigationBarTitleDisplayMode(.inline)
        //.navigationBarHidden(false)
        //.navigationBarTitleDisplayMode(.inline)
        //.navigationBarHidden(false)
        .navigationBarTitle("Empleados", displayMode:.inline)
        .toolbar {
            NavigationLink(
                destination: EmployeeViewNewRecord(employeeService: employeeService)
            ){
                Text("➕")
            }
        }
    }
}

struct EmployeeViewTable_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeViewTable()
    }
}
