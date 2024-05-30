//
//  MenuView.swift
//  notiAutoSystem
//
//  Created by user208646 on 5/16/24.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        
        NavigationView{
            List {
                NavigationLink(destination: Text("En construccion")){
                    ItemMenuView(iconMenu: "person.fill", labelMenu: "Clientes", descriptionMenu: "Menu de clientes y sus vehiculos")
                }
                
                NavigationLink(destination: EmployeeViewTable()){
                    ItemMenuView(iconMenu: "wrench.fill", labelMenu: "Empleados", descriptionMenu: "Menu de mecanicos y tecnicos")
                }
                
                /*NavigationLink(destination: Text("En construccion")){
                    ItemMenuView(iconMenu: "doc.text.fill", labelMenu: "Facturación", descriptionMenu: "Menu facturas comerciales")
                }*/
                
                NavigationLink(destination: Text("En construccion")){
                    ItemMenuView(iconMenu: "car.fill", labelMenu: "Mantenimiento", descriptionMenu: "Menu de mantenimiento de vehiculos")
                }
                
                NavigationLink(destination: Text("En construccion")){
                    ItemMenuView(iconMenu: "table.fill", labelMenu: "Productos y Servicios", descriptionMenu: "Catalogo de productos y servios")
                }
            }.navigationTitle("Noti Auto System")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(false)
        }
        .navigationViewStyle(StackNavigationViewStyle()) // importante para no regresar el roort al hacer el dismiss()
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
