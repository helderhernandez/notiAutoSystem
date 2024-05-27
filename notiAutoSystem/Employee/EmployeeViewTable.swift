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
        // listado de links
        List {
            ForEach(employeeService.employees) { employee in
                VStack {
                    Text(employee.name)
                        .bold()
                        .lineLimit(4)
                        .padding(.bottom, 8)
                    Text(employee.dui)
                        .foregroundColor(.gray)
                        .font(.caption)
                    /*
                    HStack {
                        Spacer()
                        if link.isCompleted {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .foregroundColor(.blue)
                                .frame(width: 10, height: 10)
                        }
                        if link.isFavorited {
                            Image(systemName: "star.fill")
                                .resizable()
                                .foregroundColor(.yellow)
                                .frame(width: 10, height: 10)
                        }
                        
                        Button(action: {
                            linkViewModel.updateIsFavorited(link: link)
                        }, label: {
                            Label("Favorito", systemImage: "star.fill")
                        })
                        .tint(.yellow)
                        
                        Button(action: {
                            linkViewModel.updateIsCompleted(link: link)
                        }, label: {
                            Label("Completado", systemImage: "checkmark.circle.fill")
                        })
                        .tint(.blue)
                        
                        Button(action: {
                            linkViewModel.delete(link: link)
                        }, label: {
                            Label("Borrar", systemImage: "trash.fill")
                        })
                        .tint(.red)
                    }
 */
                }
            }
            
        }
        .onAppear() {
            employeeService.getAll()
        }
    }
}

struct EmployeeViewTable_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeViewTable()
    }
}
