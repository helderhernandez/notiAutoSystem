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
        NavigationView{
            // listado de empleados
            List {
                ForEach(employeeService.employees) { employee in
                    VStack {
                        NavigationLink(destination: EmployeeViewNewRecord()){
                            EmployeeViewItemTable(employee: employee)
                        }
                    }
                }
            }
            .onAppear() {
                employeeService.getAll()
            }
            //.navigationBarTitleDisplayMode(.inline)
            //.navigationBarHidden(false)
            .navigationBarTitle("Empleados", displayMode:.inline)
            .toolbar {
                NavigationLink(destination: EmployeeViewNewRecord()){
                    Text("➕")
                }
            }
        }
       
    }
}

struct EmployeeViewTable_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeViewTable()
    }
}
